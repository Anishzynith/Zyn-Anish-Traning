
report 50103 "Expense_Tracker_Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Expense_Tracker; Expense_Tracker)
        {
            DataItemTableView = sorting(Expense_ID);

            trigger OnAfterGetRecord()
            begin
                if (Expense_Tracker.ExpenseDate >= StartDate) and (Expense_Tracker.ExpenseDate <= EndDate) then begin
                    if (CategoryFilter = '') or (Expense_Tracker.Expense_Category = CategoryFilter) then begin
                        // Add each line into ExcelBuffer
                        ExcelBuffer.AddColumn(Expense_Tracker.Expense_Category, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(Expense_Tracker.ExpenseDate, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(Expense_Tracker.ExpenseAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.NewRow();

                        // Track total for selected category
                        TotalAmount += Expense_Tracker.ExpenseAmount;
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
                        TableRelation = Expense_Category_Table.ExpenseCategory_Name;
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
        ExcelBuffer.AddColumn('Expense Category', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
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

        FileName := 'Expense_Report_' +
                    (CategoryFilter <> '' ? CategoryFilter : 'All') + '_' +
                    Format(Today, 0, '<Year4><Month,2><Day,2>') + '.xlsx';

        ExcelBuffer.CreateNewBook('Expense Tracker Report');
        ExcelBuffer.WriteSheet('Expenses', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(FileName);
        ExcelBuffer.OpenExcel();
    end;
}
