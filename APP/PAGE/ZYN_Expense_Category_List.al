page 50124 ZYN_Expense_Category_ListPage
{
    PageType = List;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = ZYN_Expense_Category_Table;
    //  Editable = false;
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
        area(FactBoxes)
        {
            part(Expense_FactBox; "ZYN_Category Expense FactBox")
            {
                Caption = 'Expense FactBox';
                SubPageLink = "ExpenseCategory_Name" = field("ExpenseCategory_Name");
                ApplicationArea = All;
            }
            part(Budget_FactBox; "ZYN_Category FactBox")
            {
                Caption = 'Budget FactBox';
                SubPageLink = "ExpenseCategory_Name" = field("ExpenseCategory_Name");
                ApplicationArea = All;
            }
        }
    }
}