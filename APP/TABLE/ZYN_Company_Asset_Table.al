table 50132 ZYN_Company_Asset_Table
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Asset_Type; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Asset_Table.Asset_Name;
            Caption = 'Asset Type';
            ToolTip = 'Enter Asset Type';
        }
        field(2; Serial_NO; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serial No.';
            ToolTip = 'Enter Serial No.';
        }
        field(3; Procured_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Procured Date';
            ToolTip = 'Enter Procured Date';
        }
        field(4; Vendor_Name; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
            ToolTip = 'Enter Vendor Name';
        }
        field(5; Available_Asset; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Available Asset';
            ToolTip = 'Enter Avilable Asset';
        }
        field(6; ID; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'ID';
            ToolTip = 'Enter ID';
        }
        field(7; Is_Lost; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Is Lost';
            ToolTip = 'Enter Is Lost';
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