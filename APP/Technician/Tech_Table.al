table 50111 TechnicianTable
{
    DataClassification = ToBeClassified;
    Caption = 'Technician';
    fields
    {
        field(1; "Tech_ID"; Code[10])
        {
            Caption = 'Tech_ID';
            DataClassification = ToBeClassified;

        }
        field(2; "Tech_Name"; text[50])
        {
            Caption = 'Tech_Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Phone.No"; integer)
        {
            Caption = 'Phone_No';
            DataClassification = ToBeClassified;

        }
        field(50113; "Department"; Enum Department)
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;

        }
        field(4; "No Of Problems"; Integer)
        {
            Caption = 'No Of Problems';
            FieldClass = FlowField;
            CalcFormula = count(ProblemTable where(Technician_Name = field(Tech_Name)));
        }
    }


    keys
    {

        key(PK; "Tech_ID", Tech_Name)
        {
            Clustered = true;
        }
    }

}