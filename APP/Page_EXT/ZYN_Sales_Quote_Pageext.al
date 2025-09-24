pageextension 50108 ZYN_SalesQuotePageExt extends "Sales Quote"
{
    layout
    {
        addlast(content)
        {
            field("Beginning Quote Text"; Rec."Beginning Text")
            {
                ApplicationArea = all;
                Caption = 'Beginning text';
                TableRelation = "Standard Text".Code;
            }
            part("Beginning Quote"; "ZYN_Beginning Text Codes")
            {
                SubPageLink = "Sell to Customer No." = FIELD("Sell-to Customer No."), Selection = Const(BeginningText);
                ApplicationArea = all;
            }
            field("Ending Quote Text"; Rec."Ending Text")
            {
                ApplicationArea = all;
                Caption = 'Ending text';
                TableRelation = "Standard Text".Code;
            }
            part("Ending Qoute"; "ZYN_Ending Text Codes")
            {
                SubPageLink = "Sell to Customer No." = FIELD("Sell-to Customer No."), Selection = Const(EndingText);
                ApplicationArea = all;
            }
        }
    }
}