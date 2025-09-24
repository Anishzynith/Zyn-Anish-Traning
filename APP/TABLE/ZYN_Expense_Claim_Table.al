table 50135 ZYN_Expense_Claim_Table
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Exp_Id; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            AutoIncrement = true;
        }
        field(2; Employee_ID; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Employee_Table.Employee_ID;
        }
        field(3; Claiming_Category; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Claim_Category_Table.Claiming_Category;
        }
        field(4; Claim_Date; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(5; Claim_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Claim_Status; Enum ZYN_Claim_status)
        {
            DataClassification = ToBeClassified;
            InitValue = 'Pending_Approval';
        }
        field(7; Bill_Reference; Blob)
        {
            DataClassification = ToBeClassified;

        }
        field(8; Bill_Date; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(9; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(10; SubType; Text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Claim_Category_Table.SubType WHERE(SubType = FIELD(SubType));
        }
        field(11; Bill_FileName; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(12; Available_Amount; Decimal)
        {
            Caption = 'Available Amount';
            //Editable = false;
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