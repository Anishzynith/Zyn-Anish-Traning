page 50116 "ZYN_TechnicianList"
{
    PageType = List;
    SourceTable = ZYN_TechnicianTable;
    CardPageId = "ZYN_Technician Card";
    ApplicationArea = all;
    Caption = 'Technician List';
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
            part(ProblemList; "ZYN_ProblemList")
            {
                ApplicationArea = all;
                SubPageLink = "Technician_Name" = field("Tech_Name");
            }
        }
    }
}

