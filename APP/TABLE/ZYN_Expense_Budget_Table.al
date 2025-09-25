table 50123 ZYN_ExpenseBudget_Table
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Expense Budget';
    fields
    {
        field(1; From_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'From Date';
            ToolTip = 'Select From Date';
        }
        field(2; To_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'To Date';
            ToolTip = 'Select To Date';
        }
        field(3; Expense_Category; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Expense_Category_Table.ExpenseCategory_Name;
            Caption = 'Expense Category';
            ToolTip = 'Select Category';
        }
        field(4; Budget_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget Amount';
            ToolTip = 'Enter Budget Amount';
        }
    }
    keys
    {
        key(Key1; From_Date, To_Date, Expense_Category)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if From_Date = 0D then
            From_Date := CalcDate('<-CM>', WorkDate()); // first day of current month

        if To_Date = 0D then
            To_Date := CalcDate('<CM>', WorkDate());    // last day of current month
    end;
}