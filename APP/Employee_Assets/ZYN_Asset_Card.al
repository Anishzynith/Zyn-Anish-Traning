page 50156 Asset_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Asset_Table;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Asset_Category; Rec.Asset_Category)
                {
                    ApplicationArea = all;
                }
                field(Asset_Name; Rec.Asset_Name)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}