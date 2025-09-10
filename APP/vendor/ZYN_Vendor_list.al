pageextension 50128 VendorListE extends "Vendor List"
{
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
