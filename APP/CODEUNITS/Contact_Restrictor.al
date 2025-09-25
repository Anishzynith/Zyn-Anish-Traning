codeunit 50139 "Contact Restrictor"
{
    Subtype = Normal;

    [EventSubscriber(ObjectType::Table, Database::"Contact", 'OnBeforeInsertEvent', '', false, false)]
    local procedure BlockInsert(var Rec: Record "Contact"; RunTrigger: Boolean)
    begin
        if not IsMasterCompany() then
            Error('You cannot create contacts in a sub-company. Manage contacts in the Master Company.');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Contact", 'OnBeforeModifyEvent', '', false, false)]
    local procedure BlockModify(var Rec: Record "Contact"; var xRec: Record "Contact"; RunTrigger: Boolean)
    begin
        if not IsMasterCompany() then
            Error('You cannot modify contacts in a sub-company. Manage contacts in the Master Company.');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Contact", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure BlockDelete(var Rec: Record "Contact"; RunTrigger: Boolean)
    begin
        if not IsMasterCompany() then
            Error('You cannot delete contacts in a sub-company. Manage contacts in the Master Company.');
    end;

    local procedure IsMasterCompany(): Boolean
    var
        ZynithComp: Record ZynithCompany;
    begin
        if ZynithComp.Get(CompanyName()) then
            exit(ZynithComp.IS_Master);
        exit(false);
    end;
}
