codeunit 50104 "ZYN_Post Sales Order Invoice"
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    procedure postedorderinvoicebegin(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    var
        PostedExtendedTextTable: Record "ZYN_Sales Invoice Text Code";
        ExtendedTextTable: Record "Extended Text Line";
    begin
        SalesInvHeader."Beginning Text Code" := SalesHeader."Invoice Posted Begin OrderText";
        // SalesInvHeader."invoice ending Text code" := SalesHeader."Invoice Ending Text Code";
        ExtendedTextTable.SetRange("No.", SalesInvHeader."Beginning Text Code");
        ExtendedTextTable.SetRange("Language Code", SalesHeader."Language Code");
        if PostedExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                PostedExtendedTextTable.lineNO := 0;
                PostedExtendedTextTable."No." := SalesInvHeader."No.";
                // PostedExtendedTextTable."Sell to Customer No." := SalesHeader."Sell-to Customer No.";
                PostedExtendedTextTable."Document Type" := PostedExtendedTextTable."Document Type"::"Posted Invoice";
                PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::BeginningText;
                PostedExtendedTextTable.insert();
            until ExtendedTextTable.Next() = 0;
        end;
        PostedExtendedTextTable.SetRange("No.", SalesHeader."No.");
        if PostedExtendedTextTable.FindSet() then begin
            PostedExtendedTextTable.DeleteAll();
        end;
    end;
     [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    procedure postedorderinvoiceend(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    var
        PostedExtendedTextTable: Record "ZYN_Sales Invoice Text Code";
        ExtendedTextTable: Record "Extended Text Line";
    begin
       // SalesInvHeader."Beginning Text Code" := SalesHeader."Invoice Posted Begin OrderText";
        SalesInvHeader."Ending Text Code" := SalesHeader."Invoice Posted End OrderText";
        ExtendedTextTable.SetRange("No.", SalesInvHeader."Ending Text code");
        ExtendedTextTable.SetRange("Language Code", SalesHeader."Language Code");
        if PostedExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                PostedExtendedTextTable.lineNO := 0;
                PostedExtendedTextTable."No." := SalesInvHeader."No.";
                // PostedExtendedTextTable."Sell to Customer No." := SalesHeader."Sell-to Customer No.";
                PostedExtendedTextTable."Document Type" := PostedExtendedTextTable."Document Type"::"Posted Invoice";
                PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::EndingText;
                PostedExtendedTextTable.insert();
            until ExtendedTextTable.Next() = 0;
        end;
        PostedExtendedTextTable.SetRange("No.", SalesHeader."No.");
        if PostedExtendedTextTable.FindSet() then begin
            PostedExtendedTextTable.DeleteAll();
        end;
    end;
}


   

