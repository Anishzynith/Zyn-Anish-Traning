table 50136 ZYN_Claim_Category_Table
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Claim_Code; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Claiming_Category; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; SubType; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Max_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Available_Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false; // Should not be manually entered
        }
    }
    keys
    {
        key(Key1; Claim_Code, Claiming_Category, SubType)
        {
            Clustered = true;
        }
    }
    procedure UpdateAvailableAmount(EmployeeID: Integer; ClaimCategory: Text[50]; SubType: Text[50])
    var
        ClaimRec: Record ZYN_Expense_Claim_Table;
        TotalApproved: Decimal;
    begin
        // Sum of approved claims for this Employee + Category + Subtype
        ClaimRec.Reset();
        ClaimRec.SetRange(Employee_ID, EmployeeID);
        ClaimRec.SetRange(Claiming_Category, ClaimCategory);
        ClaimRec.SetRange(SubType, SubType);
        ClaimRec.SetRange(Claim_Status, ZYN_Claim_status::Approved);
        if ClaimRec.FindSet() then
            repeat
                TotalApproved += ClaimRec.Claim_Amount;
            until ClaimRec.Next() = 0;
        // Update Available = Max - Approved
        Available_Amount := Max_Amount - TotalApproved;
        Modify(true);
    end;


}