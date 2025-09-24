page 50152 ZYN_Leave_Request_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Leave_Request_Table;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Leave_ID; Rec.Leave_ID)
                {
                    ApplicationArea = All;
                }
                field(Employee_ID; Rec.Employee_ID)
                {
                    ApplicationArea = All;
                }
                field(Leave_Category; Rec.Leave_Category_Name)
                {
                    ApplicationArea = All;
                }
                field(Start_Date; Rec.Start_Date)
                {
                    ApplicationArea = All;
                }
                field(End_Date; Rec.End_Date)
                {
                    ApplicationArea = All;
                }
                field(Approval_Status; Rec.Approval_Status)
                {
                    ApplicationArea = All;
                }
                field(Remaining_Leave_Balance; Rec.Remaining_Leave_Balance)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.UpdateRemainingBalance();   // ✅ page-level trigger
    end;
}