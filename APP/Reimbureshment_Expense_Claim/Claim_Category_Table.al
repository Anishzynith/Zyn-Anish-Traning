table 50136 Claim_Category_Table
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

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure UpdateAvailableAmount(EmployeeID: Integer; ClaimCategory: Text[50]; SubType: Text[50])
    var
        ClaimRec: Record Expense_Claim_Table;
        TotalApproved: Decimal;
    begin
        // Sum of approved claims for this Employee + Category + Subtype
        ClaimRec.Reset();
        ClaimRec.SetRange(Employee_ID, EmployeeID);
        ClaimRec.SetRange(Claiming_Category, ClaimCategory);
        ClaimRec.SetRange(SubType, SubType);
        ClaimRec.SetRange(Claim_Status, Claim_Status::Approved);

        if ClaimRec.FindSet() then
            repeat
                TotalApproved += ClaimRec.Claim_Amount;
            until ClaimRec.Next() = 0;

        // Update Available = Max - Approved
        Available_Amount := Max_Amount - TotalApproved;
        Modify(true);
    end;


}