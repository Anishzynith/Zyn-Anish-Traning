pageextension 50102 ZYN_VendorCardExtofButton extends "Vendor Card"
{
    actions
    {
        addlast(processing)
        {
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