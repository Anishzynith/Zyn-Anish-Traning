page 50180 Expense_Approval_Request
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Expense_Claim_Table;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Exp_Id; Rec.Exp_Id) { ApplicationArea = All; }
                field(Employee_ID; Rec.Employee_ID) { ApplicationArea = All; }
                field(Claiming_Category; Rec.Claiming_Category) { ApplicationArea = All; }
                field(SubType; Rec.SubType) { ApplicationArea = All; }
                field(Claim_Date; Rec.Claim_Date) { ApplicationArea = All; }
                field(Claim_Amount; Rec.Claim_Amount) { ApplicationArea = All; }
                field(Claim_Status; Rec.Claim_Status) { ApplicationArea = All; }
                field(Bill_Reference; Rec.Bill_Reference)
                {
                    ApplicationArea = All;
                    Caption = 'Bill Reference (File)';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                var
                    ClaimCategoryRec: Record Claim_Category_Table;
                    ClaimCheckRec: Record Expense_Claim_Table;
                    MaxDateAllowed: Date;
                begin
                    // 1. Check Status
                    if Rec.Claim_Status <> Claim_Status::Pending_Approval then
                        Error('Only Pending Approval claims can be approved.');

                    // 2. Check Max Amount
                    ClaimCategoryRec.Reset();
                    ClaimCategoryRec.SetRange(Claiming_Category, Rec.Claiming_Category);
                    ClaimCategoryRec.SetRange(SubType, Rec.SubType);
                    if ClaimCategoryRec.FindFirst() then begin
                        if Rec.Claim_Amount > ClaimCategoryRec.Max_Amount then
                            Error('Claim amount %1 exceeds max allowed %2 for this category and subtype.',
                                Rec.Claim_Amount, ClaimCategoryRec.Max_Amount);
                    end else
                        Error('No Claim Category setup found for %1 - %2.',
                            Rec.Claiming_Category, Rec.SubType);

                    // 3. Check Bill Date (must be within last 3 months from Claim_Date)
                    MaxDateAllowed := CalcDate('<-3M>', Rec.Claim_Date); // 3 months before Claim_Date

                    if Rec.Bill_Date < MaxDateAllowed then
                        Error(
                          'Bill date %1 is older than 3 months compared to claim date %2.',
                          Rec.Bill_Date, Rec.Claim_Date);


                    //4. Duplicate check across Approved and Pending Approval
                    ClaimCheckRec.Reset();
                    ClaimCheckRec.SetRange(Employee_ID, Rec.Employee_ID);
                    ClaimCheckRec.SetRange(Claiming_Category, Rec.Claiming_Category);
                    ClaimCheckRec.SetRange(SubType, Rec.SubType);
                    ClaimCheckRec.SetFilter(Claim_Status, 'Approved|Pending_Approval');
                    ClaimCheckRec.SetFilter(Bill_Date, '%1..%2', MaxDateAllowed, WorkDate());
                    ClaimCheckRec.SetFilter(Exp_Id, '<>%1', Rec.Exp_Id); // exclude current record

                    if ClaimCheckRec.FindSet() then
                        Error(
                            'Duplicate claim found for Employee %1, Category %2, SubType %3 within last 3 months.',
                            Rec.Employee_ID, Rec.Claiming_Category, Rec.SubType);

                    // Update available amount for this category
                    ClaimCategoryRec.Reset();
                    ClaimCategoryRec.SetRange(Claiming_Category, Rec.Claiming_Category);
                    ClaimCategoryRec.SetRange(SubType, Rec.SubType);
                    if ClaimCategoryRec.FindSet() then begin
                        ClaimCategoryRec.UpdateAvailableAmount(Rec.Employee_ID, Rec.Claiming_Category, Rec.SubType);
                    end;

                    Message('Claim %1 approved successfully. Available amount updated.', Rec.Exp_Id);

                    CalcAvailableAmount();

                    if Rec.Claim_Amount > Available_Amount then
                        Error(
                          'Claim amount %1 exceeds available amount %2 for this employee in this category/subtype.',
                          Rec.Claim_Amount, Available_Amount);

                    // 5. Approve
                    Rec.Claim_Status := Claim_Status::Approved;
                    Rec.Modify(true);
                    Message('Claim approved successfully.');

                    // 6. Removed from this page automatically since filter is on Pending_Approval
                    CurrPage.Update();
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Cancel;

                trigger OnAction()
                begin
                    if Rec.Claim_Status <> Claim_Status::Pending_Approval then
                        Error('Only Pending Approval claims can be rejected.');

                    if Confirm('Do you want to reject claim %1?', false, Rec.Exp_Id) then begin
                        Rec.Claim_Status := Claim_Status::Rejected;
                        Rec.Modify(true);
                        Message('Claim %1 rejected successfully.', Rec.Exp_Id);
                        CurrPage.Update();
                    end;
                end;
            }
            action(ViewClaim)
            {
                Caption = 'View Claim';
                ApplicationArea = All;
                RunObject = page "Expense_Claim_Card";
                RunPageLink = Exp_Id = field(Exp_Id);
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Claim_Status, Claim_Status::Pending_Approval); // Show only pending claims
    end;

    local procedure CalcAvailableAmount()
    var
        ClaimCategoryRec: Record Claim_Category_Table;
        ClaimHistory: Record Expense_Claim_Table;
        UsedAmount: Decimal;
    begin
        Available_Amount := 0;
        UsedAmount := 0;

        if (Rec.Employee_ID = ' ') or (Rec.Claiming_Category = '') or (Rec.SubType = '') then
            exit;

        // Get Max Amount for category + subtype
        ClaimCategoryRec.Reset();
        ClaimCategoryRec.SetRange(Claiming_Category, Rec.Claiming_Category);
        ClaimCategoryRec.SetRange(SubType, Rec.SubType);

        if ClaimCategoryRec.FindFirst() then begin
            // Get already approved usage for this employee + category + subtype
            ClaimHistory.Reset();
            ClaimHistory.SetRange(Employee_ID, Rec.Employee_ID);
            ClaimHistory.SetRange(Claiming_Category, Rec.Claiming_Category);
            ClaimHistory.SetRange(SubType, Rec.SubType);
            ClaimHistory.SetRange(Claim_Status, Claim_Status::Approved);

            if ClaimHistory.FindSet() then
                repeat
                    UsedAmount += ClaimHistory.Claim_Amount;
                until ClaimHistory.Next() = 0;

            Available_Amount := ClaimCategoryRec.Max_Amount - UsedAmount;
        end;
    end;

    var
        Available_Amount: Decimal;
}