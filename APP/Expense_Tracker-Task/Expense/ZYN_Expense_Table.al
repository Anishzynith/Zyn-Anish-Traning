table 50115 Expense_Tracker
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Expense_ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; ExpenseDescription; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; ExpenseAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Expense_Category; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense_Category_Table".ExpenseCategory_Name;
        }
        field(6; ExpenseDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; RemainingBudget; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Budget';
        }
    }
    keys
    {
        key(Pk; Expense_ID)
        {
            Clustered = true;
        }
    }
    var
        ExpenseBudget: Record ExpenseBudget_Table;
        ExpenseTracker: Record Expense_Tracker;
}

