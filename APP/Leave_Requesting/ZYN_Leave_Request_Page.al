page 50153 Leave_Request_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Leave_Request_Table;
    CardPageId = Leave_Request_Card;
    // Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

            action(Approve_Leave)
            {
                Caption = 'Approve Leave';
                Image = Approve;

                trigger OnAction()
                var
                    Notif: Notification;
                begin
                    if Rec.Approval_Status = Rec.Approval_Status::Pending then begin
                        // Update status
                        Rec.Approval_Status := Rec.Approval_Status::Approved;
                        Rec.Modify(true);

                        // Create notification
                        Notif.Message(StrSubstNo('✅ Leave request %1 has been approved.', Rec."Leave_ID"));

                        // Make it visible in Role Center bell 🔔
                        Notif.Scope := NotificationScope::LocalScope;

                        // Send notification
                        Notif.Send();
                    end else
                        Message('Only leave requests with status Pending can be approved.');
                end;
            }



        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.UpdateRemainingBalance();   // ✅ page-level trigger
    end;

}