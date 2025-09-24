page 50148 ZYN_Employee_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Employee_Table;
    layout
    {
        area(Content)
        {
            group(GroupName)
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
    }
}