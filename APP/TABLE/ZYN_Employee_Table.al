table 50126 ZYN_Employee_Table
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Employee';
    fields
    {
        field(1; Employee_ID; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            AutoIncrement = true;
            Caption = 'Employee ID';
            ToolTip = 'Enter Employee ID';
        }
        field(2; Employee_Name; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee Name';
            ToolTip = 'Enter Employee Name';
        }
        field(3; Role; Enum ZYN_Role_Enum)
        {
            DataClassification = ToBeClassified;
            Caption = 'Role';
            ToolTip = 'Enter Role';
        }
        field(4; Department; Enum ZYN_Department_Enum)
        {
            DataClassification = ToBeClassified;
            Caption = 'Department';
            ToolTip = 'Enter Department';
        }
    }
    keys
    {
        key(PK; Employee_ID)
        {
            Clustered = true;
        }
    }
}