page 50149 Employee_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Employee_Table;
    CardPageId = Employee_Card;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Employee_ID; Rec.Employee_ID)
                {
                    ApplicationArea = All;

                }
                field(Employee_Name; Rec.Employee_Name)
                {
                    ApplicationArea = All;
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = all;
                }
                field(Department; Rec.Department)
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