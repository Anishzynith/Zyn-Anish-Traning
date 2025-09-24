tableextension 50102 "ZYN_SalesInvHeaderextenstion" extends "Sales Header"
{
    fields
    {
        field(50104; "Subscription ID"; Code[20])
        {
            Caption = 'Subscription ID';
            DataClassification = CustomerContent;
        }
        field(50107; "Subscription Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50190; "Subscription Amount"; Decimal)
        {
            Caption = 'Subscription Amount';
            DataClassification = CustomerContent;
        }
        field(50108; "From Subscription"; boolean)
        {
            Caption = 'From Subscription';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Pk; "Subscription ID")
        { }  // Add changes to keys here
    }
}