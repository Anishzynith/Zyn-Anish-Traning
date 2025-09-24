namespace System.Environment;

table 50137 ZynithCompany
{
    Caption = 'Company';
    DataPerCompany = true;
    ReplicateData = true;
    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(2; "Evaluation Company"; Boolean)
        {
            Caption = 'Evaluation Company';
        }
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
        field(8005; "Business Profile Id"; Text[250])
        {
            Caption = 'Business Profile Id';
        }
    }
    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }
}

