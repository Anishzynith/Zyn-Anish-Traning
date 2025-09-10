
// Approve Leave Action
codeunit 50118 "Leave Approval Processor"
{
    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        LeaveReq: Record "Leave_Request_Table";

    begin
        LeaveReq.Reset();
        LeaveReq.SetRange(Approval_Status, LeaveReq.Approval_Status::Approved);
        LeaveReq.SetCurrentKey(SystemModifiedAt);
        LeaveReq.SetAscending(SystemModifiedAt, true);

        Clear(Notification);
        Notification.Id := CreateGuid(); //'CDEF7890-ABCD-0123-1234-567890ABCDEF';
        Notification.Scope := NotificationScope::LocalScope;

        if LeaveReq.FindSet() then
            Notification.Message :=
                StrSubstNo('Last approved request: %1 for %2 days.',
                           LeaveReq."Employee_ID", LeaveReq."End_Date" - LeaveReq."Start_Date" + 1)
        else
            Notification.Message := 'No approved leave requests found!';

        Notification.Send();
    end;

    procedure ShowSubscriberReminderNotification(CustomerName: Text[100]; EndDate: Date)
    var
        MyNotification: Notification;
        Subscriber: Record "Subscriber_Table";
    begin

        Subscriber.setrange(Subscriber_Status, Subscriber.Subscriber_Status::Active);
        Clear(MyNotification);
        MyNotification.Id := CreateGuid();
        MyNotification.Message := StrSubstNo('Reminder: Subscription for %1 is ending on %2. Renew now!', CustomerName, EndDate);
        MyNotification.Scope := NotificationScope::LocalScope;
        MyNotification.Send();
    end;
}


pageextension 50134 RoleCenterExtension extends "O365 Activities"
{

    trigger OnAfterGetRecord()
    var
        MyNotify: Codeunit "Leave Approval Processor";
        Renew_Reminder: Codeunit "Subscription_Renewal_Reminder";
    begin
        MyNotify.ShowLeaveBalanceNotification();
        Renew_Reminder.Run();
        CurrPage.Update(false);

    end;
}

