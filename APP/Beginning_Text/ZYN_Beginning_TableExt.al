tableextension 50100 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50105; "Beginning Text"; Text[100])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Standard Text".Code;
            trigger OnValidate()
            var
                Extended: Record "Extended Text Line";
                Beginning: Record "Sales Invoice Text Code";
                Customer: Record Customer;
            //       LineNo:Integer;
            begin
                // Delete previous lines if needed
                Beginning.SetRange("Sell to Customer No.", Rec."Sell-to Customer No.");
                Beginning.SetRange(Selection, Beginning.Selection::BeginningText);
                Beginning.DeleteAll();
                if Customer.Get(Rec."Sell-to Customer No.") then begin
                    extended.SetRange("No.", Rec."Beginning Text");
                    extended.SetRange("Language Code", Customer."Language Code");
                    //       LineNo:= 0;
                    if extended.FindSet() then begin
                        repeat
                            Beginning.Init();
                            Beginning."Sell to Customer No." := Rec."Sell-to Customer No.";
                            Beginning."No." := Rec."No.";
                            Beginning."Language Code" := Extended."Language Code";
                            Beginning."Text" := extended.Text;
                            Beginning."Document Type" := Rec."Document Type";
                            Beginning.Selection := Beginning.Selection::BeginningText;
                            // Set unique line no
                            Beginning.SetRange("No.", Rec."No.");
                            Beginning.SetRange("Selection", Beginning.Selection::BeginningText);
                            Beginning.SetRange("Language Code", Extended."Language Code");
                            Beginning.SetRange("Document Type", Rec."Document Type");
                            if Beginning.FindLast() then
                                Beginning.lineNO := Beginning.lineNO + 1
                            else
                                Beginning.lineNO := 1;
                            Beginning.Insert();
                        until extended.Next() = 0;
                    end;
                end;
                //CurrPage.BeginningLine.Page.SaveRecord();
            end;
        }
        field(50106; "Ending Text"; Text[100])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Standard Text".Description;
            trigger OnValidate()
            var
                Extended: Record "Extended Text Line";
                Beginning: Record "Sales Invoice Text Code";
                Customer: Record Customer;
            //       LineNo:Integer;
            begin
                // Delete previous lines if needed
                Beginning.SetRange("Sell to Customer No.", Rec."Sell-to Customer No.");
                Beginning.SetRange(Selection, Beginning.Selection::EndingText);
                Beginning.DeleteAll();
                if Customer.Get(Rec."Sell-to Customer No.") then begin
                    extended.SetRange("No.", Rec."Ending Text");
                    extended.SetRange("Language Code", Customer."Language Code");
                    //   LineNo:= 0;
                    if extended.FindSet() then begin
                        repeat
                            Beginning.Init();
                            Beginning."Sell to Customer No." := Rec."Sell-to Customer No.";
                            Beginning."No." := Rec."No.";
                            Beginning."Language Code" := Extended."Language Code";
                            Beginning."Text" := extended.Text;
                            Beginning."Document Type" := Rec."Document Type";
                            Beginning.Selection := Beginning.Selection::EndingText;
                            // Set unique line no
                            Beginning.SetRange("No.", Rec."No.");
                            Beginning.SetRange("Selection", Beginning.Selection::EndingText);
                            Beginning.SetRange("Language Code", Extended."Language Code");
                            Beginning.SetRange("Document Type", Rec."Document Type");
                            if Beginning.FindLast() then
                                Beginning.lineNO := Beginning.lineNO + 1
                            else
                                Beginning.lineNO := 1;
                            Beginning.Insert();
                        until extended.Next() = 0;
                    end;
                end;
                //CurrPage.EndingLine.Page.SaveRecord();
            end;
        }
    }
}
tableextension 50101 "Sales Line Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50105; "Beginning Text"; Text[100])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Standard Text".Code;
        }
        field(50106; "Ending Text"; Text[100])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Standard Text".Description;
        }
        field(50129; "Beginning Text Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50126; "Ending Text Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}

tableextension 50108 ExtenderTableExt extends "Extended Text Line"
{
    fields
    {
        // Add changes to table fields here
        field(50109; Bold; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; Italic; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; UnderLine; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}