page 50120 Expense_Category_Page
{
    PageType = Card;
    //  ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Expense_Category_Table;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ExpenseCategory_ID; Rec.ExpenseCategory_ID)
                {
                    //  ApplicationArea = All;
                    Caption = 'Category ID';
                }
                field(ExpenseCategory_Name; Rec.ExpenseCategory_Name)
                {
                    ApplicationArea = All;
                    Caption = 'Category Name';
                }
                field(ExpenseDescription; Rec.ExpenseDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
            }
        }
    }
}