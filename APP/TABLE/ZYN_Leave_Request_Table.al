table 50128 ZYN_Leave_Request_Table
{
    DataClassification = ToBeClassified;
    Caption = 'ZYN Leave Request';
    fields
    {
        field(1; Leave_ID; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            AutoIncrement = true;
            Caption = 'Leave ID';
        }
        field(2; Employee_ID; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Employee_Table.Employee_ID;
            Caption = 'Employee ID';
        }
        field(3; Leave_Category_Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Leave Category Name';
            TableRelation = ZYN_Leave_Category_Table.Leave_Category_Name;
            trigger OnValidate()
            begin
                UpdateRemainingBalance();   // 🔄 Recalculate balance immediately when category changes
            end;
        }
        field(4; Reason_for_Leave; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason For Leave';
        }
        field(5; Start_Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
            trigger OnValidate()
            begin
                if Start_Date = 0D then
                    Error('⚠️ Please enter the Start Date.');

                if (End_Date <> 0D) and (End_Date < Start_Date) then
                    Error('⚠️ End Date must be greater than or equal to Start Date.');
            end;
        }
        field(6; End_Date; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if End_Date = 0D then
                    Error('⚠️ Please enter the End Date.');

                if (Start_Date <> 0D) and (End_Date < Start_Date) then
                    Error('⚠️ End Date must be greater than or equal to Start Date.');
            end;
        }
        field(7; Approval_Status; Enum ZYN_Leave_Status_Enum)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
            trigger OnValidate()
            begin
                if Rec.Approval_Status = Rec.Approval_Status::Approved then
                    UpdateRemainingBalance();
            end;
        }
        field(8; Remaining_Leave_Balance; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Remaining Leave Balance';
        }
        field(9; Leave_Days; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Leave Days';
        }
    }
    keys
    {
        key(PK; Leave_ID, Employee_ID, Start_Date)
        {
            Clustered = true;
        }
    }
    local procedure CalcLeaveDays()
    begin
        if (Rec.Start_Date <> 0D) and (Rec.End_Date <> 0D) then begin
            if Rec.End_Date >= Rec.Start_Date then
                Rec.Leave_Days := (Rec.End_Date - Rec.Start_Date) + 1
            else
                Rec.Leave_Days := 0; // invalid range
        end;
    end;

    procedure UpdateRemainingBalance()
    var
        LeaveCategory: Record ZYN_Leave_Category_Table;
        LeaveRequests: Record ZYN_Leave_Request_Table;
        UsedDays: Integer;
    begin
        // Get category balance
        if LeaveCategory.Get(Leave_Category_Name) then begin
            UsedDays := 0;
            LeaveRequests.Reset();
            LeaveRequests.SetRange(Employee_ID, Employee_ID);
            LeaveRequests.SetRange(Leave_Category_Name, Leave_Category_Name);
            LeaveRequests.SetRange(Approval_Status, LeaveRequests.Approval_Status::Approved);
            if LeaveRequests.FindSet() then
                repeat
                    UsedDays += (LeaveRequests.End_Date - LeaveRequests.Start_Date + 1);
                until LeaveRequests.Next() = 0;
            Remaining_Leave_Balance := LeaveCategory.Number_of_Days - UsedDays;
        end else
            Remaining_Leave_Balance := 0;
    end;

    trigger OnDelete()
    begin
        if Approval_Status <> Approval_Status::Pending then
            Error('You can only delete Leave Requests that are in Pending status.');
    end;

    var
        myInt: Integer;
        Leave_Days: Integer;
}