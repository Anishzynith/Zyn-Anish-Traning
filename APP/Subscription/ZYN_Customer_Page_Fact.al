page 50175 ZYN_Customer_Page_Fact
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Subscriber_Table;
    layout
    {
        area(Content)
        {
            cuegroup(Subscription)
            {
                field(Active_Subscriptions; GetActiveCount())
                {
                    ApplicationArea = All;
                    Caption = 'Active Subscriptions';
                    DrillDownPageId = ZYN_Subscriber_Page; // custom page (see below)
                    trigger OnDrillDown()
                    var
                        SubRec: Record ZYN_Subscriber_Table;
                    begin
                        SubRec.SetRange(Subscriber_Status, SubRec.Subscriber_Status::Active);
                        PAGE.Run(PAGE::ZYN_Subscriber_Page, SubRec);
                    end;
                }
                field(TotalRevenue; RevenueGenerated())
                {
                    ApplicationArea = All;
                    Caption = 'Revenue Generated';
                    DrillDownPageId = "Sales Invoice List";
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                        FromDate: Date;
                        ToDate: Date;
                        CurrentYear: Integer;
                        CurrentMonth: Integer;
                    begin
                        // Get current month and year
                        CurrentMonth := Date2DMY(WorkDate(), 2); // Month
                        CurrentYear := Date2DMY(WorkDate(), 3);  // Year
                        // First day of month
                        FromDate := DMY2Date(1, CurrentMonth, CurrentYear);
                        // Last day of month using CalcDate
                        ToDate := CalcDate('<+1M>-1D', FromDate);
                        // Filter SalesHeader for SUBINV invoices in current month
                        SalesHeader.SetFilter("No.", '*SUBINV*');
                        SalesHeader.SetRange("Document Date", FromDate, ToDate);
                        // Open Sales Invoice List page with filter applied
                        PAGE.Run(PAGE::"Sales Invoice List", SalesHeader);
                    end;
                }
            }
        }
    }
    var
        sales: Record "Sales Header";
        salesline: record "sales line";
        WorkMonth: Integer;
        WorkYear: Integer;

    trigger OnAfterGetRecord()
    var
        MyNotify: Codeunit "ZYN_Leave Approval Processor";
        Renew_Reminder: Codeunit "ZYN_SubscriptionRenewalRemind";
    begin
        MyNotify.ShowLeaveBalanceNotification();
        Renew_Reminder.Run();
        CurrPage.Update(false);
    end;

    local procedure GetActiveCount(): Integer
    var
        SubRec: Record ZYN_Subscriber_Table;
    begin
        SubRec.SetRange(Subscriber_Status, SubRec.Subscriber_Status::Active);
        exit(SubRec.Count);
    end;

    local procedure RevenueGenerated(): Decimal
    var
        SalesHeader: Record "Sales Header";
        totAmount: Decimal;
        WorkMonth: Integer;
        WorkYear: Integer;
        FromDate: Date;
        ToDate: Date;
    begin
        // Get current month and year
        WorkMonth := Date2DMY(WorkDate(), 2); // Month
        WorkYear := Date2DMY(WorkDate(), 3);  // Year
        // First day of month
        FromDate := DMY2Date(1, WorkMonth, WorkYear);
        // Last day of month
        ToDate := CalcDate('<+1M>-1D', FromDate);
        // Filter for SUBINV invoices in this month
        SalesHeader.SetFilter("No.", '*SUBINV*');
        SalesHeader.SetRange("Document Date", FromDate, ToDate);
        // Sum amounts
        if SalesHeader.FindSet() then
            repeat
                SalesHeader.CalcFields("Amount Including VAT");
                totAmount += SalesHeader."Amount Including VAT";
            until SalesHeader.Next() = 0;
        exit(totAmount);
    end;
}