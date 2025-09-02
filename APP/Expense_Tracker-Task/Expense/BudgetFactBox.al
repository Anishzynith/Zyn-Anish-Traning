page 50145 "Category FactBox"
{
    PageType = CardPart;
    SourceTable = Expense_Category_Table;
    ApplicationArea = All;
    Caption = 'Category Budget Info';

    layout
    {
        area(content)
        {
            cuegroup("Budget Category Budget Info")
            {
                field("Budget Current Year"; BudgetCurrentYear)
                {
                    ApplicationArea = All;
                    Caption = 'Current Year';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Budget: Record ExpenseBudget_Table;
                        StartD: Date;
                        EndD: Date;
                    begin
                        GetCYRange(StartD, EndD);
                        Budget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Budget.SetRange(From_Date, StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Budget);
                    end;
                }

                field("Budget Current Month"; BudgetCurrentMonth)
                {
                    ApplicationArea = All;
                    Caption = 'Current Month';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Budget: Record ExpenseBudget_Table;
                        StartD: Date;
                        EndD: Date;
                    begin
                        GetCMRange(StartD, EndD);
                        Budget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Budget.SetRange(From_Date, StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Budget);
                    end;
                }

                field("Budget Current Quarter"; BudgetCurrentQuarter)
                {
                    ApplicationArea = All;
                    Caption = 'Current Quarter';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Budget: Record ExpenseBudget_Table;
                        StartD: Date;
                        EndD: Date;
                    begin
                        GetCQRange(StartD, EndD);
                        Budget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Budget.SetRange(From_Date, StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Budget);
                    end;
                }

                field("Budget Current Half Year"; BudgetCurrentHalfYear)
                {
                    ApplicationArea = All;
                    Caption = 'Current Half-Year';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Budget: Record ExpenseBudget_Table;
                        StartD: Date;
                        EndD: Date;
                    begin
                        GetHalfYearRange(StartD, EndD);
                        Budget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Budget.SetRange(From_Date, StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Budget);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Budget: Record ExpenseBudget_Table;
        StartD: Date;
        EndD: Date;
    begin
        // Current Year
        GetCYRange(StartD, EndD);
        Budget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        Budget.SetRange(From_Date, StartD, EndD);
        Budget.CalcSums(Budget_Amount);
        BudgetCurrentYear := Budget.Budget_Amount;

        // Current Month
        GetCMRange(StartD, EndD);
        Budget.SetRange(From_Date, StartD, EndD);
        Budget.CalcSums(Budget_Amount);
        BudgetCurrentMonth := Budget.Budget_Amount;

        // Current Quarter
        GetCQRange(StartD, EndD);
        Budget.SetRange(From_Date, StartD, EndD);
        Budget.CalcSums(Budget_Amount);
        BudgetCurrentQuarter := Budget.Budget_Amount;

        // Current Half-Year
        GetHalfYearRange(StartD, EndD);
        Budget.SetRange(From_Date, StartD, EndD);
        Budget.CalcSums(Budget_Amount);
        BudgetCurrentHalfYear := Budget.Budget_Amount;

        // Current Year Budget
        //  BudgetCurrentYearBudget := GetCurrentYearBudget(Rec.BudgetCategory_Name);
        RemainingBudget := RemainingBudgetMgt.GetRemainingBudget(Rec.ExpenseCategory_Name);

        //RemainingBudget := BudgetCurrentYearBudget - BudgetCurrentYear;
    end;

    var
        BudgetCurrentYear: Decimal;
        BudgetCurrentMonth: Decimal;
        BudgetCurrentQuarter: Decimal;
        BudgetCurrentHalfYear: Decimal;
        BudgetCurrentYearBudget: Decimal;
        RemainingBudget: Decimal;
        RemainingBudgetMgt: Codeunit "Remaining Budget";
        BudgetCurrentHalfYearBudget: Decimal;
        BudgetCurrentQuarterYearBudget: Decimal;
        BudgetCurrentMonthBudget: Decimal;

    // ------------------ Local Procedures ------------------

    local procedure GetCYRange(var StartDate: Date; var EndDate: Date)
    begin
        StartDate := DMY2DATE(1, 1, Date2DMY(WorkDate(), 3));   // Jan 1 current year
        EndDate := DMY2DATE(31, 12, Date2DMY(WorkDate(), 3));  // Dec 31 current year
    end;

    local procedure GetCMRange(var StartDate: Date; var EndDate: Date)
    var
        m: Integer;
        y: Integer;
    begin
        m := Date2DMY(WorkDate(), 2);
        y := Date2DMY(WorkDate(), 3);
        StartDate := DMY2DATE(1, m, y);
        EndDate := CalcDate('<CM>', WorkDate()); // end of current month
    end;

    local procedure GetCQRange(var StartDate: Date; var EndDate: Date)
    var
        q: Integer;
        y: Integer;
    begin
        y := Date2DMY(WorkDate(), 3);
        q := (Date2DMY(WorkDate(), 2) - 1) DIV 3 + 1; // Quarter number (1–4)

        case q of
            1:
                begin
                    StartDate := DMY2DATE(1, 1, y);
                    EndDate := DMY2DATE(31, 3, y);
                end;
            2:
                begin
                    StartDate := DMY2DATE(1, 4, y);
                    EndDate := DMY2DATE(30, 6, y);
                end;
            3:
                begin
                    StartDate := DMY2DATE(1, 7, y);
                    EndDate := DMY2DATE(30, 9, y);
                end;
            4:
                begin
                    StartDate := DMY2DATE(1, 10, y);
                    EndDate := DMY2DATE(31, 12, y);
                end;
        end;
    end;

    local procedure GetHalfYearRange(var StartDate: Date; var EndDate: Date)
    var
        m: Integer;
        y: Integer;
    begin
        m := Date2DMY(WorkDate(), 2);
        y := Date2DMY(WorkDate(), 3);

        if m <= 6 then begin
            StartDate := DMY2DATE(1, 1, y);
            EndDate := DMY2DATE(30, 6, y);
        end else begin
            StartDate := DMY2DATE(1, 7, y);
            EndDate := DMY2DATE(31, 12, y);
        end;
    end;
}