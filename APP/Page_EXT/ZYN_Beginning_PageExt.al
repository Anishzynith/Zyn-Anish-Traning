pageextension 50116 "ZYN_Sales Invoice Header Ext" extends "Sales Invoice"
{
    layout
    {
        addlast(content)
        {
            group("Begin Text Code")
            {
                Caption = 'Begin Text Code';
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";
                }
                part(BeginningLine; "ZYN_Beginning Text Codes")
                {
                    ApplicationArea = All;
                    // SubPageLink = "No." = field("No.");
                    SubPageLink = "Sell to Customer No." = field("Sell-to Customer No."), Selection = const(ZYN_BeginEnd_Enum::BeginningText);
                }
                group("End Text Code")
                {
                    Caption = 'End Text Code';
                    field("Ending Text"; Rec."Ending Text")
                    {
                        Caption = 'Ending Text';
                        ApplicationArea = all;
                        TableRelation = "Standard Text";
                    }
                }
                part(EndingLine; "ZYN_Beginning Text Codes")
                {
                    ApplicationArea = all;
                    SubPageLink = "Sell to Customer No." = field("Sell-to Customer No."), Selection = const(ZYN_BeginEnd_Enum::EndingText);
                }
            }
        }
    }
}