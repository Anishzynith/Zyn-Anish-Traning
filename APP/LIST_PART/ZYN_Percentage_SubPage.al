page 50115 ZYN_SubPage
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_SubPageTable;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(EntryNO; Rec.EntryNO)
                {
                    Caption = 'Entry No.';
                }
                field(Code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(Year; Rec.Year)
                {
                    Caption = 'Year';
                }
                field(Value; Rec.Value)
                {
                    Caption = 'Value';
                }
            }
        }
    }
}