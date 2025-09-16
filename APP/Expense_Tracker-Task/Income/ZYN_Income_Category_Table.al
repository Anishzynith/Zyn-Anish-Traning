table 50122 Income_Category_Table
{
    DataClassification = ToBeClassified;
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
        }
        field(3; IncomeDescription; Text[250])
        {
            DataClassification = ToBeClassified;
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