table 50126 Employee_Table
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Employee_ID; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            AutoIncrement = true;
        }
        field(2; Employee_Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Role; Enum Role_Enum)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Enum Department_Enum)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; Employee_ID)
        {
            Clustered = true;
        }
    }
}