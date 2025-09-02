table 50104 "Last Sold Price Finder"   //table=50104
{
    DataClassification = ToBeClassified;
 
    fields
    {
        field(1; "Customer No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer No.';
        }
        field(2; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item No.';
        }
        field(3; "LastItem Sold Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'LastItem Sold Price';
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Posting Date';
        }
        // field(5; "Sell-to Customer Name"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Sell-to Customer Name';
        // }
    }
 
    keys
    {
        key(Pk; "Customer No", "Item No")
        {
            Clustered = true;
        }
    }
 
}
 