tableextension 50107 Employee_Asset_Table extends Employee_Table
{
    fields
    {
        field(12; Employee_No; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee_Table.Employee_ID;
        }
        field(5; Serial_NO; Code[20])
        {
            //  TableRelation = Company_Asset_Table.Serial_NO;
            DataClassification = ToBeClassified;
        }
        field(6; Asset_Status; Enum Asset_Status_Enum)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Assigned_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Returned_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Lost_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Asset_Type; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company_Asset_Table.Asset_Type;
        }
        field(13; Asset_ID; Code[20])
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            var
                AssetRec: Record Company_Asset_Table;
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