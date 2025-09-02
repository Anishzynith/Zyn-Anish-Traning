pageextension 50126 SalesInvoiceListExt extends "Sales Invoice List"
{

    actions
    {
        addlast(processing)
        {
            action("Bulk Process")
            {
                ApplicationArea = all;
                Caption = 'Bulk Process';
                Image = Post;
                trigger OnAction()
                var
                    ReportSelection: Report "Bulk Report";
                begin
                    // Start the processing report
                    Report.Run(Report::"Bulk Report"); //RunModal
                end;
            }
        }
        // Add changes to page actions here
    }


}