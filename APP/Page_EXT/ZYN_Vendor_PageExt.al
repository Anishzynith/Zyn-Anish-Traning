pageextension 50118 ZYN_VendorCardExt extends "Vendor Card"
{
    Caption = 'Vendor Card Extension';
    layout
    {
        addafter("Name")
        {
            field(Notes; Rec.Notes)
            {
                ApplicationArea = All;
            }
        }
    }
}

