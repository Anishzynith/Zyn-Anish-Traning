codeunit 50117 "ContactSyncMgt."
{
    var
        IsSyncing: Boolean;


    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeInsertEvent', '', true, true)]
    local procedure ValidateContactInsert(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynithCompany: Record "ZynithCompany";
    begin
        // Validate that the current company is selected
        ZynithCompany.SetRange(Name, CompanyName);
        ZynithCompany.SetRange("Is_Master", true);
        if not ZynithCompany.FindFirst() then
            Error('Cannot create contact. The company "%1" is not Master.', CompanyName);
    end;
    // ---------------------------------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterInsertEvent', '', true, true)]
    local procedure InsertContactRecord(var Rec: Record Contact)
    var
        CurrentCompany: Record ZynithCompany;
        DependentCompany: Record ZynithCompany;
        TargetContact: Record Contact;
    begin
        if not CurrentCompany.Get(CompanyName()) then
            exit;
        if not CurrentCompany."Is_Master" then
            exit;
        DependentCompany.Reset();
        DependentCompany.SetRange("Master_Company", CurrentCompany.Name);
        if DependentCompany.FindSet() then
            repeat
                if DependentCompany."Master_Company" <> '' then begin
                    TargetContact.ChangeCompany(DependentCompany.Name);
                    if not TargetContact.Get(Rec."No.") then begin
                        TargetContact.Init();
                        TargetContact.TransferFields(Rec);
                        TargetContact.Insert(true);
                    end;
                end;
            until DependentCompany.Next() = 0;
    end;

    // -----------------------------------------------------------------------------------------------------

    // [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    // local procedure ContactOnAfterModify(var Rec: Record Contact; RunTrigger: Boolean)
    // var
    //     CurrentCompany: Record Zynith_Company;
    //     SlaveCompany: Record Zynith_Company;
    // begin
    //     // Only master company runs the sync
    //     if not CurrentCompany.Get(CompanyName()) then
    //         exit;
    //     if not CurrentCompany."Is Master" then
    //         exit;

    //     // Update all slave companies
    //     SlaveCompany.Reset();
    //     SlaveCompany.SetRange("Master Company", CompanyName());
    //     if SlaveCompany.FindSet() then
    //         repeat
    //             UpdateContactInSlaveCompany(Rec, SlaveCompany.Name);
    //         until SlaveCompany.Next() = 0;
    // end;

    // ---------------------------------------------------------------------------------------------------
    // local procedure UpdateContactInSlaveCompany(SourceContact: Record Contact; TargetCompany: Text)
    // var
    //     ContactSlave: Record Contact;
    // begin
    //     ContactSlave.ChangeCompany(TargetCompany);

    //     if ContactSlave.Get(SourceContact."No.") then begin
    //         // Only modify if the Modified Date is different
    //         if ContactSlave.SystemModifiedAt <> SourceContact.SystemModifiedAt then begin
    //             ContactSlave.TransferFields(SourceContact);
    //             ContactSlave.Modify(false); // false prevents recursion
    //         end;
    //     end else begin
    //         // Insert if it does not exist
    //         ContactSlave.Init();
    //         ContactSlave.TransferFields(SourceContact);
    //         ContactSlave.Insert(true);
    //     end;
    // end;

    //  ---------------------------------------------------------------------------------------------------
    var
    // Prevent deletion in slave company

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure ContactOnBeforeDelete(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record ZynithCompany;
    begin
        if ZynCompany.Get(COMPANYNAME) then begin
            if (not ZynCompany."Is_Master") and (ZynCompany."Master_Company" <> '') then
                Error(DeleteContactInSlaveErr);
        end;
    end;

    // ----------------------------------------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    local procedure ContactOnAfterModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    var
        MasterCompany: Record ZynithCompany;
        SlaveCompany: Record ZynithCompany;
        SlaveContact: Record Contact;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
    begin
        if IsSyncing then
            exit;
        if MasterCompany.Get(COMPANYNAME) then begin
            if MasterCompany."Is_Master" then begin
                SlaveCompany.Reset();
                SlaveCompany.SetRange("Master_Company", MasterCompany.Name);
                if SlaveCompany.FindSet() then
                    repeat
                        SlaveContact.ChangeCompany(SlaveCompany.Name);
                        if SlaveContact.Get(Rec."No.") then begin
                            // Open RecordRefs
                            MasterRef.GetTable(Rec);
                            SlaveRef.GetTable(SlaveContact);
                            IsDifferent := false;
                            // Loop through all fields
                            for i := 1 to MasterRef.FieldCount do begin
                                Field := MasterRef.FieldIndex(i);
                                // Skip FlowFields or non-normal fields
                                if Field.Class <> FieldClass::Normal then
                                    continue;
                                // Skip primary key fields (like "No.")
                                if Field.Number in [1] then
                                    continue;
                                SlaveField := SlaveRef.Field(Field.Number);
                                if SlaveField.Value <> Field.Value then begin
                                    IsDifferent := true;
                                    break; // no need to check further
                                end;
                            end;
                            // Only transfer fields if there is a difference
                            if IsDifferent then begin
                                IsSyncing := true;
                                SlaveContact.TransferFields(Rec, false);
                                SlaveContact."No." := Rec."No."; // restore PK
                                SlaveContact.Modify(true);
                                IsSyncing := false;
                            end;
                        end;
                    until SlaveCompany.Next() = 0;
            end;
        end;
    end;

    var
        CreateContactInSlaveErr: Label 'You cannot create contacts in a slave company. Create the contact in the master company only.';
        ModifyContactInSlaveErr: Label 'You cannot modify contacts in a slave company. Modify contacts only in the master company.';
        DeleteContactInSlaveErr: Label 'You cannot delete contacts in a slave company. Delete contacts only in the master company.';
}
