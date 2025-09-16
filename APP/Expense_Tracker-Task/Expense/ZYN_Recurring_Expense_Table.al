table 50124 Recurring_Expense_Table
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Category; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense_Category_Table".ExpenseCategory_Name;
        }
        field(2; Recurring_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Recurring_Cycle; Enum Recurring_Options_Enum)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = Daily,Weekly,Monthly,Quarterly,Yearly;
            Caption = 'Recurring Cycle';
            trigger OnValidate()
            begin
                CalcNextCycleDate();
            end;
        }
        field(4; Start_Date; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CalcNextCycleDate();
            end;
        }
        field(5; Next_Cycle_Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Recurring_ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(7; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Category, Recurring_Cycle, Recurring_ID)
        {
            Clustered = true;
        }
    }

    local procedure CalcNextCycleDate()
    begin
        if (Start_Date = 0D) then//or (Recurring_Cycle = Recurring_Cycle::"") then
            exit;
        case Recurring_Cycle of
            Recurring_Cycle::Weekly:
                Next_Cycle_Date := CalcDate('<1W>', Start_Date);
            Recurring_Cycle::Monthly:
                Next_Cycle_Date := CalcDate('<1M>', Start_Date);
            Recurring_Cycle::Quarterly:
                Next_Cycle_Date := CalcDate('<3M>', Start_Date);
            Recurring_Cycle::HalfYearly:
                Next_Cycle_Date := CalcDate('<6M>', Start_Date);
            Recurring_Cycle::Yearly:
                Next_Cycle_Date := CalcDate('<1Y>', Start_Date);
        end;
    end;
}
