table 50131 ZYN_Asset_Table
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Asset';
    fields
    {
        field(1; Asset_Category; Enum ZYN_Asset_Category_Enum)
        {
            DataClassification = ToBeClassified;
            Caption = 'Asset Category';
            ToolTip = 'Enter Asset Category';
        }
        field(2; Asset_Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Asset Name';
            ToolTip = 'Enter Asset Name';
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