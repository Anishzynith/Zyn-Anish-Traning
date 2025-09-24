page 50166 ZYN_Asset_History_FactBox
{

    PageType = CardPart;
    SourceTable = ZYN_Employee_Table;
    ApplicationArea = All;
    Caption = 'Asset Summary';
    layout
    {
        area(Content)
        {
            group(AssetSummary)
            {
                field("Assigned Assets"; GetAssignedCount())
                {
                    ApplicationArea = All;
                }
                field("Returned Assets"; GetReturnedCount())
                {
                    ApplicationArea = All;
                }
                field("Lost Assets"; GetLostCount())
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    local procedure GetAssignedCount(): Integer
    var
        AssetRec: Record ZYN_Employee_Table;
        AssetRecCom: Record ZYN_Company_Asset_Table;
    begin
        AssetRec.SetRange(Employee_ID, Rec.Employee_ID);
        AssetRecCom.SetFilter(Is_Lost, '=false');
        AssetRec.SetFilter(Returned_Date, '=0D'); // Not returned
        exit(AssetRec.Count);
    end;

    local procedure GetReturnedCount(): Integer
    var
        AssetRec: Record ZYN_Employee_Table;
        AssetRecCom: Record ZYN_Company_Asset_Table;
    begin
        AssetRec.SetRange(Employee_ID, Rec.Employee_ID);
        AssetRec.SetFilter(Returned_Date, '<>0D');
        exit(AssetRec.Count);
    end;

    local procedure GetLostCount(): Integer
    var
        AssetRec: Record ZYN_Employee_Table;
        AssetRecCom: Record ZYN_Company_Asset_Table;
    begin
        AssetRec.SetRange(Employee_ID, Rec.Employee_ID);
        AssetRecCom.SetFilter(Is_Lost, '=true');
        exit(AssetRec.Count);
    end;
}