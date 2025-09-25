tableextension 50107 ZYN_Employee_Asset_Table extends ZYN_Employee_Table
{
    fields
    {
        field(12; Employee_No; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Employee_Table.Employee_ID;
            Caption = 'Employee ID';
            ToolTip = 'Enter Employee ID';
        }
        field(5; Serial_NO; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Serial No.';
            ToolTip = 'Enter Serial No;';
        }
        field(6; Asset_Status; Enum ZYN_Asset_Status_Enum)
        {
            DataClassification = ToBeClassified;
            Caption = 'Asset Status';
            ToolTip = 'Enter Asset Status';
        }
        field(7; Assigned_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Assigned Date';
            ToolTip = 'Enter Assigned Date';
        }
        field(8; Returned_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Returned Date';
            ToolTip = 'Enter Retruned Date';
        }
        field(10; Lost_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Lost Date';
            ToolTip = 'Enter Lost Date';
        }
        field(11; Asset_Type; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Company_Asset_Table.Asset_Type;
            Caption = 'Asset Type';
            ToolTip = 'Enter Asset Type';
        }
        field(13; Asset_ID; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Asset ID';
            ToolTip = 'Enter Asset Type';
            trigger OnValidate()
            var
                AssetRec: Record ZYN_Company_Asset_Table;
            begin
                if AssetRec.Get(Asset_ID) then begin
                    Rec.Serial_NO := AssetRec.Serial_NO;
                    Rec.Asset_Type := AssetRec.Asset_Type; // Optional: auto-fill type too
                end;
            end;
        }
    }
    keys
    {
        // Add changes to keys here
        key(PK3; Asset_Status, Serial_NO, Asset_Type, Asset_ID)
        { }
    }
}