tableextension 50104 SalesOrderTableExt extends "Sales Header"
{
    fields
    {
        field(50101; "Beginning Order Text"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Beginning Text';
        }
        field(50100; "Ending Order Text"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ending Text';
        }
        field(50103; "Invoice Posted Begin OrderText"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Posted Beginning Order Text';
        }
        field(50102; "Invoice Posted End OrderText"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice Posted End OrderText';
        }
    }
    trigger OnDelete()
    var
        CodeTable: Record "Sales Invoice Text Code";
    begin
        CodeTable.SetRange("No.", SalesHeader."No.");
        CodeTable.SetRange(Selection, beginend_enum::BeginningText);//("Document Type", "Sales Document Type"::Order);
        CodeTable.DeleteAll();
        CodeTable.SetRange("No.", SalesHeader."No.");
        CodeTable.SetRange(Selection, beginend_enum::EndingText);//("Document Type", "Sales Document Type"::Order);
        CodeTable.DeleteAll();
    end;
}