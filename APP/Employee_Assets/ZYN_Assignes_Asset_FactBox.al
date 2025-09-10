
page 50162 Company_Asset_FactBox
{
    PageType = CardPart;
    SourceTable = Company_Asset_Table;
    ApplicationArea = All;
    Caption = 'Asset Summary';

    layout
    {
        area(Content)
        {
            cuegroup("Available Assets")
            {
                field(AvailableAssetCount; GetAvailableAssetCount())
                {
                    ApplicationArea = All;
                    Caption = 'Available Assets';
                    trigger OnDrillDown()
                    var
                        DetailPage: Page Company_Asset_DetailPage;
                    begin
                        DetailPage.Run();
                    end;
                }
            }
        }
    }

   


    local procedure GetAvailableAssetCount(): Integer
    var
        AssetRec: Record Company_Asset_Table;
        EmpAssetRec: Record Employee_Table;
        AvailableCount: Integer;
        ExpiryDate: Date;
    begin
        AvailableCount := 0;

        AssetRec.Reset();
        if AssetRec.FindSet() then
            repeat
                // Calculate expiry date
                ExpiryDate := AssetRec.Procured_Date + (5 * 365);


                // Check if asset is marked as lost
                if AssetRec.Is_Lost then
                    continue;

                // Check if asset is assigned to employee
                EmpAssetRec.SetRange(Asset_ID, AssetRec.ID); // Assuming Asset_ID links both tables
                if EmpAssetRec.FindFirst() then begin
                    // If returned before expiry, count it
                    if EmpAssetRec.Returned_Date <> 0D then begin
                        if EmpAssetRec.Returned_Date <= ExpiryDate then
                            AvailableCount += 1;
                    end;
                end else begin
                    // Not assigned to employee, and not lost
                    AvailableCount += 1;
                end;
            until AssetRec.Next() = 0;

        exit(AvailableCount);
    end;

}

