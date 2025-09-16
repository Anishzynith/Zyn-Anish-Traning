page 50151 Leave_Category_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Leave_Category_Table;
    CardPageId = Leave_Category_Card;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
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