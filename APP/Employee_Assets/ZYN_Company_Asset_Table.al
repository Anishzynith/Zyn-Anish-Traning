table 50132 Company_Asset_Table
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Asset_Type; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Asset_Table.Asset_Name;
        }
        field(2; Serial_NO; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Procured_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Vendor_Name; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Available_Asset; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; ID; Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(7; Is_Lost; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK2; Asset_Type, Serial_NO, ID)
        {
            Clustered = true;
        }
    }
}