page 50139 ExpenseBudget_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ExpenseBudget_Table;
    layout
    {
        area(Content)
        {
            group(GroupName)
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
                    TableRelation = "Expense_Category_Table".ExpenseCategory_Name;
                }
                field(Budget_Amount; Rec.Budget_Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Budget Amount';
                    DecimalPlaces = 2;
                    ToolTip = 'The amount budgeted for the specified period and category.';
                }
            }
        }
    }
}