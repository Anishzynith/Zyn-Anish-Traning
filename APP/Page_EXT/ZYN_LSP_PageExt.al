pageextension 50121 ZYN_salesOrderlastsoldpriceext extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("Last Sold Price"; Rec."Last Sold Price")
            {
                ApplicationArea = All;
                Caption = 'Last Sold Price';
            }
        }
    }
}