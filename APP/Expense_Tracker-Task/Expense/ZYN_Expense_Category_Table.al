table 50116 Expense_Category_Table
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ExpenseCategory_ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Category ID';
        }
        field(2; ExpenseCategory_Name; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; ExpenseDescription; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; BudgetAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget Amount';
        }
        
    }

    keys
    {
        key(PK; ExpenseCategory_Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ExpenseCategory_Name) { }
    }

}