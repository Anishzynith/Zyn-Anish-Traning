page 50100 "ZYN_Ending Text Codes"
{
    PageType = ListPart;
    SourceTable = "ZYN_Sales Invoice Text Code";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
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