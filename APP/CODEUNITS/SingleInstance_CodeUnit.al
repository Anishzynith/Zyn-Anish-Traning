codeunit 50156 "Single Instance Management"
{
    SingleInstance = true;

    internal procedure SetFromCreateAs()
    begin
        FromCreateAs := true;
    end;

    internal procedure GetFromCreateAs(): Boolean
    begin
        exit(FromCreateAs);
    end;

    internal procedure ClearCreateAs()
    begin
        Clear(FromCreateAs);
    end;

    var
        FromCreateAs: Boolean;

    [EventSubscriber(ObjectType::Table, Database::"Contact Business Relation", 'OnBeforeUpdateContactBusinessRelation', '', true, true)]
    local procedure OnBeforeUpdateContactBusinessRelation(ContactBusinessRelation: Record "Contact Business Relation"; var IsHandled: Boolean)
    var
        SingleInstanceMgt: Codeunit "Single Instance Management";
        Contact: Record Contact;
    begin
        if SingleInstanceMgt.GetFromCreateAs() then
            IsHandled := true;

        if ContactBusinessRelation."Contact No." <> '' then
            if Contact.Get(ContactBusinessRelation."Contact No.") then begin
                if Contact.UpdateBusinessRelation() then
                    Contact.Modify();

                Contact.SetFilter("No.", '<>%1', ContactBusinessRelation."Contact No.");
                Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.");
                if Contact.FindSet(true) then
                    repeat
                        if Contact.UpdateBusinessRelation() then
                            Contact.Modify();
                    until Contact.Next() = 0;
            end;
    end;
}