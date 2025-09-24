tableextension 50106 "ZYN_LastSoldItemInSalesOrder" extends "Sales Header"
{

    fields
    {
        field(50118; "Last Posting Date"; Date)
        {
            Caption = 'Last Sold Price';
            FieldClass = FlowField;
            CalcFormula = max("ZYN_Last Sold Price Finder"."Posting Date" where("Customer No" = field("Sell-to Customer No."), "Item No" = field("No.")));
        }
        field(50111; "Last Sold Price"; Decimal)
        {
            Caption = 'Last Sold Price';
            FieldClass = FlowField;
            CaptionClass = 'Last Sold Price';
            CalcFormula = max("ZYN_Last Sold Price Finder"."LastItem Sold Price" where("Customer No" = field("Sell-to Customer No."), "Posting Date" = field("Posting Date") ));
        }
    }
}
 
 