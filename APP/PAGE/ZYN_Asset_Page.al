page 50155 ZYN_Asset_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Asset_Table;
    CardPageId = ZYN_Asset_Card;
    Caption = 'ZYN ASset List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Asset_Category; Rec.Asset_Category)
                {
                    ApplicationArea = all;
                    Caption = 'Asset Category';
                    ToolTip = 'Enter Asset Gategory';
                }
                field(Asset_Name; Rec.Asset_Name)
                {
                    ApplicationArea = all;
                    Caption = 'Asset Name';
                    ToolTip = 'Enter Asset Name';
                }
            }
        }
    }
}