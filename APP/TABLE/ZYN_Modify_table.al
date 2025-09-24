
table 50102 ZYN_ModifyTable
{
    DataClassification = ToBeClassified;
    Caption = 'Modify Table';
    TableType = Normal;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
            //TableRelation = Customer;
        }
        field(2; "No."; Code[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Customer No.';
            //TableRelation = Customer;
        }
        field(3; "Field"; Text[60])
        {
            DataClassification = ToBeClassified;
            Caption = 'Field';
        }
        field(4; "OldValue"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Old Value';
        }
        field(5; "NewValue"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Value';
        }
        field(6; "UserID"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'User ID';
        }
    }
    keys
    {
        key(PK; "Entry No.", Field, "No.")
        {
            Clustered = true;
        }
    }
}
