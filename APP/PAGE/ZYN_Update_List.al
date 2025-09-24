page 50137 "ZYN_Buffer Table List"  //temporary buffer in FieldName and RecordSelection
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ZYN_Buffer Field";
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = All;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                }
                field("Field Value"; Rec."Field Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}