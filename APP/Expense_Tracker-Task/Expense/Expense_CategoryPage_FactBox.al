// page 50128 "Expense Summary FactBox"
// {
//     PageType = CardPart;
//     SourceTable = "Expense_Category_Table";
//     ApplicationArea = All;
//     Caption = 'Expense Summary';

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'Period Totals';
//                 field("Current Month"; CurrMonthTotal) { ApplicationArea = All; }
//                 field("Current Quarter"; CurrQuarterTotal) { ApplicationArea = All; }
//                 field("Current Half Year"; CurrHalfYearTotal) { ApplicationArea = All; }
//                 field("Current Year"; CurrYearTotal) { ApplicationArea = All; }
//             }
//         }
//     }

//     var
//         CurrMonthTotal: Decimal;
//         CurrQuarterTotal: Decimal;
//         CurrHalfYearTotal: Decimal;
//         CurrYearTotal: Decimal;

//     trigger OnAfterGetRecord()
//     var
//         today: Date;
//     begin
//         today := Today;

//         CurrMonthTotal := CalcExpense(CalcDate('<-CM>', today), CalcDate('<CM>', today));
//         CurrQuarterTotal := CalcExpense(CalcDate('<-CQ>', today), CalcDate('<CQ>', today));
//         CurrHalfYearTotal := CalcExpense(CalcDate('<-CY-6M>', today), CalcDate('<CY>', today));
//         CurrYearTotal := CalcExpense(CalcDate('<-CY>', today), CalcDate('<CY>', today));
//     end;

//     local procedure CalcExpense(StartDate: Date; EndDate: Date): Decimal
//     var
//         Exp: Record Expense_Tracker;
//         total: Decimal;
//     begin
//         Exp.Reset();
//         Exp.SetRange(Expense_Category, Rec."Category_Name"); // filter by selected row
//         Exp.SetRange(Date, StartDate, EndDate);

//         if Exp.FindSet() then
//             repeat
//                 total += Exp.Amount;
//             until Exp.Next() = 0;

//         exit(total);
//     end;
// }

/*
page 50129 "Category Expense FactBox"
{
    PageType = CardPart;
    SourceTable = Expense_Category_Table;
    ApplicationArea = All;
    Caption = 'Category Expense Info';

    layout
    {
        area(content)
        {
            cuegroup("Category Expense Info")
            {
                field("Current Year"; CurrentYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                    begin
                        Expense.SetRange(Expense_Category, Rec.Category_Name);
                        Expense.SetRange("Date", DMY2DATE(1, 1, DATE2DMY(WorkDate(), 3)), WorkDate()); // Jan 1 -> Today
                        PAGE.Run(PAGE::Expense_Category_ListPage, Expense);
                    end;
                }
                field("Current Month"; CurrentMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                    begin
                        Expense.SetRange(Expense_Category, Rec.Category_Name);
                        Expense.SetRange("Date",
    DMY2DATE(1, DATE2DMY(WorkDate(), 2), DATE2DMY(WorkDate(), 3)), // First day of this month
    WorkDate());                                              // Till today
                        PAGE.Run(PAGE::Expense_Category_ListPage, Expense);
                    end;
                }
                field("Current Half Year"; CurrentHalfYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Half Year';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                    begin
                        Expense.SetRange(Expense_Category, Rec.Category_Name);
                        if DATE2DMY(WorkDate(), 2) <= 6 then
                            Expense.SetRange("Date", DMY2DATE(1, 1, DATE2DMY(WorkDate(), 3)), WorkDate())
                        else
                            Expense.SetRange("Date", DMY2DATE(1, 7, DATE2DMY(WorkDate(), 3)), WorkDate());
                        PAGE.Run(PAGE::Expense_Category_ListPage, Expense);
                    end;
                }
                field("Current Quarter"; CurrentQuarter)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                    begin
                        Expense.SetRange(Expense_Category, Rec.Category_Name);
                        Expense.SetRange("Date", CalcQuarterStart(WorkDate()), WorkDate());
                        PAGE.Run(PAGE::Expense_Category_ListPage, Expense);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Expense: Record Expense_Tracker;
        StartDate: Date;
        Month: Integer;
        Year: Integer;
    begin
        Month := DATE2DMY(WorkDate(), 2);
        Year := DATE2DMY(WorkDate(), 3);

        // -------------------
        // Current Year
        // -------------------
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.Category_Name);
        Expense.SetRange("Date", DMY2DATE(1, 1, Year), WorkDate()); // 01-Jan-Year → Today
        Expense.CalcSums(Amount);
        CurrentYear := Expense.Amount;

        // -------------------
        // Current Month
        // -------------------
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.Category_Name);
        Expense.SetRange("Date",
    DMY2DATE(1, DATE2DMY(WorkDate(), 2), DATE2DMY(WorkDate(), 3)), // First day of this month
    WorkDate());                                              // Till today
        Expense.CalcSums(Amount);
        CurrentMonth := Expense.Amount;

        // -------------------
        // Current Half Year
        // -------------------
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.Category_Name);

        if Month <= 6 then
            StartDate := DMY2DATE(1, 1, Year)   // First half-year (Jan–Jun)
        else
            StartDate := DMY2DATE(1, 7, Year);  // Second half-year (Jul–Dec)

        Expense.SetRange("Date", StartDate, WorkDate());
        Expense.CalcSums(Amount);
        CurrentHalfYear := Expense.Amount;

        // -------------------
        // Current Quarter
        // -------------------
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.Category_Name);
        StartDate := CalcQuarterStart(WorkDate());   // helper function
        Expense.SetRange("Date", StartDate, WorkDate());
        Expense.CalcSums(Amount);
        CurrentQuarter := Expense.Amount;
    end;

    local procedure CalcQuarterStart(RefDate: Date): Date
    var
        Month: Integer;
        Year: Integer;
    begin
        Month := DATE2DMY(RefDate, 2);
        Year := DATE2DMY(RefDate, 3);

        case true of
            Month in [1 .. 3]:
                exit(DMY2DATE(1, 1, Year));   // Q1 → Jan 1
            Month in [4 .. 6]:
                exit(DMY2DATE(1, 4, Year));   // Q2 → Apr 1
            Month in [7 .. 9]:
                exit(DMY2DATE(1, 7, Year));   // Q3 → Jul 1
            Month in [10 .. 12]:
                exit(DMY2DATE(1, 10, Year));  // Q4 → Oct 1
        end;
    end;


    var
        CurrentYear: Decimal;
        CurrentMonth: Decimal;
        CurrentHalfYear: Decimal;
        CurrentQuarter: Decimal;
}
*/
//--------------------------------------------------------------------------
/*
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
            cuegroup("ExpenseCategory Expense Info")
            {
                field("ExpenseCurrent Year"; ExpenseCurrentYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                    begin
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        StartDate := DMY2DATE(1, 1, Year);
                        EndDate := DMY2DATE(31, 12, Year);
                        Expense.SetRange("ExpenseDate", StartDate, EndDate);
 
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }
                field("ExpenseCurrent Month"; ExpenseCurrentMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                    begin
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        Expense.SetRange("ExpenseDate", DMY2DATE(1, DATE2DMY(WorkDate(), 2), DATE2DMY(WorkDate(), 3)), WorkDate());               // First day of this month
                                                                                                                                           // Till today
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }
                field("ExpenseCurrent Half Year"; ExpenseCurrentHalfYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Half Year';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                    begin
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        if Month <= 6 then begin
                            StartDate := DMY2DATE(1, 1, Year);
                            Enddate := DMY2DATE(30, 6, Year);
 
                        end
                        else begin
                            StartDate := DMY2DATE(1, 7, Year);
                            EndDate := DMY2DATE(31, 12, Year);
 
                        end;
                        Expense.SetRange("ExpenseDate", StartDate, EndDate);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
 
                    end;
                }
                field("ExpenseCurrent Quarter"; ExpenseCurrentQuarter)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                    begin
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        if Month in [1 .. 3] then begin
                            // Q1: Jan 1 – Mar 31
                            StartDate := DMY2DATE(1, 1, Year);
                            EndDate := DMY2DATE(31, 3, Year);
                            // If you want "till WorkDate"
 
                        end else if Month in [4 .. 6] then begin
                            // Q2: Apr 1 – Jun 30
                            StartDate := DMY2DATE(1, 4, Year);
                            EndDate := DMY2DATE(30, 6, Year);
                            // If you want "till WorkDate"
 
                        end else if Month in [7 .. 9] then begin
                            // Q3: Jul 1 – Sep 30
                            StartDate := DMY2DATE(1, 7, Year);
                            EndDate := DMY2DATE(30, 9, Year);
                            // If you want "till WorkDate"
 
                        end else begin
                            // Q4: Oct 1 – Dec 31
                            StartDate := DMY2DATE(1, 10, Year);
                            EndDate := DMY2DATE(31, 12, Year);
 
 
                            Expense.SetRange("ExpenseDate", StartDate, EndDate); // If you want "till WorkDate"
 
                        end;
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }
            }
        }
    }
 
    trigger OnAfterGetRecord()
    var
        Expense: Record Expense_Tracker;
    begin
        Month := DATE2DMY(WorkDate(), 2);
        Year := DATE2DMY(WorkDate(), 3);
 
        // -------------------
        // Current Year
        // -------------------
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        StartDate := DMY2DATE(1, 1, Year);
        EndDate := DMY2DATE(31, 12, Year);
        Expense.SetRange("ExpenseDate", StartDate, EndDate);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentYear := Expense.ExpenseAmount;
 
        // -------------------
        // Current Month
        // -------------------
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        StartDate := DMY2DATE(1, Month, Year);   // First day of current month
        EndDate := WorkDate();                   // Till today
        Expense.SetRange("ExpenseDate", StartDate, EndDate);
        Expense.CalcSums(ExpenseAmount);
       ExpenseCurrentMonth := Expense.ExpenseAmount;
 
        // -------------------
        // Current Half-Year
        // -------------------
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
 
        if Month <= 6 then begin
            StartDate := DMY2DATE(1, 1, Year);   // Jan 1
            EndDate := DMY2DATE(30, 6, Year);    // Jun 30
        end else begin
            StartDate := DMY2DATE(1, 7, Year);   // Jul 1
            EndDate := DMY2DATE(31, 12, Year);   // Dec 31
        end;
 
        Expense.SetRange("ExpenseDate", StartDate, EndDate);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentHalfYear := Expense.ExpenseAmount;
 
        // -------------------
        // Current Quarter
        // -------------------
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
 
        if Month in [1 .. 3] then begin
            StartDate := DMY2DATE(1, 1, Year);   // Jan 1
            EndDate := DMY2DATE(31, 3, Year);    // Mar 31
        end else if Month in [4 .. 6] then begin
            StartDate := DMY2DATE(1, 4, Year);   // Apr 1
            EndDate := DMY2DATE(30, 6, Year);    // Jun 30
        end else if Month in [7 .. 9] then begin
            StartDate := DMY2DATE(1, 7, Year);   // Jul 1
            EndDate := DMY2DATE(30, 9, Year);    // Sep 30
        end else begin
            StartDate := DMY2DATE(1, 10, Year);  // Oct 1
            EndDate := DMY2DATE(31, 12, Year);   // Dec 31
        end;
 
        Expense.SetRange("ExpenseDate", StartDate, EndDate);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentQuarter := Expense.ExpenseAmount;
    end;
 
 
 
 
    var
        ExpenseCurrentYear: Decimal;
        ExpenseCurrentMonth: Decimal;
        ExpenseCurrentHalfYear: Decimal;
        ExpenseCurrentQuarter: Decimal;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Year: Integer;
}
 */
//--------------------------------------------------------------------------
/*
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
                    DrillDown = true;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                        StartD: Date;
                        EndD: Date;
                    begin
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        GetCYRange(StartD, EndD);
                        Expense.SetFilter("ExpenseDate", '%1..%2', StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }

                field("Expense Current Month"; ExpenseCurrentMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                        StartD: Date;
                        EndD: Date;
                    begin
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        GetCMRange(StartD, EndD);
                        Expense.SetFilter("ExpenseDate", '%1..%2', StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }

                field("Expense Current Half Year"; ExpenseCurrentHalfYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Half Year';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                        StartD: Date;
                        EndD: Date;
                    begin
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        GetHalfYearRange(StartD, EndD);
                        Expense.SetFilter("ExpenseDate", '%1..%2', StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }

                field("Expense Current Quarter"; ExpenseCurrentQuarter)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    var
                        Expense: Record Expense_Tracker;
                        StartD: Date;
                        EndD: Date;
                    begin
                        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        GetCQRange(StartD, EndD);
                        Expense.SetFilter("ExpenseDate", '%1..%2', StartD, EndD);
                        PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                    end;
                }
                field("Expense Current Year Budget"; ExpenseCurrentYearBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Current Year Budget';
                    ToolTip = 'The budgeted amount for the current year in this category.';
                    trigger OnDrillDown()
                    var
                        ExpenseBudget: Record ExpenseBudget_Table;
                        StartD: Date;
                        EndD: Date;
                    begin
                        ExpenseBudget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                        GetCYRange(StartD, EndD);
                        ExpenseBudget.SetFilter("From_Date", '%1', StartD);
                        ExpenseBudget.SetFilter("To_Date", '%1', EndD);
                        PAGE.Run(PAGE::ExpenseBudget_Card, ExpenseBudget);
                    end;
                }
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
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        GetCYRange(StartD, EndD);
        Expense.SetFilter("ExpenseDate", '%1..%2', StartD, EndD);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentYear := Expense.ExpenseAmount;

        // Current Month
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        GetCMRange(StartD, EndD);
        Expense.SetFilter("ExpenseDate", '%1..%2', StartD, EndD);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentMonth := Expense.ExpenseAmount;

        // Current Half-Year (no 'CH' token; compute manually)
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        GetHalfYearRange(StartD, EndD);
        Expense.SetFilter("ExpenseDate", '%1..%2', StartD, EndD);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentHalfYear := Expense.ExpenseAmount;

        // Current Quarter
        Expense.Reset();
        Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        GetCQRange(StartD, EndD);
        Expense.SetFilter("ExpenseDate", '%1..%2', StartD, EndD);
        Expense.CalcSums(ExpenseAmount);
        ExpenseCurrentQuarter := Expense.ExpenseAmount;

        // Current Year Budget
        ExpenseBudget.Reset();
        ExpenseBudget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
        GetCYRange(StartD, EndD);
        ExpenseBudget.SetFilter("From_Date", '%1', StartD);
        ExpenseBudget.SetFilter("To_Date", '%1', EndD);
        if ExpenseBudget.FindFirst() then
            ExpenseCurrentYearBudget := ExpenseBudget.Budget_Amount
        else
            ExpenseCurrentYearBudget := 0; // No budget set for this category
        ExpenseCurrentYearBudget := GetCurrentYearBudget(Rec.ExpenseCategory_Name);

    end;

    var
        ExpenseCurrentYear: Decimal;
        ExpenseCurrentMonth: Decimal;
        ExpenseCurrentHalfYear: Decimal;
        ExpenseCurrentQuarter: Decimal;
        ExpenseCurrentYearBudget: Decimal;
        ExpenseBudget: Record ExpenseBudget_Table;

    local procedure GetCYRange(var StartDate: Date; var EndDate: Date)
    begin
        // First and last day of current year
        StartDate := CalcDate('<-CY>', WorkDate());
        EndDate := CalcDate('<CY>', WorkDate());
        
    end;

    local procedure GetCMRange(var StartDate: Date; var EndDate: Date)
    begin
        // First and last day of current month
        StartDate := CalcDate('<-CM>', WorkDate());
        EndDate := CalcDate('<CM>', WorkDate());
    end;

    local procedure GetCQRange(var StartDate: Date; var EndDate: Date)
    begin
        // First and last day of current quarter
        StartDate := CalcDate('<-CQ>', WorkDate());
        EndDate := CalcDate('<CQ>', WorkDate());
    end;

    local procedure GetHalfYearRange(var StartDate: Date; var EndDate: Date)
    var
        m: Integer;
        y: Integer;
    begin
        // No 'CH' token exists → compute manually
        m := Date2DMY(WorkDate(), 2);
        y := Date2DMY(WorkDate(), 3);

        if m <= 6 then begin
            StartDate := DMY2DATE(1, 1, y);   // Jan 1
            EndDate := DMY2DATE(30, 6, y);  // Jun 30
        end else begin
            StartDate := DMY2DATE(1, 7, y);   // Jul 1
            EndDate := DMY2DATE(31, 12, y); // Dec 31
        end;
    end;

    local procedure GetCurrentYearBudget(Category: Code[100]): Decimal
var
    ExpenseBudget: Record ExpenseBudget_Table;
    StartD: Date;
    EndD: Date;
    TotalBudget: Decimal;
begin
    // Get first and last day of the current year
    GetCYRange(StartD, EndD);

    ExpenseBudget.Reset();
    ExpenseBudget.SetRange(Expense_Category, Category);
    ExpenseBudget.SetRange(From_Date, StartD, EndD);

    if ExpenseBudget.FindSet() then
        repeat
            TotalBudget += ExpenseBudget.Budget_Amount;
        until ExpenseBudget.Next() = 0;

    exit(TotalBudget);
end;
    local procedure GetCYRange(var StartD: Date; var EndD: Date)
    begin
        // Dec 31 of current year
    end;
}


*/
//----------------------------------------------------------------------------



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


                // field("Expense Current Year Remaining Budget"; RemainingBudget)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Remaining Budget';
                //     ToolTip = 'The remaining budget for the current year in this category.';
                //     trigger OnDrillDown()
                //     var
                //         RemainingBudgetMgt: Codeunit "Remaining Budget";
                //     begin
                //         RemainingBudget := RemainingBudgetMgt.GetRemainingBudget(Rec.ExpenseCategory_Name);
                //         MESSAGE('Remaining Budget for %1: %2', Rec.ExpenseCategory_Name, RemainingBudget);
                //     end;

                // }
                // field(ExpenseCurrentHalfYearBudget; ExpenseCurrentHalfYearBudget)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Current Half-Year Budget';
                //     ToolTip = 'The budgeted amount for the current half-year in this category.';
                //     trigger OnDrillDown()
                //     var
                //         ExpenseBudget: Record ExpenseBudget_Table;
                //         StartD: Date;
                //         EndD: Date;
                //     begin
                //         GetHalfYearRange(StartD, EndD);
                //         ExpenseBudget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                //         ExpenseBudget.SetRange(From_Date, StartD, EndD);
                //         PAGE.Run(PAGE::Expense_Tracker_Page, ExpenseBudget);
                //     end;
                // }
                // field("Expense Current Year Budget"; ExpenseCurrentYearBudget)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Current Year Budget';
                //     ToolTip = 'The budgeted amount for the current year in this category.';
                //     DrillDown = true;

                //     trigger OnDrillDown()
                //     var
                //         ExpenseBudget: Record ExpenseBudget_Table;
                //         StartD: Date;
                //         EndD: Date;
                //     begin
                //         GetCYRange(StartD, EndD);
                //         ExpenseBudget.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                //         ExpenseBudget.SetRange(From_Date, StartD, EndD);
                //         PAGE.Run(PAGE::Expense_Tracker_Page, ExpenseBudget);
                //     end;
                // }
                // field(ExpenseCurrentQuarterYearBudget; ExpenseCurrentQuarterYearBudget)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Current Quarter';
                //     DrillDown = true;

                //     trigger OnDrillDown()
                //     var
                //         Expense: Record ExpenseBudget_Table;
                //         StartD: Date;
                //         EndD: Date;
                //     begin
                //         GetCQRange(StartD, EndD);
                //         Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                //         Expense.SetRange(From_Date, StartD, EndD);
                //         PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                //     end;
                // }
                // field(ExpenseCurrentMonthBudget; ExpenseCurrentMonthBudget)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Current Month';
                //     DrillDown = true;

                //     trigger OnDrillDown()
                //     var
                //         Expense: Record ExpenseBudget_Table;
                //         StartD: Date;
                //         EndD: Date;
                //     begin
                //         GetCMRange(StartD, EndD);
                //         Expense.SetRange(Expense_Category, Rec.ExpenseCategory_Name);
                //         Expense.SetRange(From_Date, StartD, EndD);
                //         PAGE.Run(PAGE::Expense_Tracker_Page, Expense);
                //     end;
                // }

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

