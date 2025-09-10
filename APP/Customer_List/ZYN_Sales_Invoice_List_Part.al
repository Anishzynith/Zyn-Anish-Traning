page 50143 SalesInvoices
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    Caption = 'Sales Invoice List Part';
    Editable = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTableView = where("Document Type" = const("Invoice"));
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Sales: Page "Sales Invoice";
                    begin
                        Sales.SetRecord(Rec);
                        sales.Run();

                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}