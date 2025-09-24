pageextension 50100 "ZYN_posted Invoice Page Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addlast(content)
        {
            field("Begin Text Code"; Rec."Beginning Text")
            {
                ApplicationArea = All;
                Caption = 'Beginning Text';
                TableRelation = "Standard Text".Code;
                Editable = false;
            }
            part("Beginning"; "ZYN_Beginning Text Codes")
            {
                SubPageLink = "No." = FIELD("No."), Selection = Const(BeginningText), "Document Type" = const("Posted Invoice");
                ApplicationArea = all;
            }
            field("End Text Code"; Rec."Ending Text")
            {
                ApplicationArea = all;
                TableRelation = "Standard Text".Code;
                Editable = false;
            }
            part("Posted Ending Text Subpage"; "ZYN_Ending Text Codes")
            {
                SubPageLink = "No." = FIELD("No."), Selection = const(EndingText), "Document Type" = const("Posted Invoice");
                ApplicationArea = all;
            }
            field("Beginning Text Code"; Rec."Beginning Text Code")
            {
                ApplicationArea = all;
            }
            field("Ending Text Code"; Rec."Ending Text Code")
            {
                ApplicationArea = all;
            }
        }
    }
}



