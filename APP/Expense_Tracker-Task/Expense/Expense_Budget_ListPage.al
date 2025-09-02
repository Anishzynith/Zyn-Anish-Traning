page 50138 ExpenseBudget_ListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ExpenseBudget_Table;
    CardPageId = ExpenseBudget_Card;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
                    Caption = 'Expense Category';
                }
                field(Budget_Amount; Rec.Budget_Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Budget Amount';

                }
            }
        }
    }
}