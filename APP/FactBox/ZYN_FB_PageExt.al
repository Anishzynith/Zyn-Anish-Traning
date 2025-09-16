pageextension 50110 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(FactBoxes)
        {
            part(CustomerSalesOverview; "Customer Sales FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
}
pageextension 50127 "Customer CardExt" extends "Customer List"
{
    layout
    {
        addlast(FactBoxes)
        {
            part(CustomerSalesOverview; "Customer Sales FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
            part(Active_Subscription; Customer_Page_Fact)
            {
                ApplicationArea = all;
            }
        }
    }
}
