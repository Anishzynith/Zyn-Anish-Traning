page 50150 ZYN_Leave_Category_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Leave_Category_Table;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Leave_Description; Rec.Leave_Description)
                {
                    ApplicationArea = All;
                }
                field(Leave_Category_Name; Rec.Leave_Category_Name)
                {
                    ApplicationArea = All;
                }
                field(Number_of_Days; Rec.Number_of_Days)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}