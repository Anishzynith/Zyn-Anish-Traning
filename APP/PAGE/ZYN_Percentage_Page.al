page 50110 ZYN_Index_List
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Percentage_Table;
    Caption = 'Percentage Overview';
    CardPageId = "ZYN_Index Card";
    layout
    {
        area(Content)
        {
            repeater(Percentage_List)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Percentage Increase"; Rec."Percentage Increase")
                {
                    ApplicationArea = All;
                    Caption = 'Percentage Increase';
                }
            }
        }
    }
}