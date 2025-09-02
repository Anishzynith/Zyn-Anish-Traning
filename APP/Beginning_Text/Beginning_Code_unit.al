codeunit 50101 "Post Sales Invoice"
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    local procedure OnAfterSalesInvHeaderInsertBegin(var SalesInvHeader: Record "Sales Invoice Header";
     SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean;
     WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header";
     var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean)
    var
        PostedExtendedTextTable: Record "Sales Invoice Text Code";
        ExtendedTextTable: Record "Sales Invoice Text Code";
    begin
        SalesInvHeader."Beginning Text" := SalesHeader."Beginning Text";
        ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        ExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection::BeginningText);
        if ExtendedTextTable.FindSet() then begin
            repeat
                /*   PostedExtendedTextTable.Init();
                   PostedExtendedTextTable."No." := SalesInvHeader."No.";
                   PostedExtendedTextTable."Language Code" := ExtendedTextTable."Language Code";
                   PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::BeginningText;
                   // PostedExtendedTextTable."Sell to Customer Name" := ExtendedTextTable."Sell to Customer Name";
                   //   PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                   PostedExtendedTextTable."Document Type" := ExtendedTextTable."Document Type"::"Posted Invoice";
                   PostedExtendedTextTable."Text" := ExtendedTextTable."Text";
                   PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                   PostedExtendedTextTable.insert();
                   */
                PostedExtendedTextTable.SetRange("No.", SalesInvHeader."No.");
                PostedExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection);
                PostedExtendedTextTable.SetRange("Language Code", ExtendedTextTable."Language Code");
                PostedExtendedTextTable.SetRange("Document Type", PostedExtendedTextTable."Document Type"::"Posted Invoice");

                if PostedExtendedTextTable.FindLast() then
                    PostedExtendedTextTable.lineNO := PostedExtendedTextTable.lineNO + 1
                else
                    PostedExtendedTextTable.lineNO := 1;

                PostedExtendedTextTable.Init();
                PostedExtendedTextTable."No." := SalesInvHeader."No.";
                PostedExtendedTextTable."Language Code" := ExtendedTextTable."Language Code";
                PostedExtendedTextTable.Selection := ExtendedTextTable.Selection;
                PostedExtendedTextTable."Document Type" := PostedExtendedTextTable."Document Type"::"Posted Invoice";
                PostedExtendedTextTable."Text" := ExtendedTextTable."Text";

                // Insert record
                PostedExtendedTextTable.Insert();

            until ExtendedTextTable.Next() = 0;
        end;
        ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        ExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection::BeginningText);
        ExtendedTextTable.DeleteAll();
        /*   ExtendedTextTable.SetRange("No.", SalesHeader."No.");
           if ExtendedTextTable.FindSet() then begin
               ExtendedTextTable.DeleteAll();
           end;   */
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    local procedure OnAfterSalesInvHeaderInsertEnd(var SalesInvHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean;
         WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header";
          var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean)

    var
        PostedExtendedTextTable: Record "Sales Invoice Text Code";
        ExtendedTextTable: Record "Sales Invoice Text Code";
    begin
        SalesInvHeader."Ending Text" := SalesHeader."Ending Text";
        ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        //ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        ExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection::EndingText);
        if ExtendedTextTable.FindSet() then begin
            repeat
                PostedExtendedTextTable.Init();
                /*     PostedExtendedTextTable."No." := SalesInvHeader."No.";
                     PostedExtendedTextTable."Language Code" := ExtendedTextTable."Language Code";
                     PostedExtendedTextTable.Selection := PostedExtendedTextTable.Selection::EndingText;
                     //   PostedExtendedTextTable."Sell to Customer Name" := ExtendedTextTable."Sell to Customer Name";
                     //   PostedExtendedTextTable."Line No." := ExtendedTextTable."Line No.";
                     PostedExtendedTextTable."Document Type" := ExtendedTextTable."Document Type"::"Posted Invoice";
                     PostedExtendedTextTable."Text" := ExtendedTextTable."Text";
                     PostedExtendedTextTable.Text := ExtendedTextTable.Text;
                     PostedExtendedTextTable.insert();
                     */
                PostedExtendedTextTable.SetRange("No.", SalesInvHeader."No.");
                PostedExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection);
                PostedExtendedTextTable.SetRange("Language Code", ExtendedTextTable."Language Code");
                PostedExtendedTextTable.SetRange("Document Type", PostedExtendedTextTable."Document Type"::"Posted Invoice");

                if PostedExtendedTextTable.FindLast() then
                    PostedExtendedTextTable.lineNO := PostedExtendedTextTable.lineNO + 1
                else
                    PostedExtendedTextTable.lineNO := 1;

                PostedExtendedTextTable.Init();
                PostedExtendedTextTable."No." := SalesInvHeader."No.";
                PostedExtendedTextTable."Language Code" := ExtendedTextTable."Language Code";
                PostedExtendedTextTable.Selection := ExtendedTextTable.Selection;
                PostedExtendedTextTable."Document Type" := PostedExtendedTextTable."Document Type"::"Posted Invoice";
                PostedExtendedTextTable."Text" := ExtendedTextTable."Text";

                // Insert record
                PostedExtendedTextTable.Insert();

            until ExtendedTextTable.Next() = 0;
        end;
        ExtendedTextTable.SetRange("No.", SalesHeader."No.");
        ExtendedTextTable.SetRange(Selection, ExtendedTextTable.Selection::EndingText);
        ExtendedTextTable.DeleteAll();
        /*   ExtendedTextTable.SetRange("No.", SalesHeader."No.");
           if ExtendedTextTable.FindSet() then begin
               ExtendedTextTable.DeleteAll();
           end;   */
    end;
}
