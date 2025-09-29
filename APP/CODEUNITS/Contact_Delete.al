codeunit 50144 "ContactDeleteSync"
{
    Subtype = Normal;

    var
        IsDeleting: Boolean;
        IsSyncing: Boolean;

    // --------------------------
    // Validate before deleting contact in master
    // --------------------------
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure ValidateBeforeMasterDelete(var Rec: Record Contact; RunTrigger: Boolean)
    begin
        if not IsMasterCompany() then
            Error(MasterOnlyDeleteCompany);

        if HasOpenInvoicesInSlaves(Rec."No.") then
            Error(DeleteBlockedMsg, Rec."No.");
    end;

    // --------------------------
    // After delete in master: remove from slave companies
    // --------------------------
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnAfterMasterDelete(var Rec: Record Contact)
    begin
        if not IsMasterCompany() then
            exit;

        if IsDeleting then
            exit;

        IsDeleting := true;
        SyncDeleteToSlaves(Rec."No.");
        IsDeleting := false;
    end;

    // --------------------------
    // Check open invoices in all slave companies
    // --------------------------
    local procedure HasOpenInvoicesInSlaves(ContactNo: Code[20]): Boolean
    var
        SlaveComp: Record ZynithCompany;
        Cust: Record Customer;
        Vend: Record Vendor;
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        SlaveComp.SetRange(Is_Master, false);
        if SlaveComp.FindSet() then
            repeat
                // --- Check Customer sales ---
                Cust.ChangeCompany(SlaveComp.Name);
                Cust.SetRange("Primary Contact No.", ContactNo);
                if Cust.FindSet() then
                    repeat
                        SalesHeader.ChangeCompany(SlaveComp.Name);
                        SalesHeader.SetRange("Bill-to Customer No.", Cust."No.");
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                        SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::Released);
                        if SalesHeader.FindFirst() then
                            exit(true);
                    until Cust.Next() = 0;

                // --- Check Vendor purchases ---
                Vend.ChangeCompany(SlaveComp.Name);
                Vend.SetRange("Primary Contact No.", ContactNo);
                if Vend.FindSet() then
                    repeat
                        PurchHeader.ChangeCompany(SlaveComp.Name);
                        PurchHeader.SetRange("Buy-from Vendor No.", Vend."No.");
                        PurchHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                        PurchHeader.SetFilter(Status, '%1|%2', PurchHeader.Status::Open, PurchHeader.Status::Released);
                        if PurchHeader.FindFirst() then
                            exit(true);
                    until Vend.Next() = 0;

            until SlaveComp.Next() = 0;

        exit(false);
    end;

    local procedure SyncDeleteToSlaves(ContactNo: Code[20])
    var
        MyCompany: Record ZynithCompany;
        SlaveCompany: Record ZynithCompany;
        Contact: Record Contact;
        Customer: Record Customer;
        Vendor: Record Vendor;
        ContactBusRel: Record "Contact Business Relation";
    begin
        if not MyCompany.Get(CompanyName()) then
            exit;
        if not IsMasterCompany() then
            exit;
        if IsSyncing then
            exit; // prevent recursion

        IsSyncing := true;

        SlaveCompany.SetRange(Is_Master, false);
        SlaveCompany.SetFilter(Master_Company_Name, '%1', MyCompany.Name);

        if SlaveCompany.FindSet() then
            repeat
                // Switch context to each slave company
                Contact.ChangeCompany(SlaveCompany.Name);
                Customer.ChangeCompany(SlaveCompany.Name);
                Vendor.ChangeCompany(SlaveCompany.Name);
                ContactBusRel.ChangeCompany(SlaveCompany.Name);

                // 1️.Delete relations in Contact Business Relation first
                ContactBusRel.Reset();
                ContactBusRel.SetRange("Contact No.", ContactNo);
                if ContactBusRel.FindSet() then
                    repeat
                        case ContactBusRel."Link to Table" of
                            // 2.Delete related Customer (if exists)
                            ContactBusRel."Link to Table"::Customer:
                                if Customer.get(ContactBusRel."No.") then
                                    Customer.Delete(true);
                            // 3️.Delete related Vendor (if exists)
                            ContactBusRel."Link to Table"::Vendor:
                                if Vendor.get(ContactBusRel."No.") then
                                    Vendor.Delete(true);
                        end;
                        ContactBusRel.Delete(true);
                    until ContactBusRel.Next() = 0;
                // 4️.Delete Contact itself
                if Contact.Get(ContactNo) then
                    Contact.Delete(true);

            until SlaveCompany.Next() = 0;

        IsSyncing := false;
    end;

    local procedure IsMasterCompany(): Boolean
    var
        CompRec: Record ZynithCompany;
    begin
        if not CompRec.Get(COMPANYNAME) then
            exit(false);
        exit(CompRec.Is_Master);
    end;

    var
        MasterOnlyDeleteCompany: Label 'You can delete contacts only from the master company.';
        DeleteBlockedMsg: Label 'Cannot delete contact %1: There are open sales or purchase invoices in one or more slave companies.';
}
