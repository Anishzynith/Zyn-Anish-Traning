table 50114 SubPageTable
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; EntryNO; Integer)
        {
            DataClassification = SystemMetadata;
            // AutoIncrement = true;
            //InitValue = 1;
        }
        field(2; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
            //TableRelation = Percentage_Table.Code;
        }
        field(3; Year; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Year';
        }
        field(4; Value; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Value';
            DecimalPlaces = 2 : 2;
        }
    }
    keys
    {
        key(Key1; EntryNO, Code)
        {
            Clustered = true;
        }
    }
}