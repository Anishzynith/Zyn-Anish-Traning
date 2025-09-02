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
        // field(4; "Expense_Category_ID"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Expense Category';
        //     TableRelation = "Expense_Category_Table".Category_ID;

        //     trigger OnValidate()
        //     var
        //         CategoryRec: Record "Expense_Category_Table";
        //     begin
        //         if CategoryRec.Get("Expense_Category_ID") then
        //             Expense_Category := CategoryRec.Category_Name;
        //     end;
        // }
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
    /*
        procedure GetRemainingBudget(CategoryCode: Code[20]; ExpenseDate: Date): Decimal
        var
            ExpenseCategory: Record Expense_Category_Table;
            ExpenseTracker: Record Expense_Tracker;
            FromDate: Date;
            ToDate: Date;

            TotalSpent: Decimal;
            Remaining: Decimal;
        begin
            // Get category budget
            if ExpenseCategory.Get(CategoryCode) then begin
                ExpenseTracker.Reset();
                ExpenseTracker.SetRange("Expense_Category", CategoryCode);
                ExpenseTracker.SetFilter(ExpenseDate, '%1..%2', CalcDate('<-CM>', ExpenseDate), CalcDate('<CM>', ExpenseDate));
                if ExpenseTracker.FindSet() then
                    repeat
                        TotalSpent += ExpenseTracker.ExpenseAmount;
                    until ExpenseTracker.Next() = 0;

                Remaining := ExpenseCategory."BudgetAmount" - TotalSpent;

                if Remaining < 0 then
                    Remaining := 0;  // ✅ Never allow negative

                exit(Remaining);
            end;

            exit(0);
        end;
        */

   


}

