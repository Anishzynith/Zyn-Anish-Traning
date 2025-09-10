page 50155 Asset_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Asset_Table;
    CardPageId = Asset_Card;

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
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}