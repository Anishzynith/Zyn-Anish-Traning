page 50141 "ZYN_Expense Budget FactBox"
{
    PageType = ListPart;
    SourceTable = ZYN_ExpenseBudget_Table;
    ApplicationArea = All;
    Caption = 'Expense Budget (This Month)';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(From_Date; Rec.From_Date)
                {
                    ApplicationArea = All;
                    Caption = 'From Date';
                }
                field(To_Date; Rec.To_Date)
                {
                    ApplicationArea = All;
                    Caption = 'To Date';
                }
                field(Expense_Category; Rec.Expense_Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                }
                field(Budget_Amount; Rec.Budget_Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Budget Amount';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        FromDate: Date;
        ToDate: Date;
    begin
        // filter automatically to current month
        FromDate := CalcDate('<-CM>', WorkDate()); // first day of month
        ToDate := CalcDate('<CM>', WorkDate());    // last day of month
        Rec.SetRange(From_Date, FromDate, ToDate);
        Rec.SetRange(To_Date, ToDate);
    end;
}
