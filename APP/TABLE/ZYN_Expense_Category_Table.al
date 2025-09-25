table 50116 ZYN_Expense_Category_Table
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Expense Category';
    fields
    {
        field(1; ExpenseCategory_ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Category ID';
            ToolTip = 'Enter Category';
        }
        field(2; ExpenseCategory_Name; code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Expense Category Name';
            ToolTip = 'Enter Expense Category Name';
        }
        field(3; ExpenseDescription; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Expense Description';
            ToolTip = 'Enter Expense Description';
        }
        field(4; BudgetAmount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget Amount';
            ToolTip = 'Enter Budget Amount';
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