pageextension 50140 "Sales Line Subscriber Ext Page" extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Plan Name"; Rec."Plan Name")
            {
                ApplicationArea = All;
            }
            field("Plan Fees"; Rec."Plan Fees")
            {
                ApplicationArea = All;
            }
        }
    }
}
