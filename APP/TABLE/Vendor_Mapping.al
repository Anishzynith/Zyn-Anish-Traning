table 50140 "Vendor_Mapping"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Master Vendor No."; Code[20]) { }
        field(2; "Slave Company"; Text[30]) { }
        field(3; "Slave Vendor No."; Code[20]) { }
    }

    keys
    {
        key(PK; "Master Vendor No.", "Slave Company") { Clustered = true; }
    }
}
