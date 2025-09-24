table 50112 ProblemTable
{
    DataClassification = ToBeClassified;
    Caption = 'Problem';
    fields
    {
        field(1; EntryNO; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'EntryNo';
            AutoIncrement = true;
        }
        field(2; CustomerID; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'CustomerID';
        }
        field(3; CustomerName; Text[50])
        {
            Caption = 'Customer Name';
        }
        field(50115; "Issue"; Enum ZYN_Issue)
        {
            Caption = 'Issue';
            DataClassification = ToBeClassified;
        }
        field(50113; "Issuse_Department"; Enum ZYN_Department)
        {
            Caption = 'Department';
            // Editable = true;
            DataClassification = ToBeClassified;
        }
        field(4; "Technician_Name"; Text[50])
        {
            Caption = 'Technician Name';
            TableRelation = ZYN_TechnicianTable.Tech_Name where(Department = field(Issuse_Department));
            DataClassification = ToBeClassified;
            // Editable = true;
        }
        field(5; "Description"; text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            // Editable = True;
        }
        field(6; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; EntryNO, CustomerID)
        {
            Clustered = true;
        }
    }
}
