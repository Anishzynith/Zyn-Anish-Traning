page 50131 ZYN_Income_Tracker_Card
{
    PageType = Card;
    //  ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Income_Tracker;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Income_ID; Rec.Income_ID)
                {
                    ApplicationArea = All;
                    Caption = 'Income ID';
                }
                field(IncomeDescription; Rec.IncomeDescription)
                {
                    ApplicationArea = All;
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
}