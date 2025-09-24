page 50155 ZYN_Asset_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Asset_Table;
    CardPageId = ZYN_Asset_Card;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
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