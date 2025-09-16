report 50101 "Bulk Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //  DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()

            begin
                SalesHeader.SetRange("Document Type", "Document Type"::Invoice);
                SalesPost.Run(SalesHeader);
                Counter += 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }
    var
        SalesPost: Codeunit "Sales-Post";
        Counter: Integer;

    trigger OnPostReport()
    begin
        Message('There are %1 of Sales Invoice Posted', Counter);
    end;
}