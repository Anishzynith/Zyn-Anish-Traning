page 50146 ZYN_Recurring_Expense_ListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Recurring_Expense_Table;
    CardPageId = ZYN_Recurring_Expense_Card;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Recurring_Category; Rec.Category)
                {
                    TableRelation = ZYN_Expense_Category_Table.ExpenseCategory_Name;
                    ApplicationArea = All;
                }
                field(Recurring_Amount; Rec.Recurring_Amount)
                {
                    ApplicationArea = All;
                }
                field(Recurring_Cycle; Rec.Recurring_Cycle)
                {
                    ApplicationArea = All;
                }
                field(Start_Date; Rec.Start_Date)
                {
                    ApplicationArea = All;
                }
                field(Next_Cycle_Date; Rec.Next_Cycle_Date)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}