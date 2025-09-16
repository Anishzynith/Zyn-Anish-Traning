page 50137 "Buffer Table List"  //temporary buffer in FieldName and RecordSelection
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Buffer Field";
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