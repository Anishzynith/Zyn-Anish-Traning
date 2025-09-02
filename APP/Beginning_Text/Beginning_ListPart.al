page 50111 "Beginning Text Codes"
{
    PageType = ListPart;
    SourceTable = "Sales Invoice Text Code";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                // field("No."; Rec."No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Sell to Customer No."; Rec."Sell to Customer No.")
                // {
                //     ApplicationArea = all;

                // }
                // field("Document Type"; Rec."Document Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Sell to Customer Name"; Rec."Sell to Customer Name")
                // {
                //     ApplicationArea = all;
                // }
                // field("Lang Text Code"; Rec."Language Code")
                // {
                //     ApplicationArea = All;
                //     //  TableRelation =
                // }
                field("Beginning Text"; Rec.Text)
                {
                    ApplicationArea = all;
                }
                field(lineNO; Rec.lineNO)
                {
                    ApplicationArea = all;
                }


                // field("Text"; Rec.Text)
                // {
                //     ApplicationArea = all;
                // }
            }
        }
    }
}
