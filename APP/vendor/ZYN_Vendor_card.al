pageextension 50118 VendorCardExt extends "Vendor Card"
{
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

