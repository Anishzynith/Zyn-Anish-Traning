pageextension 50105 "Contact List" extends "Contact List"
{
    actions
    {
        addfirst(processing)
        {
            action(CustomerContact)
            {
                ApplicationArea = All;
                Caption = 'Customer Contact';
                Image = ContactPerson;
                trigger OnAction()
                var
                    Contact: Record Contact;
                    TempContact: Record Contact temporary;
                    ContactBusRel: Record "Contact Business Relation";
                begin
                    // Filter business relations for Vendor type
                    ContactBusRel.Reset();
                    ContactBusRel.SetRange("Link to Table", ContactBusRel."Link to Table"::Customer);
                    if ContactBusRel.FindSet() then begin
                        repeat
                            if Contact.Get(ContactBusRel."Contact No.") then begin
                                if not TempContact.Get(Contact."No.") then begin
                                    TempContact.Init();
                                    TempContact.TransferFields(Contact);
                                    TempContact.Insert();
                                end;
                            end;
                        until ContactBusRel.Next() = 0;
                    end;
                    Page.RunModal(Page::"Filtered Contact List", TempContact);
                end;
            }
            action(vendorcontact)
            {
                ApplicationArea = All;
                Caption = 'Vendor Contact';
                Image = ContactPerson;
                trigger OnAction()
                var
                    Contact: Record Contact;
                    TempContact: Record Contact temporary;
                    ContactBusRel: Record "Contact Business Relation";
                begin
                    // Filter business relations for Vendor type
                    ContactBusRel.SetRange("Link to Table", ContactBusRel."Link to Table"::Vendor);
                    if ContactBusRel.FindSet() then begin
                        repeat
                            if Contact.Get(ContactBusRel."Contact No.") then begin
                                if not TempContact.Get(Contact."No.") then begin
                                    TempContact := Contact;
                                    TempContact.Insert();
                                end;
                            end;
                        until ContactBusRel.Next() = 0;
                    end;
                    Page.RunModal(Page::"Filtered Contact List", TempContact);
                end;
            }
            action(bankcontact)
            {
                ApplicationArea = All;
                Caption = 'Bank Contact';
                Image = ContactPerson;
                trigger OnAction()
                var
                    Contact: Record Contact;
                    TempContact: Record Contact temporary;
                    ContactBusRel: Record "Contact Business Relation";
                begin
                    // Filter business relations for Vendor type
                    ContactBusRel.SetRange("Link to Table", ContactBusRel."Link to Table"::"Bank Account");
                    if ContactBusRel.FindSet() then begin
                        repeat
                            if Contact.Get(ContactBusRel."Contact No.") then begin
                                if not TempContact.Get(Contact."No.") then begin
                                    TempContact := Contact;
                                    TempContact.Insert();
                                end;
                            end;
                        until ContactBusRel.Next() = 0;
                    end;
                    Page.Run(Page::"Filtered Contact List", TempContact);
                end;
            }
        }
    }
    local procedure Contactpage(ContactBusRel: Record "Contact Business Relation")
    var
        Contact: Record Contact;
        TempContact: Record Contact temporary;
    begin
        // Filter business relations for Vendor type
        if ContactBusRel.FindSet() then begin
            repeat
                if Contact.Get(ContactBusRel."Contact No.") then begin
                    if not TempContact.Get(Contact."No.") then begin
                        TempContact.Init();
                        TempContact.TransferFields(Contact);
                        TempContact.Insert();
                    end;
                end;
            until ContactBusRel.Next() = 0;
        end;
        Page.RunModal(Page::"Filtered Contact List", TempContact);
    end;

}