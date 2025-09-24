page 50136 ZYN_Income_Tracker_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Income_Tracker;
    CardPageId = ZYN_Income_Tracker_Card;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(IncomeDescription; Rec.IncomeDescription)
                {
                    //  ApplicationArea = All;
                    Caption = 'Description';
                }
                field(IncomeAmount; Rec.IncomeAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                }
                field(Income_Category; Rec.Income_Category)
                {
                    ApplicationArea = All;
                    Caption = 'Income Category';
                    TableRelation = ZYN_Income_Category_Table.IncomeCategory_Name;
                }
                field(IncomeDate; Rec.IncomeDate)
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
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
                    PAGE.Run(Page::ZYN_Income_Category_ListPage);
                end;
            }
            action(EXCEL)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';
                Image = ExportToExcel;
                RunObject = Report "ZYN_Income_Tracker_Report";
            }
        }
    }
}