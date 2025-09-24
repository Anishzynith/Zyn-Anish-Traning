page 50172 ZYN_Sub_Plan_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Sub_Plan_Table;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Plan_ID; Rec.Plan_ID)
                { }
                field(Plan_Fees; Rec.Plan_Fees)
                { }
                field(Plan_Name; Rec.Plan_Name)
                { }
                field(Plan_Status; Rec.Plan_Status)
                { }
                field(Description; Rec.Description)
                { }
            }
        }
    }
}