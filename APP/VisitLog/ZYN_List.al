page 50127 "VisitorSource"
{
    PageType = List;
    SourceTable = "VisitorTable";
    CardPageId = "VisitorPageCard";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // field("EntryNo"; Rec."EntryNo")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Entry No';
                //}
                field("CustomerNo"; Rec."CustomerNo")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No';
                }
                field("Date"; Rec."Date")
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
