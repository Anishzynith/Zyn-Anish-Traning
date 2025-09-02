// page 50128 "Income Summary FactBox"
// {
//     PageType = CardPart;
//     SourceTable = "Income_Category_Table";
//     ApplicationArea = All;
//     Caption = 'Income Summary';

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

//         CurrMonthTotal := CalcIncome(CalcDate('<-CM>', today), CalcDate('<CM>', today));
//         CurrQuarterTotal := CalcIncome(CalcDate('<-CQ>', today), CalcDate('<CQ>', today));
//         CurrHalfYearTotal := CalcIncome(CalcDate('<-CY-6M>', today), CalcDate('<CY>', today));
//         CurrYearTotal := CalcIncome(CalcDate('<-CY>', today), CalcDate('<CY>', today));
//     end;

//     local procedure CalcIncome(StartDate: Date; EndDate: Date): Decimal
//     var
//         Exp: Record Income_Tracker;
//         total: Decimal;
//     begin
//         Exp.Reset();
//         Exp.SetRange(Income_Category, Rec."Category_Name"); // filter by selected row
//         Exp.SetRange(Date, StartDate, EndDate);

//         if Exp.FindSet() then
//             repeat
//                 total += Exp.Amount;
//             until Exp.Next() = 0;

//         exit(total);
//     end;
// }

/*
page 50129 "Category Income FactBox"
{
    PageType = CardPart;
    SourceTable = Income_Category_Table;
    ApplicationArea = All;
    Caption = 'Category Income Info';

    layout
    {
        area(content)
        {
            cuegroup("Category Income Info")
            {
                field("Current Year"; CurrentYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    var
                        Income: Record Income_Tracker;
                    begin
                        Income.SetRange(Income_Category, Rec.Category_Name);
                        Income.SetRange("Date", DMY2DATE(1, 1, DATE2DMY(WorkDate(), 3)), WorkDate()); // Jan 1 -> Today
                        PAGE.Run(PAGE::Income_Category_ListPage, Income);
                    end;
                }
                field("Current Month"; CurrentMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    var
                        Income: Record Income_Tracker;
                    begin
                        Income.SetRange(Income_Category, Rec.Category_Name);
                        Income.SetRange("Date",
    DMY2DATE(1, DATE2DMY(WorkDate(), 2), DATE2DMY(WorkDate(), 3)), // First day of this month
    WorkDate());                                              // Till today
                        PAGE.Run(PAGE::Income_Category_ListPage, Income);
                    end;
                }
                field("Current Half Year"; CurrentHalfYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Half Year';
                    trigger OnDrillDown()
                    var
                        Income: Record Income_Tracker;
                    begin
                        Income.SetRange(Income_Category, Rec.Category_Name);
                        if DATE2DMY(WorkDate(), 2) <= 6 then
                            Income.SetRange("Date", DMY2DATE(1, 1, DATE2DMY(WorkDate(), 3)), WorkDate())
                        else
                            Income.SetRange("Date", DMY2DATE(1, 7, DATE2DMY(WorkDate(), 3)), WorkDate());
                        PAGE.Run(PAGE::Income_Category_ListPage, Income);
                    end;
                }
                field("Current Quarter"; CurrentQuarter)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    var
                        Income: Record Income_Tracker;
                    begin
                        Income.SetRange(Income_Category, Rec.Category_Name);
                        Income.SetRange("Date", CalcQuarterStart(WorkDate()), WorkDate());
                        PAGE.Run(PAGE::Income_Category_ListPage, Income);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Income: Record Income_Tracker;
        StartDate: Date;
        Month: Integer;
        Year: Integer;
    begin
        Month := DATE2DMY(WorkDate(), 2);
        Year := DATE2DMY(WorkDate(), 3);

        // -------------------
        // Current Year
        // -------------------
        Income.Reset();
        Income.SetRange(Income_Category, Rec.Category_Name);
        Income.SetRange("Date", DMY2DATE(1, 1, Year), WorkDate()); // 01-Jan-Year → Today
        Income.CalcSums(Amount);
        CurrentYear := Income.Amount;

        // -------------------
        // Current Month
        // -------------------
        Income.Reset();
        Income.SetRange(Income_Category, Rec.Category_Name);
        Income.SetRange("Date",
    DMY2DATE(1, DATE2DMY(WorkDate(), 2), DATE2DMY(WorkDate(), 3)), // First day of this month
    WorkDate());                                              // Till today
        Income.CalcSums(Amount);
        CurrentMonth := Income.Amount;

        // -------------------
        // Current Half Year
        // -------------------
        Income.Reset();
        Income.SetRange(Income_Category, Rec.Category_Name);

        if Month <= 6 then
            StartDate := DMY2DATE(1, 1, Year)   // First half-year (Jan–Jun)
        else
            StartDate := DMY2DATE(1, 7, Year);  // Second half-year (Jul–Dec)

        Income.SetRange("Date", StartDate, WorkDate());
        Income.CalcSums(Amount);
        CurrentHalfYear := Income.Amount;

        // -------------------
        // Current Quarter
        // -------------------
        Income.Reset();
        Income.SetRange(Income_Category, Rec.Category_Name);
        StartDate := CalcQuarterStart(WorkDate());   // helper function
        Income.SetRange("Date", StartDate, WorkDate());
        Income.CalcSums(Amount);
        CurrentQuarter := Income.Amount;
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

page 50134 "Category Income FactBox"
{
    PageType = CardPart;
    SourceTable = Income_Category_Table;
    ApplicationArea = All;
    Caption = 'Category Income Info';
 
    layout
    {
        area(content)
        {
            cuegroup("Category Income Info")
            {
                field("IncomeCurrent Year"; IncomeCurrentYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Year';
                    trigger OnDrillDown()
                    var
                        Income: Record Income_Tracker;
                    begin
                        Income.SetRange(Income_Category, Rec.IncomeCategory_Name);
                        StartDate := DMY2DATE(1, 1, Year);
                        EndDate := DMY2DATE(31, 12, Year);
                        Income.SetRange("IncomeDate", StartDate, EndDate);
 
                        PAGE.Run(PAGE::Income_Tracker_Page, Income);
                    end;
                }
                field("IncomeCurrent Month"; IncomeCurrentMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Month';
                    trigger OnDrillDown()
                    var
                        Income: Record Income_Tracker;
                    begin
                        Income.SetRange(Income_Category, Rec.IncomeCategory_Name);
                        Income.SetRange("IncomeDate", DMY2DATE(1, DATE2DMY(WorkDate(), 2), DATE2DMY(WorkDate(), 3)), WorkDate());               // First day of this month
                                                                                                                                           // Till today
                        PAGE.Run(PAGE::Income_Tracker_Page, Income);
                    end;
                }
                field("IncomeCurrent Half Year"; IncomeCurrentHalfYear)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Half Year';
                    trigger OnDrillDown()
                    var
                        Income: Record Income_Tracker;
                    begin
                        Income.SetRange(Income_Category, Rec.IncomeCategory_Name);
                        if Month <= 6 then begin
                            StartDate := DMY2DATE(1, 1, Year);
                            Enddate := DMY2DATE(30, 6, Year);
 
                        end
                        else begin
                            StartDate := DMY2DATE(1, 7, Year);
                            EndDate := DMY2DATE(31, 12, Year);
 
                        end;
                        Income.SetRange("IncomeDate", StartDate, EndDate);
                        PAGE.Run(PAGE::Income_Tracker_Page, Income);
 
                    end;
                }
                field("IncomeCurrent Quarter"; IncomeCurrentQuarter)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Current Quarter';
                    trigger OnDrillDown()
                    var
                        Income: Record Income_Tracker;
                    begin
                        Income.SetRange(Income_Category, Rec.IncomeCategory_Name);
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
 
 
                            Income.SetRange("IncomeDate", StartDate, EndDate); // If you want "till WorkDate"
 
                        end;
                        PAGE.Run(PAGE::Income_Tracker_Page, Income);
                    end;
                }
            }
        }
    }
 
    trigger OnAfterGetRecord()
    var
        Income: Record Income_Tracker;
    begin
        Month := DATE2DMY(WorkDate(), 2);
        Year := DATE2DMY(WorkDate(), 3);
 
        // -------------------
        // Current Year
        // -------------------
        Income.Reset();
        Income.SetRange(Income_Category, Rec.IncomeCategory_Name);
        StartDate := DMY2DATE(1, 1, Year);
        EndDate := DMY2DATE(31, 12, Year);
        Income.SetRange("IncomeDate", StartDate, EndDate);
        Income.CalcSums(IncomeAmount);
        IncomeCurrentYear := Income.IncomeAmount;
 
        // -------------------
        // Current Month
        // -------------------
        Income.Reset();
        Income.SetRange(Income_Category, Rec.IncomeCategory_Name);
        StartDate := DMY2DATE(1, Month, Year);   // First day of current month
        EndDate := WorkDate();                   // Till today
        Income.SetRange("IncomeDate", StartDate, EndDate);
        Income.CalcSums(IncomeAmount);
        IncomeCurrentMonth := Income.IncomeAmount;
 
        // -------------------
        // Current Half-Year
        // -------------------
        Income.Reset();
        Income.SetRange(Income_Category, Rec.IncomeCategory_Name);
 
        if Month <= 6 then begin
            StartDate := DMY2DATE(1, 1, Year);   // Jan 1
            EndDate := DMY2DATE(30, 6, Year);    // Jun 30
        end else begin
            StartDate := DMY2DATE(1, 7, Year);   // Jul 1
            EndDate := DMY2DATE(31, 12, Year);   // Dec 31
        end;
 
        Income.SetRange("IncomeDate", StartDate, EndDate);
        Income.CalcSums(IncomeAmount);
        IncomeCurrentHalfYear := Income.IncomeAmount;
 
        // -------------------
        // Current Quarter
        // -------------------
        Income.Reset();
        Income.SetRange(Income_Category, Rec.IncomeCategory_Name);
 
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
 
        Income.SetRange("IncomeDate", StartDate, EndDate);
        Income.CalcSums(IncomeAmount);
        IncomeCurrentQuarter := Income.IncomeAmount;
    end;
 
 
 
 
    var
        IncomeCurrentYear: Decimal;
        IncomeCurrentMonth: Decimal;
        IncomeCurrentHalfYear: Decimal;
        IncomeCurrentQuarter: Decimal;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Year: Integer;
}
 
 