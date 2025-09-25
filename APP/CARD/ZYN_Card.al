page 50126 ZYN_VisitorPageCard
{
    PageType = Card;
    SourceTable = "ZYN_VisitorTable";
    ApplicationArea = All;
    Caption = 'Visitor Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("CustomerNo"; Rec."CustomerNo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Customer No';
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Date';
                }
                field("Purpose"; Rec."Purpose")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Purpose';
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Notes';
                }
            }
        }
    }
}
