// tableextension 50109 "Sales Line Subscriber Ext" extends "Sales Line"
// {
//     fields
//     {
//         field(50100; "Plan Name"; Text[100])
//         {
//             Caption = 'Plan Name';
//             FieldClass = FlowField;
//             CalcFormula = lookup(Sub_Plan_Table.Plan_Name
//                 where(Plan_ID = field("Plan ID Ref")));
//         }

//         field(50101; "Plan Fees"; Decimal)
//         {
//             Caption = 'Plan Fees';
//             FieldClass = FlowField;
//             CalcFormula = lookup(Subscriber_Table.Plan_Fees
//                 where(Customer_No = field("Sell-to Customer No."),
//                       Plan_ID = field("Plan ID Ref")));
//         }

//         field(50102; "Plan ID Ref"; Integer)
//         {
//             Caption = 'Plan Reference';
//             DataClassification = ToBeClassified;
//         }

//     }
// }

page 50176 "Revenue Cue"
{
    PageType = CardPart;
    SourceTable = "Subscriber_Table";
    ApplicationArea = All;
 
    layout
    {
        area(content)
        {
            cuegroup(Subscriptions)
            {
                Caption = 'Subscriptions';
 
                field("Revenue Generated"; RevenueGenerated())
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Invoice List";
                    DrillDown = true;
 
                    trigger OnDrillDown()
                    var
                        SalesInv: Record "Sales Header";
                    begin
                        WorkMonth := Date2DMY(WorkDate(), 2);
                        WorkYear := Date2DMY(WorkDate(), 3);
 
                        SalesInv.SetFilter("No.", '*SUBINV*');
                        SalesInv.SetRange("Document Date", DMY2Date(1, WorkMonth, WorkYear),
                                   DMY2Date(31, WorkMonth, WorkYear));
                        PAGE.Run(PAGE::"Sales Invoice List", SalesInv);
                    end;
                }
            }
        }
    }
    var
        sales: Record "Sales Header";
        salesline: record "sales line";
 
        WorkMonth: Integer;
        WorkYear: Integer;
 
    local procedure RevenueGenerated(): Decimal
    var
        totamount: Decimal;
 
    begin
 
        WorkMonth := Date2DMY(WorkDate(), 2);
        WorkYear := Date2DMY(WorkDate(), 3);
 
        sales.Reset();
        sales.SetRange("From Subscription", true);
        Sales.SetRange("Document Date", DMY2Date(1, WorkMonth, WorkYear),
                                    DMY2Date(31, WorkMonth, WorkYear));
        if sales.FindSet() then begin
            repeat
                sales.CalcFields("Amount");
                totamount += sales."Amount";
            until sales.Next() = 0;
        end;
        exit(totamount)
    end;
 
 
}
 