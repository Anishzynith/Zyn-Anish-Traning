page 50114 "ZYN_Technician Card"
{
    PageType = Card;
    SourceTable = ZYN_TechnicianTable;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group(general)
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
        }
    }
}