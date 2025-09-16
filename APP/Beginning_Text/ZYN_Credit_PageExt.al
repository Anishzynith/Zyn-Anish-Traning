pageextension 50101 CreditMemoExtension extends "Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addlast(content)
        {
            field("Beginning Text Credit"; Rec."Beginning Text")
            {
                Caption = 'Beginning Text';
                ApplicationArea = all;
                TableRelation = "standard text";
            }
            part("Beginning Text Credit Memo"; "Beginning Text Codes")
            {
                ApplicationArea = all;
                SubPageLink = "Sell to Customer No." = field("Sell-to Customer No."), Selection = const(BeginningText);
            }
            field("Ending Text Credit"; Rec."Ending Text")
            {
                Caption = 'Ending Text';
                ApplicationArea = all;
                TableRelation = "standard text";
            }
            part("Ending Text Credit Memo"; "Ending Text Codes")
            {
                ApplicationArea = all;
                SubPageLink = "Sell to Customer No." = field("Sell-to Customer No."), Selection = const(EndingText);
            }
        }
    }
}