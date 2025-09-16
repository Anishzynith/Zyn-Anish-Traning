page 50140 Customer_List_New
{
    PageType = list;
    SourceTable = Customer;
    Caption = 'Customer list new';
    Editable = false;
    ApplicationArea = all;
    UsageCategory = Lists;  //  appear in Tell Me (Search)
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field(state; Rec.County)
                {
                    ApplicationArea = all;
                }
            }
            part(SalesOrder; SalesOrders)
            {
                ApplicationArea = all;
                SubPageLink = "Sell-to Customer Name" = field("Name");
            }
            part(SalesInvoice; SalesInvoices)
            {
                ApplicationArea = all;
                SubPageLink = "Sell-to Customer Name" = field("Name");
            }
            part(SalesCreditMemo; SalesCreditMemo)
            {
                ApplicationArea = all;
                SubPageLink = "Sell-to Customer Name" = field("Name");
            }
        }
    }
}
