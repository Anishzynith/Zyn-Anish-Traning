namespace System.Environment;

table 50137 ZynithCompany
{
    Caption = 'Company';
    DataPerCompany = false;
    ReplicateData = true;
    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            ToolTip = 'Enter Company Name';

            trigger OnValidate()
            begin

                if '' <> xRec.Name then
                    Error(NameError, xRec.Name);
            end;
        }
        field(2; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
            ToolTip = 'Enter Display Name';
        }
        field(3; IS_Master; Boolean)
        {
            Caption = 'Is Master';
            ToolTip = 'Select as Master Company';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ZynithComp: Record ZynithCompany;
            begin
                if IS_Master then begin
                    ZynithComp.Reset();
                    ZynithComp.SetRange(IS_Master, true);
                    if ZynithComp.FindFirst() then
                        if ZynithComp.Name <> Rec.Name then
                            Error('Only one company can be set as Master. Master company is already %1.', ZynithComp.Name);
                end;
            end;
        }
        field(4; Master_Company_Name; Text[250])
        {
            Caption = 'Master Company';
            ToolTip = 'Enter Master Company';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                MasterComp: Record ZynithCompany;
            begin
                if Master_Company_Name = '' then
                    exit;

                // check if this company exists and is marked as master
                if not MasterComp.Get(Master_Company_Name) then
                    Error('The company "%1" does not exist in ZynithCompany.', Master_Company_Name);

                if not MasterComp.IS_Master then
                    Error('The company "%1" is not marked as a Master Company.', Master_Company_Name);
            end;
        }
    }
    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }
    var
        NameError: Label 'You cannot change the Name of a company once it is created.';
}

