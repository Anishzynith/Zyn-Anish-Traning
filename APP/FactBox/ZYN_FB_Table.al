table 50106 "Customer Sales Overview Cue"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Customer No."; Code[20]) { Caption = 'Customer No.'; }
        field(2; "Open Sales Orders"; Integer) { Caption = 'Open Sales Orders'; }
        field(3; "Open Sales Invoices"; Integer) { Caption = 'Unposted Sales Invoices'; }
    }
    keys
    {
        key(PK; "Customer No.") { Clustered = true; }
    }
}
