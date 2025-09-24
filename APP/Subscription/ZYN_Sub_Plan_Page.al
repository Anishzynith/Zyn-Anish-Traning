page 50171 ZYN_Sub_Plan_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Sub_Plan_Table;
    CardPageId = ZYN_Sub_Plan_Card;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
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