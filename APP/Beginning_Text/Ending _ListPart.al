page 50100 "Ending Text Codes"
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
                // field("Beginning Text"; Rec.Text)
                // {
                //     ApplicationArea = all;

                // }
                // field("Ending Text"; Rec."Text")
                // {
                //     ApplicationArea = all;
                // }

                field("Ending Text"; Rec.Text)
                {
                    ApplicationArea = all;
                }
                field(lineNO; Rec.lineNO)
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}