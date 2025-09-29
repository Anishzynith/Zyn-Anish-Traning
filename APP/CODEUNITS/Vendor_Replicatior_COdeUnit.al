codeunit 50155 "ZYN_Vendor_Replicator"
{
    Subtype = Normal;

    procedure SendVendorToSlave(var MasterVend: Record Vendor; SlaveCompany: Text[30])
    var
        SlaveVend: Record Vendor;
        SyncedContacts: Dictionary of [Code[20], Boolean];
        VendMap: Record "Vendor_Mapping"; // <-- you must create this table like Customer_Mapping
    begin
        if MasterVend."No." = '' then
            exit;

        // Step 1: Sync primary contact recursively
        if MasterVend."Primary Contact No." <> '' then
            SyncContactToSlave(MasterVend."Primary Contact No.", SlaveCompany, SyncedContacts);

        // Step 2: Check mapping table
        if VendMap.Get(MasterVend."No.", SlaveCompany) then begin
            // Vendor exists in Slave → modify
            SlaveVend.ChangeCompany(SlaveCompany);
            if SlaveVend.Get(VendMap."Slave Vendor No.") then begin
                SlaveVend.TransferFields(MasterVend, true);
                if not ContactExistsInSlave(MasterVend."Primary Contact No.", SlaveCompany) then
                    SlaveVend."Primary Contact No." := '';
                SlaveVend.Modify();
                Message('Vendor updated in Slave: %1 (%2)', SlaveVend.Name, SlaveVend."No.");
            end;
            exit;
        end;

        // Step 3: Create new Vendor in Slave
        SlaveVend.ChangeCompany(SlaveCompany);
        SlaveVend.Init();

        // Copy all fields automatically
        SlaveVend.TransferFields(MasterVend, false);

        // Let Slave Company generate new Vendor No.
        SlaveVend."No." := MasterVend."No.";

        // Insert new Vendor
        SlaveVend.Insert();
        Message('Vendor created in Slave: %1 (%2)', SlaveVend.Name, SlaveVend."No.");

        // Step 4: Update mapping table
        VendMap.Init();
        VendMap."Master Vendor No." := MasterVend."No.";
        VendMap."Slave Company" := SlaveCompany;
        VendMap."Slave Vendor No." := SlaveVend."No.";
        VendMap.Insert(true);
    end;

    local procedure SyncContactToSlave(ContactNo: Code[20]; SlaveCompany: Text[30]; var SyncedContacts: Dictionary of [Code[20], Boolean])
    var
        ContactMaster: Record Contact;
        ContactSlave: Record Contact;
    begin
        if ContactNo = '' then
            exit;

        if SyncedContacts.ContainsKey(ContactNo) then
            exit;

        SyncedContacts.Set(ContactNo, true);

        if not ContactMaster.Get(ContactNo) then
            exit;

        // Sync Lookup Contact first
        if (ContactMaster."Lookup Contact No." <> '') and
           (not ContactExistsInSlave(ContactMaster."Lookup Contact No.", SlaveCompany)) then
            SyncContactToSlave(ContactMaster."Lookup Contact No.", SlaveCompany, SyncedContacts);

        ContactSlave.ChangeCompany(SlaveCompany);
        if not ContactSlave.Get(ContactNo) then begin
            ContactSlave.Init();
            ContactSlave.TransferFields(ContactMaster, true);
            if (ContactMaster."Lookup Contact No." <> '') and
               (not ContactExistsInSlave(ContactMaster."Lookup Contact No.", SlaveCompany)) then
                ContactSlave."Lookup Contact No." := '';
            ContactSlave.Insert();
        end else begin
            ContactSlave.TransferFields(ContactMaster, true);
            if (ContactMaster."Lookup Contact No." <> '') and
               (not ContactExistsInSlave(ContactMaster."Lookup Contact No.", SlaveCompany)) then
                ContactSlave."Lookup Contact No." := '';
            ContactSlave.Modify();
        end;
    end;

    local procedure ContactExistsInSlave(ContactNo: Code[20]; SlaveCompany: Text[30]): Boolean
    var
        ContactSlave: Record Contact;
    begin
        if ContactNo = '' then
            exit(false);

        ContactSlave.ChangeCompany(SlaveCompany);
        exit(ContactSlave.Get(ContactNo));
    end;
}
