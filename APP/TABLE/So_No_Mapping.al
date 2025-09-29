table 50139 Customer_Mapping
{
    fields
    {
        field(1; "Master Customer No."; Code[20]) { }
        field(2; "Slave Company"; Text[30]) { }
        field(3; "Slave Customer No."; Code[20]) { }
    }
    keys { key(PK; "Master Customer No.", "Slave Company") { Clustered = true; } }
}
