page 50179 Claim_Category_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Claim_Category_Table;

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