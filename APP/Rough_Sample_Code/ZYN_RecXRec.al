pageextension 50136 recxrec extends "Customer Card"
{

    trigger OnOpenPage()
    begin
        Message('On open page (Rec), the address is: %1', Rec.Address);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Message('On modify, the address is (Rec): %1', Rec.Address);
        Message('On modify, the previous address is (xRec): %1', xRec.Address);
    end;

    var
        myInt: Integer;
}