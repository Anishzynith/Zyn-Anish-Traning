

// // On Role Center FactBox
// page 50154 "Leave Notification FactBox"
// {
//     PageType = CardPart;
//     SourceTable = Leave_Request_Table;
//     ApplicationArea = All;



//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {
//                 Visible = false;
//                 field(UserID; UserId())
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Leave notification message';
//                 }


//             }
//         }

//     }
//     trigger OnOpenPage()
//     var
//         MyNotify: Codeunit "Leave Approval Processor";
//     begin
//         MyNotify.ShowLeaveBalanceNotification();
//     end;
// }



// Approve Leave Action
codeunit 50118 "Leave Approval Processor"
{
    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        LeaveReq: Record "Leave_Request_Table";
    // leaveBal: page "Leave Request card";
    // remaining: integer;
    begin
        LeaveReq.Reset();
        LeaveReq.SetRange(Approval_Status, LeaveReq.Approval_Status::Approved);
        LeaveReq.SetCurrentKey(SystemModifiedAt);
        LeaveReq.SetAscending(SystemModifiedAt, true);

        Clear(Notification);
        Notification.Id := 'CDEF7890-ABCD-0123-1234-567890ABCDEF';
        Notification.Scope := NotificationScope::LocalScope;

        if LeaveReq.FindLast() then
            Notification.Message :=
                StrSubstNo('Last approved request: %1 for %2 days.',
                           LeaveReq."Employee_ID", LeaveReq."End_Date" - LeaveReq."Start_Date" + 1)
        else
            Notification.Message := 'No approved leave requests found!';

        Notification.Send();
    end;
}


pageextension 50134 MyExtension extends "O365 Activities"
{
    layout
    {

    }
    actions { }

    trigger OnOpenPage()
    var
        MyNotify: Codeunit "Leave Approval Processor";
    begin
        MyNotify.ShowLeaveBalanceNotification();
    end;
}

