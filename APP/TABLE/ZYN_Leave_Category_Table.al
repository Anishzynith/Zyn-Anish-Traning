table 50127 ZYN_Leave_Category_Table
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Leave_Description; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Leave_Category_Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Number_of_Days; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Leave_Category_Name)
        {
            Clustered = true;
        }
    }
}