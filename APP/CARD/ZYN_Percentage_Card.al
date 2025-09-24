page 50112 "ZYN_Index Card"
{
    PageType = Card;
    SourceTable = ZYN_Percentage_Table;
    ApplicationArea = All;
    Caption = 'Percentage Card';
    layout
    {
        area(Content)
        {
            group(General)
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
                    trigger OnValidate()
                    begin
                        GenerateLines();
                    end;
                }
                field(StartYear; Rec.StartYear)
                {
                    ApplicationArea = All;
                    Caption = 'Start Year';
                    trigger OnValidate()
                    begin
                        GenerateLines();
                    end;
                }
                field(EndYear; Rec.EndYear)
                {
                    ApplicationArea = All;
                    Caption = 'End Year';
                    trigger OnValidate()
                    begin
                        GenerateLines();
                    end;
                }
            }
            part(SubPage; ZYN_SubPage)
            {
                ApplicationArea = All;
                Caption = 'Sub Page List Part';
                SubPageLink = Code = field(Code);
            }
        }
    }

    local procedure GenerateLines()
    var
        RecListPart: Record ZYN_SubPageTable;
        Year: Integer;
        CurrentValue: Decimal;
        NextEntryNo: Integer;
    begin
        // Avoid running with incomplete data
        if (Rec.StartYear = 0) or (Rec.EndYear = 0) or (Rec."Percentage Increase" = 0) then
            exit;
        // Delete old lines for this Code
        RecListPart.Reset();
        RecListPart.SetRange(Code, Rec.Code);
        RecListPart.DeleteAll();
        // Start value
        CurrentValue := 100;
        NextEntryNo := 0; // Start numbering from 1
        for Year := Rec.StartYear to Rec.EndYear do begin
            NextEntryNo += 1;
            RecListPart.Init();
            RecListPart.EntryNO := NextEntryNo;
            RecListPart.Code := Rec.Code;
            RecListPart.Year := Year;
            RecListPart.Value := CurrentValue;
            RecListPart.Insert();
            // Increase for next year
            CurrentValue := CurrentValue + (CurrentValue * Rec."Percentage Increase" / 100);
        end;
    end;
}
