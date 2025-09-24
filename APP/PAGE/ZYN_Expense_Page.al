page 50117 ZYN_Expense_Tracker_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Expense_Tracker;
    CardPageId = ZYN_Expense_Tracker_Card;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ExpenseDescription; Rec.ExpenseDescription)
                {
                    //  ApplicationArea = All;
                    Caption = 'Description';
                }
                field(ExpenseAmount; Rec.ExpenseAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                }
                field(Expense_Category; Rec.Expense_Category)
                {
                    ApplicationArea = All;
                    Caption = 'Expense Category';
                    TableRelation = ZYN_Expense_Category_Table.ExpenseCategory_Name;
                }
                field(ExpenseDate; Rec.ExpenseDate)
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
            }
        }
        area(FactBoxes)
        {
            part(Expense_Budget_FactBox; "ZYN_Expense Budget FactBox")
            {
                Caption = 'Budget FactBox';
                //  SubPageLink = "Expense_Category" = field("Expense_Category");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Category)
            {
                ApplicationArea = All;
                Caption = 'Category';
                Image = Category;
                trigger OnAction()
                begin
                    PAGE.Run(Page::ZYN_Expense_Category_ListPage);
                end;
            }
            action(EXCEL)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';
                Image = ExportToExcel;
                RunObject = Report "ZYN_Expense_Tracker_Report";
            }
            action(Savings)
            {
                ApplicationArea = All;
                Caption = 'Savings';
                Image = Receipt;
                RunObject = report "ZYN_Savings_Report";
            }
        }
    }
}