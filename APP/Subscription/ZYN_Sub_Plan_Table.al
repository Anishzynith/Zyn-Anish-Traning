table 50133 ZYN_Sub_Plan_Table
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Plan_ID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Plan_Fees; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Plan_Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Plan_Status; Enum ZYN_Plan_Status_Enum)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Plan_ID)
        {
            Clustered = true;
        }
    }
}