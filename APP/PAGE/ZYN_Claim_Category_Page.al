page 50179 ZYN_Claim_Category_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Claim_Category_Table;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Claim_Code; Rec.Claim_Code)
                {
                }
                field(Claiming_Category; Rec.Claiming_Category)
                {
                }
                field(SubType; Rec.SubType)
                {
                }
                field(Max_Amount; Rec.Max_Amount)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Available_Amount; Rec.Available_Amount)
                {
                }
            }
        }
    }
}