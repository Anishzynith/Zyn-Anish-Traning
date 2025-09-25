table 50135 ZYN_Expense_Claim_Table
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Expense Claim';
    fields
    {
        field(1; Exp_Id; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            AutoIncrement = true;
            Caption = 'Exp ID';
            ToolTip = 'Enter Exp ID';
        }
        field(2; Employee_ID; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Employee_Table.Employee_ID;
            Caption = 'Employee ID';
            ToolTip = 'Enter Employee ID';
        }
        field(3; Claiming_Category; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Claim_Category_Table.Claiming_Category;
            Caption = 'Claiming Category';
            ToolTip = 'Enter Claiming Categroy';
        }
        field(4; Claim_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Claim Date';
            ToolTip = 'Select Claim Date';
        }
        field(5; Claim_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Claim Amount';
            ToolTip = 'Enter Claim Amount';
        }
        field(6; Claim_Status; Enum ZYN_Claim_status)
        {
            DataClassification = ToBeClassified;
            InitValue = 'Pending_Approval';
            Caption = 'Claim Status';
            ToolTip = 'Select Claim Status';
        }
        field(7; Bill_Reference; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill Reference';
            ToolTip = 'Enter Bill Reference';
        }
        field(8; Bill_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill Date';
            ToolTip = 'Select Bill Date';
        }
        field(9; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks';
            ToolTip = 'Enter Remarks';
        }
        field(10; SubType; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub Type';
            ToolTip = 'Enter Sub Type';
        }
        field(11; Bill_FileName; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill File Name';
            ToolTip = 'Enter Bill File Name';
        }
        field(12; Available_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Available Amount';
            ToolTip = 'Enter Available Amount';
        }
    }
    keys
    {
        key(Key1; Exp_Id, Employee_ID, Claiming_Category, Bill_Date, SubType)
        {
            Clustered = true;
        }
    }
}