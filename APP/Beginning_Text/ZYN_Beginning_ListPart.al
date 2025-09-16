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
                field("Beginning Text"; Rec.Text)
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
