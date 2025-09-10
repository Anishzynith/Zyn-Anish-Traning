
page 50130 "Category Expense FactBox"
{
    PageType = CardPart;
    SourceTable = Expense_Category_Table;
    ApplicationArea = All;
    Caption = 'Category Expense Info';

    layout
    {
        area(content)
        {
            cuegroup("Expense Category Expense Info")
            {
                field("Expense Current Year"; ExpenseCurrentYear)
                {
                    ApplicationArea = All;
                    Caption = 'Current Year';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                        StartD: Date;
                        EndD: Date;
                    begin
                        GetCYRange(StartD, EndD);
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Expense.SetRange(ExpenseDate, StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }

                field("Expense Current Month"; ExpenseCurrentMonth)
                {
                    ApplicationArea = All;
                    Caption = 'Current Month';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                        StartD: Date;
                        EndD: Date;
                    begin
                        GetCMRange(StartD, EndD);
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Expense.SetRange(ExpenseDate, StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }

                field("Expense Current Quarter"; ExpenseCurrentQuarter)
                {
                    ApplicationArea = All;
                    Caption = 'Current Quarter';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                        StartD: Date;
                        EndD: Date;
                    begin
                        GetCQRange(StartD, EndD);
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Expense.SetRange(ExpenseDate, StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }

                field("Expense Current Half Year"; ExpenseCurrentHalfYear)
                {
                    ApplicationArea = All;
                    Caption = 'Current Half-Year';
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                        StartD: Date;
                        EndD: Date;
                    begin
                        GetHalfYearRange(StartD, EndD);
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Expense.SetRange(ExpenseDate, StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }


            }
            field(RemainingBudget; RemainingBudget)
            {
                ApplicationArea = All;
                Caption = 'Remaining Budget';
            }

        }
    }

    trigger OnAfterGetRecord()
    var
        Expense: Record Expense_Tracker;
        StartD: Date;
        EndD: Date;
    begin
        // Current Year
        GetCYRange(StartD, EndD);
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        Expense.SetRange(ExpenseDate, StartD, EndD);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentYear := Expense.ExpenseAmount;

        // Current Month
        GetCMRange(StartD, EndD);
        Expense.SetRange(ExpenseDate, StartD, EndD);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentMonth := Expense.ExpenseAmount;

        // Current Quarter
        GetCQRange(StartD, EndD);
        Expense.SetRange(ExpenseDate, StartD, EndD);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentQuarter := Expense.ExpenseAmount;

        // Current Half-Year
        GetHalfYearRange(StartD, EndD);
        Expense.SetRange(ExpenseDate, StartD, EndD);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentHalfYear := Expense.ExpenseAmount;

        // Current Year Budget
        //  ExpenseCurrentYearBudget := GetCurrentYearBudget(Rec.ExpenseCategory_Name);
        RemainingBudget := RemainingBudgetMgt.GetRemainingBudget(Rec.ExpenseCategory_Name);

        //RemainingBudget := ExpenseCurrentYearBudget - ExpenseCurrentYear;
    end;

    var
        ExpenseCurrentYear: Decimal;
        ExpenseCurrentMonth: Decimal;
        ExpenseCurrentQuarter: Decimal;
        ExpenseCurrentHalfYear: Decimal;
        ExpenseCurrentYearBudget: Decimal;
        RemainingBudget: Decimal;
        RemainingBudgetMgt: Codeunit "Remaining Budget";
        ExpenseCurrentHalfYearBudget: Decimal;
        ExpenseCurrentQuarterYearBudget: Decimal;
        ExpenseCurrentMonthBudget: Decimal;

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

    local procedure GetCurrentYearBudget(Category: Code[100]): Decimal
    var
        ExpenseBudget: Record ExpenseBudget_Table;
        StartD: Date;
        EndD: Date;
        TotalBudget: Decimal;
    begin
        GetCYRange(StartD, EndD);
        ExpenseBudget.SetRange(Expense_Category, Category);
        ExpenseBudget.SetRange(From_Date, StartD, EndD);

        if ExpenseBudget.FindSet() then
            repeat
                TotalBudget += ExpenseBudget.Budget_Amount;
            until ExpenseBudget.Next() = 0;

        exit(TotalBudget);
    end;
}


//--------------------------------------------------------------------------

