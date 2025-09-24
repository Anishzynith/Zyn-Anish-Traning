pageextension 50110 "ZYN_Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(FactBoxes)
        {
            part(CustomerSalesOverview; "ZYN_Customer Sales FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
}
