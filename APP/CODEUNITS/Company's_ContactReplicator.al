codeunit 50154 "ZYN_Customer_Replicator"
{
    Subtype = Normal;

    // --------------------------
    // Main Entry Point: Replicate Customer and related data
    // --------------------------
    procedure SendCustomerToSlave(var MasterCust: Record Customer; SlaveCompany: Text[30])
    var
        SlaveCust: Record Customer;
        SyncedContacts: Dictionary of [Code[20], Boolean];
        CustMap: Record "Customer_Mapping";
    begin
        if MasterCust."No." = '' then
            exit;

        // --- Step 0: Cleanup invalid Lookup Contacts ---
        CleanupInvalidLookups(MasterCust);

        // --- Step 1: Sync Primary Contact ---
        if MasterCust."Primary Contact No." <> '' then
            SyncContactToSlave(MasterCust."Primary Contact No.", SlaveCompany, SyncedContacts);

        // --- Step 2: Check Customer Mapping ---
        if CustMap.Get(MasterCust."No.", SlaveCompany) then begin
            SlaveCust.ChangeCompany(SlaveCompany);
            if SlaveCust.Get(CustMap."Slave Customer No.") then begin
                SlaveCust.TransferFields(MasterCust, true);

                // Ensure valid Contact
                if not ContactExistsInSlave(MasterCust."Primary Contact No.", SlaveCompany) then
                    SlaveCust."Primary Contact No." := '';

                SlaveCust.Modify();
                Message('Customer updated in Slave: %1 (%2)', SlaveCust.Name, SlaveCust."No.");
            end;
            exit;
        end;

        // --- Step 3: Create new Customer in Slave ---
        SlaveCust.ChangeCompany(SlaveCompany);
        SlaveCust.Init();
        SlaveCust.TransferFields(MasterCust, false);
        SlaveCust."No." := MasterCust."No."; // Preserve master number
        SlaveCust.Insert(false); // Keep master number

        Message('Customer created in Slave: %1 (%2)', SlaveCust.Name, SlaveCust."No.");

        // --- Step 4: Update Mapping ---
        CustMap.Init();
        CustMap."Master Customer No." := MasterCust."No.";
        CustMap."Slave Company" := SlaveCompany;
        CustMap."Slave Customer No." := SlaveCust."No.";
        CustMap.Insert(true);

        // --- Step 5: Sync Business Relations ---
        ReplicateBusinessRelationsForCustomer(MasterCust."No.", SlaveCompany);
    end;

    // --------------------------
    // Cleanup Invalid Lookup Contacts
    // --------------------------
    local procedure CleanupInvalidLookups(var Cust: Record Customer)
    var
        Contact: Record Contact;
    begin
        if Cust."Primary Contact No." <> '' then
            if not Contact.Get(Cust."Primary Contact No.") then
                Cust."Primary Contact No." := '';

        if Cust."Primary Contact No." <> '' then
            if Contact.Get(Cust."Primary Contact No.") then
                if (Contact."Lookup Contact No." <> '') and not Contact.Get(Contact."Lookup Contact No.") then
                    Contact."Lookup Contact No." := '';
    end;

    // --------------------------
    // Contact Replication
    // --------------------------
    local procedure SyncContactToSlave(ContactNo: Code[20]; SlaveCompany: Text[30]; var SyncedContacts: Dictionary of [Code[20], Boolean])
    var
        ContactMaster: Record Contact;
        ContactSlave: Record Contact;
        ContactMap: Record "Customer_Mapping";
    begin
        if ContactNo = '' then
            exit;
        if SyncedContacts.ContainsKey(ContactNo) then
            exit;
        SyncedContacts.Set(ContactNo, true);

        if not ContactMaster.Get(ContactNo) then
            exit;

        // --- Step 1: Ensure Lookup Contact exists ---
        if ContactMaster."Lookup Contact No." <> '' then
            if not ContactExistsInSlave(ContactMaster."Lookup Contact No.", SlaveCompany) then
                SyncContactToSlave(ContactMaster."Lookup Contact No.", SlaveCompany, SyncedContacts);

        // --- Step 2: Check mapping ---
        if ContactMap.Get(ContactNo, SlaveCompany) then begin
            ContactSlave.ChangeCompany(SlaveCompany);
            if ContactSlave.Get(ContactMap."Slave Customer No.") then begin
                ContactSlave.TransferFields(ContactMaster, true);

                // Fix Lookup No
                if ContactMaster."Lookup Contact No." <> '' then
                    ContactSlave."Lookup Contact No." := GetSlaveLookupNo(ContactMaster."Lookup Contact No.", SlaveCompany);

                ContactSlave.Modify();
            end;
            exit;
        end;

        // --- Step 3: Create new Contact in Slave ---
        ContactSlave.ChangeCompany(SlaveCompany);
        ContactSlave.Init();
        ContactSlave.TransferFields(ContactMaster, false);
        ContactSlave."No." := ContactMaster."No."; // Preserve master number
        if ContactMaster."Lookup Contact No." <> '' then
            ContactSlave."Lookup Contact No." := GetSlaveLookupNo(ContactMaster."Lookup Contact No.", SlaveCompany);
        ContactSlave.Insert(false);

        // --- Step 4: Update mapping ---
        ContactMap.Init();
        ContactMap."Master Customer No." := ContactMaster."No.";
        ContactMap."Slave Company" := SlaveCompany;
        ContactMap."Slave Customer No." := ContactSlave."No.";
        ContactMap.Insert(true);
    end;

    local procedure ContactExistsInSlave(ContactNo: Code[20]; SlaveCompany: Text[30]): Boolean
    var
        ContactSlave: Record Contact;
        ContactMap: Record "Customer_Mapping";
    begin
        if ContactNo = '' then
            exit(false);
        if ContactMap.Get(ContactNo, SlaveCompany) then begin
            ContactSlave.ChangeCompany(SlaveCompany);
            exit(ContactSlave.Get(ContactMap."Slave Customer No."));
        end;
        exit(false);
    end;

    local procedure GetSlaveLookupNo(MasterLookupNo: Code[20]; SlaveCompany: Text[30]): Code[20]
    var
        ContactMap: Record "Customer_Mapping";
    begin
        if ContactMap.Get(MasterLookupNo, SlaveCompany) then
            exit(ContactMap."Slave Customer No.");
        exit('');
    end;

    // --------------------------
    // Business Relations Replication
    // --------------------------
    local procedure ReplicateBusinessRelationsForCustomer(MasterCustNo: Code[20]; SlaveCompany: Text[30])
    var
        BRMaster: Record "Contact Business Relation";
        BRSlave: Record "Contact Business Relation";
        ContactMap: Record "Customer_Mapping";
        ContactSlaveNo: Code[20];
        MasterCust: Record Customer;
    begin
        if not MasterCust.Get(MasterCustNo) then
            exit;

        // Get slave contact mapping
        if not ContactMap.Get(MasterCust."Primary Contact No.", SlaveCompany) then begin
            Message('Slave Contact not found for Master Contact %1. Business Relations not replicated.', MasterCust."Primary Contact No.");
            exit;
        end;
        ContactSlaveNo := ContactMap."Slave Customer No.";

        // Iterate Master Contact Business Relations
        BRMaster.Reset();
        BRMaster.SetRange("Contact No.", MasterCust."Primary Contact No.");
        if BRMaster.FindSet() then
            repeat
                BRSlave.ChangeCompany(SlaveCompany);
                BRSlave.Reset();
                BRSlave.SetRange("Contact No.", ContactSlaveNo);
                BRSlave.SetRange("Business Relation Code", BRMaster."Business Relation Code");

                if not BRSlave.FindFirst() then begin
                    BRSlave.Init();
                    BRSlave.TransferFields(BRMaster, true);
                    BRSlave."Contact No." := ContactSlaveNo;
                    BRSlave.Insert(false); // Keep number
                end else begin
                    BRSlave.TransferFields(BRMaster, true);
                    BRSlave."Contact No." := ContactSlaveNo;
                    BRSlave.Modify();
                end;
            until BRMaster.Next() = 0;
    end;
}

