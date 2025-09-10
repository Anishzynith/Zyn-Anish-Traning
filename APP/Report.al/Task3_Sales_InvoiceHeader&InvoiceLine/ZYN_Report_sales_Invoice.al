report 50102 "Sales_InvoiceHeaderandLine"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales_InvoiceHeader_InvoiceLine.rdl';


    dataset
    {
        dataitem("SalesInvHeader"; "Sales Invoice Header")
        {
            column(No_; "No.") { }
            column(Name; "Sell-to Customer Name") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_Date; "Document Date") { }
            dataitem("Company Information"; "Company Information")
            {
                column(Company_Name; Name) { }
                column(logo; Picture) { }
                column(Address; Address) { }
            }

            // Invoice Lines
            dataitem("SalesInvLine"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Quantity; Quantity) { }
                column(Document_No_; "Document No.") { }
                column(Description; Description) { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount; "Line Amount") { }
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Document No." = field("No."), "Customer No." = field("Sell-to Customer No.");
                column(L_G_Description; "Description") { }
                column(Amount; Amount) { }
                column(Remaining_Amount; "Remaining Amount") { }
            }

            // Company Info inside Line (if you want to repeat per line)



            // BEGINNING TEXT (OUTSIDE Line loop)
            dataitem(BeginningText; "Sales Invoice Text Code")
            {
                DataItemTableView = WHERE(Selection = CONST(beginend_enum::BeginningText), "Document Type" = const("Posted Invoice"));
                DataItemLink = "No." = field("No.");
                column(Begin_Text; "Text") { }
                column(BeginLineNo; lineNO) { }
            }

            // ENDING TEXT (ALSO OUTSIDE Line loop)
            dataitem(EndingText; "Sales Invoice Text Code")
            {
                DataItemTableView = WHERE(Selection = CONST(beginend_enum::EndingText), "Document Type" = const("Posted Invoice"));
                DataItemLink = "No." = field("No.");
                column(End_Text; Text) { }
                column(EndingLineNo; lineNO) { }
            }
        }
    }
}