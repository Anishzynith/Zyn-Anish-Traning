// codeunit 50154 ZYN_Customer_Replicator
// {
//     Subtype = Normal;
//     procedure SendCustomerToSlave(var MasterCust: Record Customer; SlaveCompany: Text[30])
//     var
//         SlaveCust: Record Customer;
//         SyncedContacts: Dictionary of [Code[20], Boolean];
//         CustMap: Record "Customer_Mapping";
//     begin
//         if MasterCust."No." = '' then
//             exit;

//         // Step 1: Sync primary contact recursively
//         if MasterCust."Primary Contact No." <> '' then
//             SyncContactToSlave(MasterCust."Primary Contact No.", SlaveCompany, SyncedContacts);

//         // Step 2: Check mapping table
//         if CustMap.Get(MasterCust."No.", SlaveCompany) then begin
//             // Customer already exists in Slave → modify
//             SlaveCust.ChangeCompany(SlaveCompany);
//             if SlaveCust.Get(CustMap."Slave Customer No.") then begin
//                 SlaveCust.Validate("No.", MasterCust."No.");
//                 SlaveCust.TransferFields(MasterCust, true);
//                 if not ContactExistsInSlave(MasterCust."Primary Contact No.", SlaveCompany) then
//                     SlaveCust."Primary Contact No." := '';
//                 SlaveCust.Modify();
//                 Message('Customer updated in Slave: %1 (%2)', SlaveCust.Name, SlaveCust."No.");
//             end;
//             exit;
//         end;

//         // Step 3: Create new customer in Slave
//         SlaveCust.ChangeCompany(SlaveCompany); // change context first
//         SlaveCust.Init();
//         SlaveCust."No." := MasterCust."No.";                  // initialize in Slave
//         SlaveCust.Name := MasterCust.Name;
//         SlaveCust.Address := MasterCust.Address;
//         SlaveCust."City" := MasterCust."City";
//         SlaveCust."Primary Contact No." := MasterCust."Primary Contact No.";
//         // Add any other fields as needed

//         // Insert → BC auto-generates Customer No.
//         SlaveCust.Insert();
//         Message('Customer created in Slave: %1 (%2)', SlaveCust.Name, SlaveCust."No.");

//         // Step 4: Update mapping table
//         CustMap.Init();
//         CustMap."Master Customer No." := MasterCust."No.";
//         CustMap."Slave Company" := SlaveCompany;
//         CustMap."Slave Customer No." := SlaveCust."No.";
//         CustMap.Insert(true);
//     end;

//     // -----------------------------
//     // Recursive Contact Sync
//     // -----------------------------
//     local procedure SyncContactToSlave(ContactNo: Code[20]; SlaveCompany: Text[30]; var SyncedContacts: Dictionary of [Code[20], Boolean])
//     var
//         ContactMaster: Record Contact;
//         ContactSlave: Record Contact;
//     begin
//         if ContactNo = '' then
//             exit;

//         if SyncedContacts.ContainsKey(ContactNo) then
//             exit;

//         SyncedContacts.Set(ContactNo, true);

//         if not ContactMaster.Get(ContactNo) then
//             exit;

//         // Sync Lookup Contact first
//         if (ContactMaster."Lookup Contact No." <> '') and
//            (not ContactExistsInSlave(ContactMaster."Lookup Contact No.", SlaveCompany)) then
//             SyncContactToSlave(ContactMaster."Lookup Contact No.", SlaveCompany, SyncedContacts);

//         // Insert or update Contact in Slave
//         ContactSlave.ChangeCompany(SlaveCompany);
//         if not ContactSlave.Get(ContactNo) then begin
//             ContactSlave.Init();
//             ContactSlave.TransferFields(ContactMaster, true);

//             if (ContactMaster."Lookup Contact No." <> '') and
//                (not ContactExistsInSlave(ContactMaster."Lookup Contact No.", SlaveCompany)) then
//                 ContactSlave."Lookup Contact No." := '';

//             ContactSlave.Insert();
//             Message('Contact %1 created in Slave: %2', ContactNo, SlaveCompany);
//         end else begin
//             ContactSlave.TransferFields(ContactMaster, true);
//             if (ContactMaster."Lookup Contact No." <> '') and
//                (not ContactExistsInSlave(ContactMaster."Lookup Contact No.", SlaveCompany)) then
//                 ContactSlave."Lookup Contact No." := '';
//             ContactSlave.Modify();
//             Message('Contact %1 updated in Slave: %2', ContactNo, SlaveCompany);
//         end;
//     end;

//     // -----------------------------
//     // Check if Contact exists in Slave Company
//     // -----------------------------
//     local procedure ContactExistsInSlave(ContactNo: Code[20]; SlaveCompany: Text[30]): Boolean
//     var
//         ContactSlave: Record Contact;
//     begin
//         if ContactNo = '' then
//             exit(false);

//         ContactSlave.ChangeCompany(SlaveCompany);
//         exit(ContactSlave.Get(ContactNo));
//     end;
// }

//------------------------------------------------------------------------------

codeunit 50154 "ZYN_Customer_Replicator"
{
    Subtype = Normal;

    procedure SendCustomerToSlave(var MasterCust: Record Customer; SlaveCompany: Text[30])
    var
        SlaveCust: Record Customer;
        SyncedContacts: Dictionary of [Code[20], Boolean];
        CustMap: Record "Customer_Mapping";
    begin
        if MasterCust."No." = '' then
            exit;

        // Step 1: Sync primary contact recursively
        if MasterCust."Primary Contact No." <> '' then
            SyncContactToSlave(MasterCust."Primary Contact No.", SlaveCompany, SyncedContacts);

        // Step 2: Check mapping table
        if CustMap.Get(MasterCust."No.", SlaveCompany) then begin
            // Customer exists in Slave → modify
            SlaveCust.ChangeCompany(SlaveCompany);
            if SlaveCust.Get(CustMap."Slave Customer No.") then begin
                SlaveCust.TransferFields(MasterCust, true);
                if not ContactExistsInSlave(MasterCust."Primary Contact No.", SlaveCompany) then
                    SlaveCust."Primary Contact No." := '';
                SlaveCust.Modify();
                Message('Customer updated in Slave: %1 (%2)', SlaveCust.Name, SlaveCust."No.");
            end;
            exit;
        end;

        // Step 3: Create new customer in Slave
        SlaveCust.ChangeCompany(SlaveCompany); // switch context first
        SlaveCust.Init();                       // initialize in Slave
        // Do NOT assign MasterCust."No." → let Slave generate
        SlaveCust.TransferFields(MasterCust, false);
        SlaveCust."No." := MasterCust."No.";
        // SlaveCust.Name := MasterCust.Name;
        // SlaveCust.Address := MasterCust.Address;
        // SlaveCust."City" := MasterCust."City";
        // SlaveCust."Primary Contact No." := MasterCust."Primary Contact No.";
        // Add other fields as needed

        SlaveCust.Insert(); // Auto-generated No.
        Message('Customer created in Slave: %1 (%2)', SlaveCust.Name, SlaveCust."No.");

        // Step 4: Update mapping table
        CustMap.Init();
        CustMap."Master Customer No." := MasterCust."No.";
        CustMap."Slave Company" := SlaveCompany;
        CustMap."Slave Customer No." := SlaveCust."No.";
        CustMap.Insert(true);
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
