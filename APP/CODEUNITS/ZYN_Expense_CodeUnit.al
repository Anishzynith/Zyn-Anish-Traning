codeunit 50111 "ZYN_Remaining Budget"
{
    procedure GetRemainingBudget(Category: Code[50]): Decimal
    var
        BudgetRec: Record ZYN_ExpenseBudget_Table;
        ExpenseRec: Record ZYN_Expense_Tracker;
        StartDate: Date;
        EndDate: Date;
        ExpenseAmount: Decimal;
        RemainingBudget: Decimal;
    begin
        // Get current month range
        StartDate := CalcDate('<-CM>', WorkDate()); // first day of current month
        EndDate := CalcDate('<CM>', WorkDate());    // last day of current month
        // Find budget for this category in this month
        BudgetRec.Reset();
        BudgetRec.SetRange(Expense_Category, Category);
        BudgetRec.SetRange(From_Date, StartDate);
        BudgetRec.SetRange(To_Date, EndDate);
        if BudgetRec.FindFirst() then begin
            // Calculate all expenses for this category in this month
            ExpenseRec.Reset();
            ExpenseRec.SetRange("Expense_Category", Category);
            ExpenseRec.SetRange("ExpenseDate", StartDate, EndDate);
            ExpenseRec.CalcSums(ExpenseAmount);
            ExpenseAmount := ExpenseRec.ExpenseAmount;
            RemainingBudget := BudgetRec.Budget_Amount - ExpenseAmount;
        end else begin
            ExpenseAmount := 0;
            RemainingBudget := 0;
        end;
        exit(RemainingBudget);
    end;
}
