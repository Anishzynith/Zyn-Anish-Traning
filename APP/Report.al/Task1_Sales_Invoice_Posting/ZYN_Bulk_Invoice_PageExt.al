pageextension 50126 ZYN_SalesInvoiceListExt extends "Sales Invoice List"
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
                    ReportSelection: Report "ZYN_Bulk Report";
                begin
                    // Start the processing report
                    Report.Run(Report::"ZYN_Bulk Report"); //RunModal
                end;
            }
        }
    }
}