codeunit 50103 "ZYN_Post Credit Memo"
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesCrMemoHeaderInsert, '', false, false)]
    local procedure OnAfterSalesCrMemoHeaderInsertBegin(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        PostedExtendedTextTable: Record "ZYN_Sales Invoice Text Code";
        ExtendedTextTable: Record "ZYN_Sales Invoice Text Code";
    begin
        SalesCrMemoHeader."Beginning Posted Memo" := SalesHeader."Beginning Text";
        ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        ExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection::BeginningText);
        if ExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                PostedExtendedTextTable."No." := SalesCrMemoHeader."No.";
                PostedExtendedTextTable."Language Code" := ExtendedTextTable."Language Code";
                PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::BeginningText;
                // PostedExtendedTextTable."Sell to Customer Name" := ExtendedTextTable."Sell to Customer Name";
                //   PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                PostedExtendedTextTable."Document Type" := ExtendedTextTable."Document Type"::"Posted Credit Memo";
                PostedExtendedTextTable."Text" := ExtendedTextTable."Text";
                PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                PostedExtendedTextTable.insert();

            until ExtendedTextTable.Next() = 0;
        end;
        ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        ExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection::BeginningText);
        ExtendedTextTable.DeleteAll();
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesCrMemoHeaderInsert, '', false, false)]
    local procedure OnAfterSalesCrMemoHeaderInsertEnd(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        PostedExtendedTextTable: Record "ZYN_Sales Invoice Text Code";
        ExtendedTextTable: Record "ZYN_Sales Invoice Text Code";
    begin
        SalesCrMemoHeader."Ending Posted Memo" := SalesHeader."Ending Text";
        ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        //ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        ExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection::EndingText);
        if ExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                PostedExtendedTextTable."No." := SalesCrMemoHeader."No.";
                PostedExtendedTextTable."Language Code" := ExtendedTextTable."Language Code";
                PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::EndingText;
                //   PostedExtendedTextTable."Sell to Customer Name" := ExtendedTextTable."Sell to Customer Name";
                //   PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                PostedExtendedTextTable."Document Type" := ExtendedTextTable."Document Type"::"Posted Credit Memo";
                PostedExtendedTextTable."Text" := ExtendedTextTable."Text";
                PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                PostedExtendedTextTable.insert();
            until ExtendedTextTable.Next() = 0;
        end;
        ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        ExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection::EndingText);
        ExtendedTextTable.DeleteAll();
    end;
}
