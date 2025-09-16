codeunit 50109 "Last Sold Price Updater"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure OnAfterSalesInvLineInsert(
        var SalesInvLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesLine: Record "Sales Line";
        ItemLedgShptEntryNo: Integer;
        WhseShip: Boolean;
        WhseReceive: Boolean;
        CommitIsSuppressed: Boolean;
        var SalesHeader: Record "Sales Header";
        var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary;
        var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary;
        var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary;
        PreviewMode: Boolean)
    var
        LastSoldRec: Record "Last Sold Price Finder";
    begin
        // Only store for Items
        if SalesInvLine.Type <> SalesInvLine.Type::Item then
            exit;
        // Look for existing record
        LastSoldRec.Reset();
        LastSoldRec.SetCurrentKey("Customer No", "Item No", "Posting Date");
        LastSoldRec.SetRange("Customer No", SalesInvLine."Sell-to Customer No.");
        LastSoldRec.SetRange("Item No", SalesInvLine."No.");
        //      LastSoldRec.SetRange("Sell-to Customer Name", SalesInvLine."Sell-to Customer Name");
        if LastSoldRec.FindLast() then begin
            // Update existing record
            LastSoldRec.Validate("LastItem Sold Price", SalesInvLine."Unit Price");
            LastSoldRec.Validate("Posting Date", SalesInvLine."Posting Date");
            LastSoldRec.Modify(true);
        end else begin
            // Insert new record
            LastSoldRec.Init();
            LastSoldRec.Validate("Customer No", SalesInvLine."Sell-to Customer No.");
            LastSoldRec.Validate("Item No", SalesInvLine."No.");
            LastSoldRec.Validate("LastItem Sold Price", SalesInvLine."Unit Price");
            LastSoldRec.Validate("Posting Date", SalesInvLine."Posting Date");
            //  LastSoldRec.Validate("Sell-to Customer Name", SalesInvLine."Sell-to Customer Name");
            LastSoldRec.Insert(true);
        end;
    end;
}
codeunit 50110 "Last Sold Price Upgrade"
{
    Subtype = Upgrade;
    trigger OnUpgradePerCompany()
    var
        SalesInvLine: Record "Sales Invoice Line";
        LastSoldRec: Record "Last Sold Price Finder";
        TempLastSold: Record "Last Sold Price Finder" temporary;
    begin
        // Step 1: Collect last sold price per Customer–Item from history
        SalesInvLine.Reset();
        SalesInvLine.SetCurrentKey("Sell-to Customer No.", "No.", "Posting Date");
        if SalesInvLine.FindSet() then
            repeat
                if SalesInvLine.Type = SalesInvLine.Type::Item then begin
                    // Keep only the latest posting date per Customer–Item
                    if TempLastSold.Get(SalesInvLine."Sell-to Customer No.", SalesInvLine."No.") then begin
                        if SalesInvLine."Posting Date" > TempLastSold."Posting Date" then begin
                            TempLastSold.Validate("LastItem Sold Price", SalesInvLine."Unit Price");
                            TempLastSold.Validate("Posting Date", SalesInvLine."Posting Date");
                            TempLastSold.Modify();
                        end;
                    end else begin
                        TempLastSold.Init();
                        TempLastSold.Validate("Customer No", SalesInvLine."Sell-to Customer No.");
                        TempLastSold.Validate("Item No", SalesInvLine."No.");
                        TempLastSold.Validate("LastItem Sold Price", SalesInvLine."Unit Price");
                        TempLastSold.Validate("Posting Date", SalesInvLine."Posting Date");
                        TempLastSold.Insert();
                    end;
                end;
            until SalesInvLine.Next() = 0;
        // Step 2: Save data to actual table
        if TempLastSold.FindSet() then
            repeat
                if LastSoldRec.Get(TempLastSold."Customer No", TempLastSold."Item No") then begin
                    LastSoldRec.Validate("LastItem Sold Price", TempLastSold."LastItem Sold Price");
                    LastSoldRec.Validate("Posting Date", TempLastSold."Posting Date");
                    LastSoldRec.Modify(true);
                end else begin
                    LastSoldRec.Init();
                    LastSoldRec.Validate("Customer No", TempLastSold."Customer No");
                    LastSoldRec.Validate("Item No", TempLastSold."Item No");
                    LastSoldRec.Validate("LastItem Sold Price", TempLastSold."LastItem Sold Price");
                    LastSoldRec.Validate("Posting Date", TempLastSold."Posting Date");
                    LastSoldRec.Insert(true);
                end;
            until TempLastSold.Next() = 0;
    end;
}



