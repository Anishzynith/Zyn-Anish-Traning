report 50100 "ZYN_Orders By Date"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            trigger OnAfterGetRecord()
            begin
                // Check if the date and status match
                SalesHeader.SetRange("Document Type", "Document Type"::Order);
                SalesHeader.SetRange(Status, Status::Open);
                SalesHeader."Posting Date" := SelectedDate;
                SalesHeader.Modify();
                orderCount := OrderCount + 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Enter Date")
                {
                    field(SelectedDate; SelectedDate)
                    {
                        ApplicationArea = All;
                        Caption = 'New Posting Date';
                    }
                }
            }
        }
    }
    var
        SelectedDate: Date;
        OrderCount: Integer;

    trigger OnPostReport()
    begin
        Message('There are %1 open sales orders on %2.', OrderCount, Format(SelectedDate));
    end;
}
