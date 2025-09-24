codeunit 50135 "ZYN_CompanySyncManagement"
{
    Subtype = Normal;

    var
        SyncControl: Codeunit "ZYN_CompanySyncControl";
    // --- Company Table Subscribers ---
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnCompanyInsert(var Rec: Record Company; RunTrigger: Boolean)
    var
        Zynith: Record ZynithCompany;
    begin
        if SyncControl.IsInProgress() then
            exit;
        SyncControl.SetInProgress(true);
        if not Zynith.Get(Rec.Name) then begin
            Zynith.Init();
            Zynith.Name := Rec.Name;
            Zynith."Display Name" := Rec."Display Name";
            Zynith.Insert();
        end;
        SyncControl.SetInProgress(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnCompanyModify(var Rec: Record Company; RunTrigger: Boolean)
    var
        Zynith: Record ZynithCompany;
    begin
        if SyncControl.IsInProgress() then
            exit;
        SyncControl.SetInProgress(true);
        if Zynith.Get(Rec.Name) then begin
            Zynith.Name := Rec.Name;
            Zynith."Display Name" := Rec."Display Name";
            Zynith.Modify();
        end;
        SyncControl.SetInProgress(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnCompanyDelete(var Rec: Record Company; RunTrigger: Boolean)
    var
        Zynith: Record ZynithCompany;
    begin
        if SyncControl.IsInProgress() then
            exit;
        SyncControl.SetInProgress(true);
        if Zynith.Get(Rec.Name) then
            Zynith.Delete();
        SyncControl.SetInProgress(false);
    end;
    // --- ZynithCompany Table Subscribers ---
    [EventSubscriber(ObjectType::Table, Database::ZynithCompany, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnZynithInsert(var Rec: Record ZynithCompany; RunTrigger: Boolean)
    var
        Comp: Record Company;
    begin
        if SyncControl.IsInProgress() then
            exit;
        SyncControl.SetInProgress(true);
        if not Comp.Get(Rec.Name) then begin
            Comp.Init();// create company with the given name
            comp.Name := Rec.Name;
            Comp."Display Name" := Rec."Display Name";
            Comp.Insert();
        end;
        SyncControl.SetInProgress(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::ZynithCompany, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnZynithModify(var Rec: Record ZynithCompany; RunTrigger: Boolean)
    var
        Comp: Record Company;
    begin
        if SyncControl.IsInProgress() then
            exit;
        SyncControl.SetInProgress(true);
        if Comp.Get(Rec.Name) then begin
            Comp."Display Name" := Rec."Display Name";
            Comp.Modify();
        end;
        SyncControl.SetInProgress(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::ZynithCompany, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnZynithDelete(var Rec: Record ZynithCompany; RunTrigger: Boolean)
    var
        Comp: Record Company;
    begin
        if SyncControl.IsInProgress() then
            exit;
        SyncControl.SetInProgress(true);
        if Comp.Get(Rec.Name) then
            Comp.Delete();
        SyncControl.SetInProgress(false);
    end;
}


