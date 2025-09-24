pageextension 50128 ZYN_VendorListE extends "Vendor List"
{
    Caption = 'Vendor List';
    layout
    {
        addafter("Name")
        {
            field(RecordNotes; Rec.Notes)
            {
                ApplicationArea = All;
            }
        }
    }
}
