page 50117 Expense_Tracker_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Expense_Tracker;
    CardPageId = Expense_Tracker_Card;

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
                    TableRelation = "Expense_Category_Table".ExpenseCategory_Name;
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
            part(Expense_Budget_FactBox; "Expense Budget FactBox")
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
                    PAGE.Run(Page::Expense_Category_ListPage);
                end;
            }
            action(EXCEL)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';
                Image = ExportToExcel;
                RunObject = Report "Expense_Tracker_Report";
            }
            action(Savings)
            {
                ApplicationArea = All;
                Caption = 'Savings';
                Image = Receipt;
                RunObject = report "Savings_Report";
            }

        }

    }
}