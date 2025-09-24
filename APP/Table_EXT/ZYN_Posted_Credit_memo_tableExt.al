tableextension 50103 ZYN_postedcreditmemopageext extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50101; "Beginning Posted Memo"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Beginning Text';
        }
        field(50100; "Ending Posted Memo"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ending Text';
        }
    }
}