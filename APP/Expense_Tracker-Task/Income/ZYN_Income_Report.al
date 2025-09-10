
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
