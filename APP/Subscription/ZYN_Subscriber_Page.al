page 50173 Subscriber_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Subscriber_Table;
    CardPageId = Subscriber_Card;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; Rec.ID)
                {

                }
                field(Customer_No; Rec.Customer_No)
                {

                }
                field(Plan_ID; Rec.Plan_ID)
                { }
                field(start_Date; Rec.start_Date)
                { }
                field(End_Date; Rec.End_Date)
                { }
                field(Subscriber_Status; Rec.Subscriber_Status)
                { }
                field(Next_Bill_Date; Rec.Next_Bill_Date)
                { }
                // field(Plan_Fees; Rec.Plan_Fees)
                // {

                // }
                field(Next_Renewal_Date; Rec.Next_Renewal_Date)
                { }
                field(Reminder_Sent; Rec.Reminder_Sent)
                { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateInvoice)
            {
                ApplicationArea = All;
                Caption = 'Create Invoice';
                Image = Invoice;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SubsInvGenerator: Codeunit "Subscriber Invoice Generator";
                begin
                    SalesHeader.Init();
                    SalesHeader."Sell-to Customer No." := Rec.Customer_No;
                    SalesHeader.Insert();

                    // Add subscriber's plan line
                    SubsInvGenerator.AddPlanSalesLine(SalesHeader, Rec);
                end;

            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Subscriber_Status, Rec.Subscriber_Status::Active);
    end;
}