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
            action(SendToSlaveVendor)
            {
                Caption = 'Send Vendor to Slave Company';
                Image = SendTo;
                ApplicationArea = All;

                trigger OnAction()
                var
                    VendReplicator: Codeunit "ZYN_Vendor_Replicator";
                    SlaveCompanyRec: Record ZynithCompany; // your company lookup table
                    Vend: Record Vendor;
                begin
                    //Vend := Rec;
                    Vend.Get(Rec."No."); // Assumes Rec is a Customer, so use Vend.Get with the Vendor No. if available
                    SlaveCompanyRec.SetFilter("Master_Company_Name", '<>%1', '');

                    if Page.RunModal(Page::ZYN_Company_Page, SlaveCompanyRec) = Action::LookupOK then
                        VendReplicator.SendVendorToSlave(Vend, SlaveCompanyRec.Master_Company_Name);
                end;
            }

        }
    }
}
