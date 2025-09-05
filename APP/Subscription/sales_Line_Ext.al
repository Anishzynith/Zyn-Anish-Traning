tableextension 50109 "Sales Line Subscriber Ext" extends "Sales Line"
{
    fields
    {
        field(50100; "Plan Name"; Text[100])
        {
            Caption = 'Plan Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Sub_Plan_Table.Plan_Name
                where(Plan_ID = field("Plan ID Ref")));
        }

        field(50101; "Plan Fees"; Decimal)
        {
            Caption = 'Plan Fees';
            FieldClass = FlowField;
            CalcFormula = lookup(Subscriber_Table.Plan_Fees
                where(Customer_No = field("Sell-to Customer No."),
                      Plan_ID = field("Plan ID Ref")));
        }

        field(50102; "Plan ID Ref"; Integer)
        {
            Caption = 'Plan Reference';
            DataClassification = ToBeClassified;
        }
    }
}
