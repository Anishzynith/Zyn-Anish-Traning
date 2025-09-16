pageextension 50104 SalesOrderPageExt extends "Sales Order"
{
    layout
    {
        addlast(content)
        {
            field("Beginning Order Text"; Rec."Beginning Text")
            {
                ApplicationArea = all;
                Caption = 'Beginning text';
                TableRelation = "Standard Text".Code;
            }
            part("Beginning Order"; "Beginning Text Codes")
            {
                SubPageLink = "Sell to Customer No." = FIELD("Sell-to Customer No."), Selection = Const(BeginningText);
                ApplicationArea = all;
            }
            field("Ending Order Text"; Rec."Ending Text")
            {
                ApplicationArea = all;
                Caption = 'Ending text';
                TableRelation = "Standard Text".Code;
            }
            part("Ending Order"; "Ending Text Codes")
            {
                SubPageLink = "Sell to Customer No." = FIELD("Sell-to Customer No."), Selection = Const(EndingText);
                ApplicationArea = all;
            }
            field("Invoice Posted Begin OrderText"; Rec."Invoice Posted Begin OrderText")
            {
                ApplicationArea = all;
                Caption = 'Invoice Posted Begin OrderText';
                TableRelation = "Standard Text".Code;
            }
            field("Invoice Posted End OrderText"; Rec."Invoice Posted End OrderText")
            {
                ApplicationArea = all;
                Caption = 'Invoice Posted End OrderText';
                TableRelation = "Standard Text".Code;
            }
        }
    }
}