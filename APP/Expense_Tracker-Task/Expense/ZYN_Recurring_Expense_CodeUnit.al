  codeunit 50112 "Process Recurring Expenses"
{
    Subtype = Normal;
    trigger OnRun()
    var
        RecurringExpense: Record Recurring_Expense_Table;
    begin
        ProcessRecurringExpenses();
    end;
 
    local procedure ProcessRecurringExpenses()
    var
        RecurringExpense: Record Recurring_Expense_Table;
    begin
        RecurringExpense.Reset();
        RecurringExpense.SetRange(Next_Cycle_Date, WorkDate());
        if RecurringExpense.FindSet() then
            repeat
                CreateExpense(RecurringExpense);
              UpdateNextDate(RecurringExpense);
            until RecurringExpense.Next() = 0;
    end;
 
    local procedure CreateExpense(RecurringExpense: Record Recurring_Expense_Table)
    var
        Expense: Record Expense_Tracker;
    begin
        Expense.Init();
        Expense.ExpenseDate := WorkDate();
        Expense.ExpenseDescription := RecurringExpense.Description;
        Expense.ExpenseAmount := RecurringExpense.Recurring_Amount;
        Expense.Expense_Category := RecurringExpense.Category;
        Expense.Insert();
    end;
 
   local procedure UpdateNextDate(var RecurringExpense: Record Recurring_Expense_Table)
    begin
        case RecurringExpense.Recurring_Cycle of
            RecurringExpense.Recurring_Cycle::Weekly:
                RecurringExpense.Next_Cycle_Date := CalcDate('<+1W>', RecurringExpense.Next_Cycle_Date);
            RecurringExpense.Recurring_Cycle::Monthly:
                RecurringExpense.Next_Cycle_Date := CalcDate('<+1M>', RecurringExpense.Next_Cycle_Date);
            RecurringExpense.Recurring_Cycle::Quarterly:
                RecurringExpense.Next_Cycle_Date := CalcDate('<+3M>', RecurringExpense.Next_Cycle_Date);
            RecurringExpense.Recurring_Cycle::HalfYearly:
                RecurringExpense.Next_Cycle_Date := CalcDate('<+6M>', RecurringExpense.Next_Cycle_Date);
            RecurringExpense.Recurring_Cycle::Yearly:
                RecurringExpense.Next_Cycle_Date := CalcDate('<+1Y>', RecurringExpense.Next_Cycle_Date);
        end;
        RecurringExpense.Modify(true);
    end;  
}
 
 
 
 