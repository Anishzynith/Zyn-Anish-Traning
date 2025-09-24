page 50178 ZYN_Expense_Claim_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Expense_Claim_Table;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Exp_Id; Rec.Exp_Id)
                {

                }
                field(Employee_ID; Rec.Employee_ID)
                {
                    trigger OnValidate()
                    begin
                        CalcAvailableAmount();
                    end;
                }
                field(Claiming_Category; Rec.Claiming_Category)
                {
                    trigger OnDrillDown()
                    var
                        ClaimCategoryRec: Record ZYN_Claim_Category_Table;
                        SelectedCategory: Code[20];
                    begin
                        // Open the lookup page in modal style
                        if PAGE.RunModal(PAGE::ZYN_Claim_Category_Page, ClaimCategoryRec) = ACTION::LookupOK then begin
                            // Get the selected record

                            Rec.Claiming_Category := ClaimCategoryRec.Claiming_Category;
                            Rec.Subtype := ClaimCategoryRec.SubType; // Autofill Subtype\
                            CalcAvailableAmount();
                        end;
                    end;

                    trigger OnValidate()
                    var
                        ClaimCategoryRec: Record ZYN_Claim_Category_Table;
                    begin
                        // Auto-fill subtype if found
                        if Rec.Claiming_Category <> '' then begin
                            ClaimCategoryRec.Reset();
                            ClaimCategoryRec.SetRange(Claiming_Category, Rec.Claiming_Category);
                            if ClaimCategoryRec.FindFirst() then
                                Rec.Subtype := ClaimCategoryRec.SubType;
                        end;
                        CalcAvailableAmount();
                    end;
                    // trigger OnValidate()
                    // begin
                    //     CalcAvailableAmount();
                    // end;
                }
                field(Claim_Date; Rec.Claim_Date)
                {

                }
                field(Claim_Amount; Rec.Claim_Amount)
                {
                    trigger OnValidate()
                    begin
                        CalcAvailableAmount();
                        if Rec.Claim_Amount > Rec.Available_Amount then
                            Error('Claim amount %1 exceeds available balance %2.',
                                Rec.Claim_Amount, Rec.Available_Amount);
                    end;
                }
                field(Claim_Status; Rec.Claim_Status)
                {

                }
                field(Bill_Reference; Rec.Bill_Reference)
                {

                }
                field(Bill_Date; Rec.Bill_Date)
                {

                }
                field(Remarks; Rec.Remarks)
                {

                }
                field(SubType; Rec.SubType)
                {
                    trigger OnValidate()
                    begin
                        CalcAvailableAmount();
                    end;
                }
                field(Bill_FileName; Rec.Bill_FileName)
                {
                }
                field(Available_Amount; Rec.Available_Amount)
                {
                    Editable = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        CalcAvailableAmount();
    end;

    local procedure CalcAvailableAmount()
    var
        ClaimCategoryRec: Record ZYN_Claim_Category_Table;
        ClaimHistory: Record ZYN_Expense_Claim_Table;
        UsedAmount: Decimal;
    begin
        Rec.Available_Amount := 0;
        UsedAmount := 0;

        if (Rec.Employee_ID = ' ') or (Rec.Claiming_Category = '') or (Rec.SubType = '') then
            exit;

        // Get Max Amount for category + subtype
        ClaimCategoryRec.Reset();
        ClaimCategoryRec.SetRange(Claiming_Category, Rec.Claiming_Category);
        ClaimCategoryRec.SetRange(SubType, Rec.SubType);

        if ClaimCategoryRec.FindSet() then begin
            // Get already used claims (Approved + optionally Pending_Approval)
            ClaimHistory.Reset();
            ClaimHistory.SetRange(Employee_ID, Rec.Employee_ID);
            ClaimHistory.SetRange(Claiming_Category, Rec.Claiming_Category);
            ClaimHistory.SetRange(SubType, Rec.SubType);

            // Business rule: block for both Approved + Pending_Approval
            ClaimHistory.SetFilter(Claim_Status, '%1|%2',
                                   ZYN_Claim_status::Approved,
                                   ZYN_Claim_status::Pending_Approval);

            if ClaimHistory.FindSet() then
                repeat
                    UsedAmount += ClaimHistory.Claim_Amount;
                until ClaimHistory.Next() = 0;

            Rec.Available_Amount := ClaimCategoryRec.Max_Amount - UsedAmount;
        end;

        CurrPage.UPDATE; // refresh the page to update fields
    end;

}