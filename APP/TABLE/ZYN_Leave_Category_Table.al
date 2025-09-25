table 50127 ZYN_Leave_Category_Table
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Leave Category Table';
    fields
    {
        field(1; Leave_Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Leave Description';
        }
        field(2; Leave_Category_Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Leave Category Name';
        }
        field(3; Number_of_Days; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No. Of Days';
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