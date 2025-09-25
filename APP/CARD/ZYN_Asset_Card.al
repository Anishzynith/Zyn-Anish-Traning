page 50156 ZYN_Asset_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Asset_Table;
    Caption = 'ZYN Asset Card';
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Asset_Category; Rec.Asset_Category)
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter Asset Category';
                }
                field(Asset_Name; Rec.Asset_Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Enter Asset Name';
                }
            }
        }
    }
}