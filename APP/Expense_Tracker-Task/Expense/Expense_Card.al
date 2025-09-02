page 50121 Expense_Tracker_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Expense_Tracker;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Expense_ID; Rec.Expense_ID)
                {
                    ApplicationArea = All;
                    Caption = 'Expense ID';
                }
                field(ExpenseDescription; Rec.ExpenseDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field(ExpenseAmount; Rec.ExpenseAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                    Enabled = IsCategorySelected; // controlled by variable

                    // trigger OnValidate()
                    // begin
                    //     RemainingBudget := GetRemainingBudget(Rec.Expense_Category) - Rec.ExpenseAmount;
                    //     if RemainingBudget < 0 then
                    //         Error(
                    //             'You cannot exceed the budget. Remaining budget is %1.',
                    //             Format(RemainingBudget + Rec.ExpenseAmount)
                    //         );
                    //     CurrPage.Update();
                    // end;
                }
                field(Expense_Category; Rec.Expense_Category)
                {
                    ApplicationArea = All;
                    Caption = 'Expense Category';
                    TableRelation = "Expense_Category_Table".ExpenseCategory_Name;

                    trigger OnValidate()
                    begin
                        IsCategorySelected := Rec.Expense_Category <> '';
                        // RemainingBudget := GetRemainingBudget(Rec.Expense_Category);
                        //  Rec.ExpenseAmount := 0; // reset amount if category changes
                        CurrPage.Update();
                    end;
                }
                field(ExpenseDate; Rec.ExpenseDate)
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field(RemainingBudget; RemainingBudget)
                {
                    ApplicationArea = All;
                    Caption = 'Remaining Budget';
                    Editable = false; // User should not edit

                    // trigger OnValidate()
                    // begin
                    //     Rec.RemainingBudget := Rec.GetRemainingBudget(Rec."Expense_Category", Rec.ExpenseDate);
                    // end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IsCategorySelected := Rec.Expense_Category <> '';
        RemainingBudget := RemainingBudgetMgt.GetRemainingBudget(Rec.Expense_Category);
    end;

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    var

        IsCategorySelected: Boolean;
        RemainingBudgetMgt: Codeunit "Remaining Budget";
        RemainingBudget: Decimal;

        Expense: Record Expense_Tracker;




    // local procedure GetRemainingBudget(Category: Code[100]): Decimal
    // var
    //     ExpenseBudget: Record ExpenseBudget_Table;
    //     ExpenseTracker: Record Expense_Tracker; // your expense table
    //     StartD: Date;
    //     EndD: Date;
    //     BudgetAmt: Decimal;
    //     ActualAmt: Decimal;
    // begin
    //     // Example: Remaining budget for Current Year
    //     GetCYRange(StartD, EndD);

    //     // Budget
    //     ExpenseBudget.Reset();
    //     ExpenseBudget.SetRange(Expense_Category, Category);
    //     ExpenseBudget.SetRange(From_Date, StartD);
    //     ExpenseBudget.SetRange(To_Date, EndD);
    //     if ExpenseBudget.FindFirst() then
    //         BudgetAmt := ExpenseBudget.Budget_Amount;

    //     // Actual Expense
    //     ExpenseTracker.Reset();
    //     ExpenseTracker.SetRange(Expense_Category, Category);
    //     ExpenseTracker.SetRange(ExpenseDate, StartD, EndD);
    //     if ExpenseTracker.FindSet() then
    //         repeat
    //             ActualAmt += ExpenseTracker.ExpenseAmount;
    //         until ExpenseTracker.Next() = 0;

    //     exit(BudgetAmt - ActualAmt);
    // end;

    local procedure GetCYRange(var StartD: Date; var EndD: Date)
    begin
        StartD := DMY2Date(1, 1, Date2DMY(Today, 3));
        EndD := DMY2Date(31, 12, Date2DMY(Today, 3));
    end;

    local procedure GetMonthRange(var StartD: Date; var EndD: Date)
    begin
        StartD := DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3)); // 1st day of current month
        EndD := CALCDATE('<CM>', StartD); // last day of current month
    end;


}