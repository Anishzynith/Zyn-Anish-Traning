codeunit 50121 "ZYN_SubscriptionRenewalRemind"
{
    Subtype = Normal;
    trigger OnRun()
    var
        Renewal_Sub: Record ZYN_Subscriber_Table;
        ReminderDate: Date;
    begin
        ReminderDate := CalcDate('<+15D>', WorkDate);
        Renewal_Sub.Reset();
        Renewal_Sub.SetFilter(End_Date, '%1', ReminderDate);
        Renewal_Sub.SetRange(Reminder_Sent, false);
        if Renewal_Sub.FindSet() then
            repeat
                SendReminder(Renewal_Sub);
                Renewal_Sub.Reminder_Sent := true;
                Renewal_Sub.Modify();
            until Renewal_Sub.Next() = 0;
    end;

    local procedure SendReminder(Subscription: Record ZYN_Subscriber_Table)
    var
        Customer: Record Customer;
        Reminder: Codeunit "ZYN_SubscriptionRenewalRemind";
    begin
        if Customer.Get(Subscription.Customer_No) then begin
            // Use notification instead of Message()
            Reminder.ShowSubscriberReminderNotification(Customer.Name, Subscription.End_Date);
        end;
    end;

    procedure ShowSubscriberReminderNotification(CustomerName: Text; EndDate: Date)
    var
        Notification: Notification;
    begin
        Notification.Message := StrSubstNo('Dear %1, your subscription will end on %2. Please renew soon.', CustomerName, Format(EndDate));
        Notification.Send();
    end;
}