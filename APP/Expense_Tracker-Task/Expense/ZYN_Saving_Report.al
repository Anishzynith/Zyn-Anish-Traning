report 50107 "Savings_Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Savings Report';

    ProcessingOnly = true;

    dataset { }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(ReportYear; ReportYear)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                    ToolTip = 'Enter the year for which you want to generate the savings report.';
                }
            }
        }
    }

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        ExpenseCat: Record Expense_Category_Table;
        ExpenseRec: Record Expense_Tracker;
        BudgetRec: Record ExpenseBudget_Table;
        IncomeRec: Record Income_Tracker;

        MonthText: Text[30];
        BudgetAmt: Decimal;
        ExpenseAmt: Decimal;
        IncomeAmt: Decimal;
        TotalIncome: Decimal;
        TotalExpense: Decimal;
        Savings: Decimal;

        ReportYear: Integer;
        CurrentMonth: Integer;
        FirstDay: Date;
        LastDay: Date;

    trigger OnPostReport()
    begin
        // --- Create Excel header ---
        ExcelBuf.CreateNewBook('Savings Report');
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Month', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Category', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Budget Amount', false, '', true, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Expense Amount', false, '', true, false, false, '', ExcelBuf."Cell Type"::Number);

        AddDataToExcel();

        ExcelBuf.WriteSheet('Savings Report', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;

    local procedure AddDataToExcel()
    begin
        for CurrentMonth := 1 to 12 do begin
            FirstDay := DMY2Date(1, CurrentMonth, ReportYear);
            LastDay := CalcDate('<CM+1M-1D>', FirstDay);
            MonthText := Format(FirstDay, 0, '<Month Text>') + ' ' + Format(FirstDay, 0, '<Year4>');

            // Reset totals for month
            TotalIncome := 0;
            TotalExpense := 0;

            // --- Per Category loop ---
            ExpenseCat.Reset();
            if ExpenseCat.FindSet() then
                repeat
                    // --- Budget ---
                    BudgetAmt := 0;
                    BudgetRec.Reset();
                    BudgetRec.SetRange(Expense_Category, ExpenseCat.ExpenseCategory_Name);
                    BudgetRec.SetRange(From_Date, FirstDay, LastDay);
                    if BudgetRec.FindFirst() then
                        BudgetAmt := BudgetRec.Budget_Amount;

                    // --- Expense ---
                    ExpenseAmt := 0;
                    ExpenseRec.Reset();
                    ExpenseRec.SetRange(Expense_Category, ExpenseCat.ExpenseCategory_Name);
                    ExpenseRec.SetRange(ExpenseDate, FirstDay, LastDay);
                    if ExpenseRec.FindSet() then
                        repeat
                            ExpenseAmt += ExpenseRec.ExpenseAmount;
                        until ExpenseRec.Next() = 0;

                    // --- Write Row ---
                    ExcelBuf.NewRow();
                    ExcelBuf.AddColumn(MonthText, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(ExpenseCat.ExpenseCategory_Name, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(BudgetAmt, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(ExpenseAmt, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);

                    // Add to total expense
                    TotalExpense += ExpenseAmt;

                until ExpenseCat.Next() = 0;

            // --- Income for the month ---
            // --- Income ---
            IncomeAmt := 0;
            IncomeRec.Reset();
            IncomeRec.SetRange(IncomeDate, FirstDay, LastDay); // Make sure IncomeDate is Date type
            if IncomeRec.FindSet() then
                repeat
                    IncomeAmt += IncomeRec.IncomeAmount;
                until IncomeRec.Next() = 0;

            TotalIncome := IncomeAmt; // Only this month’s income
            Savings := TotalIncome - TotalExpense;


            // --- Summary Rows ---
            // 1. Total Income
            ExcelBuf.NewRow();
            ExcelBuf.AddColumn(MonthText, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('TOTAL INCOME', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TotalIncome, false, '', true, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

            // 2. Total Expense
            ExcelBuf.NewRow();
            ExcelBuf.AddColumn(MonthText, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('TOTAL EXPENSE', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(TotalExpense, false, '', true, false, false, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);

            // 3. Savings
            // Savings Row
            ExcelBuf.NewRow();
            ExcelBuf.AddColumn(MonthText, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('SAVINGS', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text); // Empty for Budget column
            ExcelBuf.AddColumn(Savings, false, '', true, false, false, '', ExcelBuf."Cell Type"::Number);

        end;
    end;
}
