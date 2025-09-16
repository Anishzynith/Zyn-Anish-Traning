page 50116 "TechnicianList"
{
    PageType = List;
    SourceTable = "TechnicianTable";
    CardPageId = "Technician Card";
    ApplicationArea = all;
    Caption = 'Technician List';
    // InsertAllowed = false;
    // DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Tech_ID; Rec.Tech_ID)
                {
                    Caption = 'Tech_ID';
                }
                field(Tech_Name; Rec.Tech_Name)
                {
                    Caption = 'Tech_Name';
                }
                field("Phone.No"; Rec."Phone.No")
                {
                    Caption = 'Phone_No';
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Department';
                }
                field("No Of Problems"; Rec."No Of Problems")
                {
                    Caption = 'No.of Problems';
                }
            }
            part(ProblemList; ProblemList)
            {
                ApplicationArea = all;
                SubPageLink = "Technician_Name" = field("Tech_Name");
            }
        }
    }
}

