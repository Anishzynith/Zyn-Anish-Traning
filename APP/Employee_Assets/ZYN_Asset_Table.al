table 50131 Asset_Table
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Asset_Category; Enum Asset_Category_Enum)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Asset_Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK1; Asset_Category, Asset_Name)
        {
            Clustered = true;
        }
    }
}