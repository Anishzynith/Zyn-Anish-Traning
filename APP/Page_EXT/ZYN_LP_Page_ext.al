pageextension 50146 ZYN_LoyaltyPoints extends "Customer Card"
{
    Caption = 'Customer Card';
    layout
    {
        addlast(general)
        {
            field("Loyalty Points"; Rec.LoyaltyPoints)
            {
                Caption = 'Loyalty Points';
                ApplicationArea = all;
                Editable = true;
            }
        }
    }
}