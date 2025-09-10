table 50120 Income_Tracker
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Income_ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;

        }
        field(2; IncomeDescription; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; IncomeAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; Income_Category; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Income_Category_Table".IncomeCategory_Name;

        }
        field(6; IncomeDate; Date)
        {
            DataClassification = ToBeClassified;
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