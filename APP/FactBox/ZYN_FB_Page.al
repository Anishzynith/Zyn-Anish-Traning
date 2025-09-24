page 50109 "ZYN_Customer Sales FactBox"
{
    PageType = CardPart;
    SourceTable = "Customer";
    //  SourceTableTemporary = true; // ✅ Temp table
    ApplicationArea = All;
    Caption = 'Customer Sales Overview';
    layout
    {
        area(content)
        {
            group("Contact Information")
            {
                Visible = contentVisible;
                field("Contact ID"; ContactNo)
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        ContactRec: Record Contact;
                    begin
                        if Rec."Primary Contact No." <> '' then
                            if ContactRec.Get(Rec."Primary Contact No.") then
                                PAGE.Run(PAGE::"Contact Card", ContactRec);
                    end;
                }
                field("Contact Name"; ContactName)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Name';
                    trigger OnDrillDown()
                    var
                        ContactRec: Record Contact;
                    begin
                        if Rec."Primary Contact No." <> '' then
                            if ContactRec.Get(Rec."Primary Contact No.") then
                                PAGE.Run(PAGE::"Contact Card", ContactRec);
                    end;
                }
            }
            cuegroup("Sales Documents")
            {
                field(OpenSalesOrdersCount; OpenSalesOrdersCount)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open);//, SalesHeader.Status::Released);
                        PAGE.Run(PAGE::"Sales Order List", SalesHeader);
                    end;
                }
                field(OpenSalesInvoicesCount; OpenSalesInvoicesCount)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                        PAGE.Run(PAGE::"Sales Invoice List", SalesHeader);
                    end;
                }
            }
        }
    }
    var
        ContactNo: Code[20];
        ContactName: Text[100];
        OpenSalesOrdersCount: Integer;
        OpenSalesInvoicesCount: Integer;
        contentVisible: Boolean;

    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        ContactRec: Record Contact;
    begin
        // Find Contact linked to Customer
        Clear(ContactNo);
        Clear(ContactName);
        contentVisible := false;
        ContactNo := '';
        ContactName := '';
        if Rec."Primary Contact No." <> '' then begin
            ContactNo := Rec."Primary Contact No.";
            if ContactRec.Get(ContactNo) then
                ContactName := ContactRec.Name;
            contentVisible := true;
        end;
        // Count Open Sales Orders
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::Released);
        OpenSalesOrdersCount := SalesHeader.Count;
        // Count Unposted Sales Invoices
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
        OpenSalesInvoicesCount := SalesHeader.Count;
    end;
}
