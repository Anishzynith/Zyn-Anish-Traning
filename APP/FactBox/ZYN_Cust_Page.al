pageextension 50127 "ZYN_Customer CardExt" extends "Customer List"
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
            part(Active_Subscription; ZYN_Customer_Page_Fact)
            {
                ApplicationArea = all;
            }
        }
    }
}
