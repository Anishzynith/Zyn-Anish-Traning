pageextension 50142 ZYN_CustomerCardButtonExt extends "Customer Card"
{
    actions
    {

        addlast(Processing)
        {
            action(Send_to_Slave)
            {
                Caption = 'Send Customer';
                ApplicationArea = All;
                Image = Export;
                trigger OnAction()
                var
                    SlaveCompanyRec: Record ZynithCompany; // your custom company table
                    CustReplicator: Codeunit "ZYN_Customer_Replicator";
                    Cust: Record Customer;
                begin
                    Cust := Rec;

                    // Filter: show only Slave Companies (Master_Company_Name <> '')
                    SlaveCompanyRec.SetFilter("Master_Company_Name", '<>%1', '');

                    if Page.RunModal(Page::"ZYN_Company_Page", SlaveCompanyRec) = Action::LookupOK then begin
                        CustReplicator.SendCustomerToSlave(Cust, SlaveCompanyRec.Name);
                        // NOTE: if your lookup page returns Master_Company_Name instead of Name → adjust here
                    end;
                end;
            }
        }
    }
}
pageextension 50143 "ContactListext" extends "Contact List"
{
    actions
    {
        modify(Customer)
        {
            trigger OnBeforeAction()
            var
                SingleInstanceMgt: Codeunit "Single Instance Management";
            begin
                SingleInstanceMgt.SetFromCreateAs();
            end;
        }

        modify(Vendor)
        {
            trigger OnBeforeAction()
            var
                SingleInstanceMgt: Codeunit "Single Instance Management";
            begin
                SingleInstanceMgt.SetFromCreateAs();
            end;
        }
    }
}