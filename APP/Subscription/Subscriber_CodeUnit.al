codeunit 50119 "Subscriber Invoice Generator"
{
    Subtype = Normal;

    trigger OnRun()
    var
        Subscriber: Record Subscriber_Table;
    begin
        // Filter Active Subscribers whose Next_Bill_Date is today
        Subscriber.Reset();
        Subscriber.SetRange(Subscriber.Subscriber_Status, Enum::Subscriber_Status_Enum::Active);
        Subscriber.SetRange(Subscriber.Next_Bill_Date, WorkDate());

        if Subscriber.FindSet() then
            repeat
                // Create sales header
                CreateSalesInvoice(Subscriber);

                // Update Next_Bill_Date based on plan/frequency
                UpdateNextBillDate(Subscriber);

            until Subscriber.Next() = 0;
    end;

  

    procedure CreateSalesInvoice(Subscription: Record Subscriber_Table)
    var
        SalesHeader: Record "Sales Header";
        //  Subscriber: Record Subscriber_Table;
        SalesLine: Record "Sales Line";
        PlanRec: Record "Sub_Plan_Table";
        invoiceno: code[25];
        SubscriberNo: Integer;

    begin

        invoiceno := 'SUBINV-' + Format(Subscription.Plan_ID) + '-' + Format(WorkDate(), 0, '<Year4><Month,2>');

        SalesHeader.Init();

        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Validate("Sell-to Customer No.", Subscription.Customer_No);
        SalesHeader."No." := invoiceno;

        SalesHeader.Insert();


        // Add subscriber plan line
        SalesLine.Init();
        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
        SalesLine."Document No." := SalesHeader."No.";

        if PlanRec.Get(Subscription.Plan_ID) then begin
            SalesLine.Description := PlanRec.Plan_Name;
            SalesLine.Validate(Amount, PlanRec.Plan_Fees);
        end else
            Error('Plan %1 not found', Subscription.Plan_ID);

        SalesLine.Insert();
    end;

    procedure UpdateNextBillDate(var Subscriber: Record Subscriber_Table)
    begin
        // Example logic: monthly billing
        // You can modify this based on Start Date, End Date, or Plan Frequency
        if Subscriber.End_Date >= CalcDate('<+1M>', Subscriber.Next_Bill_Date) then
            Subscriber.Next_Bill_Date := CalcDate('<+1M>', Subscriber.Next_Bill_Date)
        else
            Subscriber.Next_Bill_Date := 0D; // or leave blank if subscription ended

        Subscriber.Modify();
    end;

    procedure AddPlanSalesLine(var SalesHeader: Record "Sales Header"; Subscriber: Record Subscriber_Table)
    var
        SalesLine: Record "Sales Line";
        PlanRec: Record "Sub_Plan_Table";
    begin
        SalesLine.Init();
        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
        SalesLine."Document No." := SalesHeader."No.";

        if PlanRec.Get(Subscriber.Plan_ID) then begin
            SalesLine.Description := PlanRec.Plan_Name;
            SalesLine.Validate("Unit Price", PlanRec.Plan_Fees);
        end else
            Error('Plan %1 not found', Subscriber.Plan_ID);

        SalesLine.Insert(true);
    end;


}
