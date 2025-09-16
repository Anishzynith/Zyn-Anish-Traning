table 50121 "VisitorTable"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "EntryNo"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "CustomerNo"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(3; "Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Purpose"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Notes"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "EntryNo", "CustomerNo")

        {
            Clustered = true;
        }
    }
}