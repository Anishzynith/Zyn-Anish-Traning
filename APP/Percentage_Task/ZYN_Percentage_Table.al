table 50108 Percentage_Table
{
    Caption = 'Percentage_Table';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            // TableRelation = Percentage_Table.Description;
        }
        field(3; "Percentage Increase"; Decimal)
        {
            Caption = 'Percentage Increase';
            DataClassification = ToBeClassified;
            //  TableRelation = Percentage_Table."Percentage Increase";
        }
        field(4; StartYear; Integer)
        {
            Caption = 'Start Year';
            DataClassification = ToBeClassified;
            //   TableRelation = Percentage_Table.StartYear;
        }
        field(5; EndYear; Integer)
        {
            Caption = 'End Year';
            DataClassification = ToBeClassified;
            //   TableRelation = Percentage_Table.EndYear;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}


