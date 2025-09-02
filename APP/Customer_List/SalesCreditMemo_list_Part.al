page 50144 SalesCreditMemo
{
    PageType = ListPart;
    ApplicationArea = all;
    UsageCategory = lists;
    SourceTable = "Sales Header";
    Caption = 'Sles Credit Memo List Part';
    SourceTableView = where("Document Type" = const("Credit Memo"));
    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Sales: Page "Sales Credit Memo";
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