/*
report 50103 "Income_Tracker_Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;   // since we are exporting to Excel only

    dataset
    {
        dataitem(Income_Tracker; Income_Tracker)
        {
            DataItemTableView = sorting(Income_ID);
            RequestFilterFields = Date;

            trigger OnAfterGetRecord()
            begin
                if (Income_Tracker.Date >= StartDate) and (Income_Tracker.Date <= EndDate) then begin
                    // Add each line into ExcelBuffer
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn(Income_Tracker."Income_ID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Income_Tracker.Description, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(Income_Tracker.Amount, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(Income_Tracker.Date, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn(Income_Tracker.Income_Category, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    TotalAmount += Income_Tracker.Amount;
                    //   ExcelBuffer.AddColumn(Income_Tracker."Income_Category", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                    //    ExcelBuffer.AddColumn(Format(Income_Tracker.Amount), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.NewRow();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter_Group)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Enter the start date for the report.';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Enter the end date for the report.';
                    }
                    field(Category_Filter; Category_Filter)
                    {
                        ApplicationArea = All;
                        Caption = 'Income Category';
                        ToolTip = 'Filter by Income Category.';
                        TableRelation = "Income_Category_Table".Category_Name;
                    }
                }
            }
        }
    }



    var
        StartDate: Date;
        EndDate: Date;
        Category_Filter: Code[50];
        TotalAmount: Decimal;
        ExcelBuffer: Record "Excel Buffer" temporary;

    trigger OnPreReport()
    begin



        ExcelBuffer.DeleteAll();

        // Header row
        // ExcelBuffer.AddColumn('Income Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Income ID', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Date', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Category', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

    end;

    trigger OnPostReport()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('TOTAL', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalAmount, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.CreateNewBook('Income Tracker Report');
        ExcelBuffer.WriteSheet('Incomes', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Income_Tracker_Report.xlsx');
        ExcelBuffer.OpenExcel();

    end;


}


report 50104 Income_Tracker_Report
{
    ApplicationArea = All;
    Caption = 'Income Report';
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Income report.xlsx';
    DefaultLayout = Excel;
    ProcessingOnly = true;

    dataset
    {
        dataitem(IncomeTable; Income_Tracker)
        {
            RequestFilterFields = Date;

            column("IncomeId"; Income_ID) { }
            column(Description; Description) { }
            column(Category; Income_Category) { }
            column(Amount; Amount) { }
            column(Date; "Date") { }

            trigger OnPreDataItem()
            begin
                if FromDate <> 0D then SetRange(Date, FromDate, EndDate);
                if Categoryfilter <> '' then SetRange(Income_Category, Categoryfilter);
            end;

            trigger OnAfterGetRecord()
            begin
                if (Categoryfilter = '') or (Income_Category = Categoryfilter) then
                    TotalIncome += Amount;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Expected Incomes")
                {
                    field("From Date"; FromDate) { }
                    field("End Date"; EndDate) { }
                    field("Category"; Categoryfilter) { }
                    field("Total Incomes"; TotalIncome)
                    {
                        Editable = false;
                    }
                }
            }
        }
    }

    procedure SetCategoryFilter(Value: Text)
    begin
        Categoryfilter := Value;
    end;

    procedure SetDateFilter(FromD: Date; EndD: Date)
    begin
        FromDate := FromD;
        EndDate := EndD;
    end;

    var
        FromDate: Date;
        EndDate: Date;
        Categoryfilter: Text;
        TotalIncome: Decimal;
}
*/
report 50105 "Income_Tracker_Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Income_Tracker; Income_Tracker)
        {
            DataItemTableView = sorting(Income_ID);

            trigger OnAfterGetRecord()
            begin
                if (Income_Tracker.IncomeDate >= StartDate) and (Income_Tracker.IncomeDate <= EndDate) then begin
                    if (CategoryFilter = '') or (Income_Tracker.Income_Category = CategoryFilter) then begin
                        // Add each line into ExcelBuffer
                        ExcelBuffer.AddColumn(Income_Tracker.Income_Category, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(Income_Tracker.IncomeDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(Income_Tracker.IncomeAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.NewRow();

                        // Track total for selected category
                        TotalAmount += Income_Tracker.IncomeAmount;
                        RecordsFound := true;
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter_Group)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field(CategoryFilter; CategoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Category';
                        TableRelation = Income_Category_Table.IncomeCategory_Name;
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        ExcelBuffer: Record "Excel Buffer" temporary;
        CategoryFilter: Code[50];
        TotalAmount: Decimal;
        RecordsFound: Boolean;

    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        TotalAmount := 0;
        RecordsFound := false;

        // Header row
        ExcelBuffer.AddColumn('Income Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow();
    end;

    trigger OnPostReport()
    var
        FileName: Text;
    begin
        if not RecordsFound then begin
            ExcelBuffer.AddColumn('No data found for the selected filters.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.NewRow();
        end else begin
            ExcelBuffer.NewRow();
            ExcelBuffer.AddColumn('TOTAL', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            ExcelBuffer.AddColumn(TotalAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            ExcelBuffer.NewRow();
        end;

        FileName := 'Income_Report_' +
                    (CategoryFilter <> '' ? CategoryFilter : 'All') + '_' +
                    Format(Today, 0, '<Year4><Month,2><Day,2>') + '.xlsx';

        ExcelBuffer.CreateNewBook('Income Tracker Report');
        ExcelBuffer.WriteSheet('Incomes', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(FileName);
        ExcelBuffer.OpenExcel();
    end;
}
