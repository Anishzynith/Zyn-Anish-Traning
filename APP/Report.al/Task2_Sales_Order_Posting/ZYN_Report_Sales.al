report 50100 "Orders By Date"
{
    ProcessingOnly = true; // No print, only logic
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;


    // Loop through Sales Orders
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            // This runs for every sales order
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

    // Show a page before running, to take date input
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

    // Variables used
    var
        SelectedDate: Date;
        OrderCount: Integer;

    // Runs after checking all records
    trigger OnPostReport()
    begin
        Message('There are %1 open sales orders on %2.', OrderCount, Format(SelectedDate));
    end;
}
