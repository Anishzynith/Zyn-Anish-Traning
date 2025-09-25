table 50120 ZYN_Income_Tracker
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Income Tracker';
    fields
    {
        field(1; Income_ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
            Caption = 'Income ID';
        }
        field(2; IncomeDescription; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Income Description';
        }
        field(3; IncomeAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Income Amount';
        }
        field(5; Income_Category; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Income_Category_Table.IncomeCategory_Name;
            Caption = 'Income Category';
        }
        field(6; IncomeDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Income Date';
        }
    }
    keys
    {
        key(Pk; Income_ID)
        {
            Clustered = true;
        }
    }
}