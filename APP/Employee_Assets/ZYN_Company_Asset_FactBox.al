page 50163 Company_Asset_DetailPage
{
    PageType = List;
    SourceTable = Employee_Table;
    ApplicationArea = All;
    Caption = 'Available Asset Details';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Employee_Name; Rec.Employee_Name)
                {
                    ApplicationArea = All;
                }

                field(Asset_Type; GetAssetType())
                {
                    ApplicationArea = All;
                }

                field(Serial_NO; GetSerialNo())
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    local procedure GetAssetType(): Text
    var
        AssetRec: Record Company_Asset_Table;
        ExpiryDate: Date;
    begin
        if Rec.Asset_ID <> '' then
            if AssetRec.Get(Rec.Asset_ID) then begin
                ExpiryDate := AssetRec.Procured_Date + (5 * 365);
                if (not AssetRec.Is_Lost) and (Rec.Returned_Date <> 0D) and (Rec.Returned_Date <= ExpiryDate) then
                    exit(AssetRec.Asset_Type);
            end;
        exit(''); // fallback
    end;


    local procedure GetSerialNo(): Code[20]
    var
        AssetRec: Record Company_Asset_Table;
        ExpiryDate: Date;
    begin
        if Rec.Asset_ID <> '' then
            if AssetRec.Get(Rec.Asset_ID) then begin
                ExpiryDate := AssetRec.Procured_Date + (5 * 365);
                if (not AssetRec.Is_Lost) and (Rec.Returned_Date <> 0D) and (Rec.Returned_Date <= ExpiryDate) then
                    exit(AssetRec.Serial_NO);
            end;
        exit('');
    end;

    trigger OnOpenPage()
    begin
        // Filter only valid returned assets
        Rec.SetFilter(Returned_Date, '<>%1', 0D);
    end;
}
