table 50138 "ZYN_Sales Invoice Text Code"

{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; lineNO; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Sell to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Type"; Enum "Sales Document Type")
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Language Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Text; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Selection; Enum ZYN_BeginEnd_Enum)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; lineNO, "No.", Selection, "Language Code", "Document Type")
        {
            Clustered = true;
        }
    }
}