page 50126 ZYN_VisitorPageCard
{
    PageType = Card;
    SourceTable = "ZYN_VisitorTable";
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group(General)
            {
                // field("EntryNo"; Rec."EntryNo")
                // {
                //     ApplicationArea = All;
                // }
                field("CustomerNo"; Rec."CustomerNo")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Purpose"; Rec."Purpose")
                {
                    ApplicationArea = All;
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
