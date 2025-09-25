table 50122 ZYN_Income_Category_Table
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Income Category Table';
    fields
    {
        field(1; IncomeCategory_ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Category ID';
        }
        field(2; IncomeCategory_Name; code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Income Category Name';
        }
        field(3; IncomeDescription; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Income Description';
        }
    }
    keys
    {
        key(PK; IncomeCategory_Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; IncomeCategory_Name) { }
    }
}