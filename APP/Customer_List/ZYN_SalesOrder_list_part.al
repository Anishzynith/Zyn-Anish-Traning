page 50142 SalesOrders
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    Caption = 'Sales Order List Part';
    Editable = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTableView = where("Document Type" = const("Order"));
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    DrillDown = true;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        Sales: Page "Sales Order";
                    begin
                        Sales.SetRecord(Rec);
                        sales.Run();
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}