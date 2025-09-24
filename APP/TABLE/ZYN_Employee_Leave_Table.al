table 50129 ZYN_Employee_Leave_Table
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Employee_ID; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Leave_Category_Name; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = ZYN_Leave_Category_Table.Leave_Category_Name;
            trigger OnValidate()
            var
                LeaveCategoryRec: Record ZYN_Leave_Category_Table;
                LeaveRequestRec: Record ZYN_Leave_Request_Table;
                UsedLeaves: Integer;
                TotalAllowed: Integer;
            begin
                // 1. Find allowed leaves from category
                if LeaveCategoryRec.Get(Leave_Category_Name) then
                    TotalAllowed := LeaveCategoryRec.Number_of_Days
                else
                    TotalAllowed := 0;
                // 2. Calculate already used leaves for this employee & category
                UsedLeaves := 0;
                LeaveRequestRec.Reset();
                LeaveRequestRec.SetRange(Employee_ID, Employee_ID);
                LeaveRequestRec.SetRange(Leave_Category_Name, Leave_Category_Name);
                LeaveRequestRec.SetRange(Approval_Status, LeaveRequestRec.Approval_Status::Approved);
                if LeaveRequestRec.FindSet() then
                    repeat
                        UsedLeaves += (LeaveRequestRec.End_Date - LeaveRequestRec.Start_Date) + 1;
                    until LeaveRequestRec.Next() = 0;

                // 3. Update Remaining Balance
                Remaining_Leave_Balance := TotalAllowed - UsedLeaves;
            end;
        }
        field(3; Remaining_Leave_Balance; Integer)
        {
            // DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Employee_ID)
        {
            Clustered = true;
        }
    }
}