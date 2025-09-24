table 50134 ZYN_Subscriber_Table
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Customer_No; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(3; Plan_ID; Integer)
        {
            TableRelation = ZYN_Sub_Plan_Table.Plan_ID;
            trigger OnValidate()
            var
                PlanRec: Record ZYN_Sub_Plan_Table;
            begin
                if PlanRec.Get(Plan_ID) then begin
                    Plan_Fees := PlanRec.Plan_Fees;
                    Plan_Name := PlanRec.Plan_Name;  // ✅ new field update
                end;
            end;

        }
        field(4; Start_Date; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateNextBillDate();
            end;
        }
        field(5; End_Date; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateNextBillDate();
            end;
        }
        field(6; Subscriber_Status; Enum ZYN_Subscriber_Status_Enum)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateNextBillDate();
            end;
        }
        field(7; Next_Bill_Date; Date) { }
        field(8; Plan_Fees; Decimal)
        { }
        field(9; Plan_Name; Text[50])
        { }
        field(10; Next_Renewal_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Reminder_Sent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Customer_No, Plan_ID, ID) { Clustered = true; }
    }
    local procedure UpdateNextBillDate()
    begin
        case Subscriber_Status of
            Subscriber_Status::Active:
                if Start_Date <> 0D then
                    Next_Bill_Date := CalcDate('<1M>', Start_Date);
            Subscriber_Status::Inactive:
                if End_Date <> 0D then
                    Next_Bill_Date := End_Date
                else
                    Next_Bill_Date := 0D; // no end date means no next bill
            Subscriber_Status::Expired:
                Next_Bill_Date := 0D;
        end;
    end;
}
