
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
 
 