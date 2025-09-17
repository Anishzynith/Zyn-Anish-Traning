page 50178 Expense_Claim_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Expense_Claim_Table;

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
                        CurrPage.Update(false);
                    end;
                }
                field(Claiming_Category; Rec.Claiming_Category)
                {
                    trigger OnDrillDown()
                    var
                        ClaimCategoryRec: Record Claim_Category_Table;
                        SelectedCategory: Code[20];
                    begin
                        // Open the lookup page in modal style
                        if PAGE.RunModal(PAGE::Claim_Category_Page, ClaimCategoryRec) = ACTION::LookupOK then begin
                            // Get the selected record

                            Rec.Claiming_Category := ClaimCategoryRec.Claiming_Category;
                            Rec.Subtype := ClaimCategoryRec.SubType; // Autofill Subtype\

                        end;
                    end;

                    trigger OnValidate()
                    begin
                        CalcAvailableAmount();
                        CurrPage.Update(false);
                    end;
                }
                field(Claim_Date; Rec.Claim_Date)
                {

                }
                field(Claim_Amount; Rec.Claim_Amount)
                {
                    trigger OnValidate()
                    begin
                        CalcAvailableAmount();
                        if Rec.Claim_Amount > AvailableAmount then
                            Error('Claim amount %1 exceeds available balance %2.',
                                  Rec.Claim_Amount, AvailableAmount);
                        CurrPage.Update(false);
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
                        CurrPage.Update(false);
                    end;
                }
                field(Bill_FileName; Rec.Bill_FileName)
                {
                }
                field(Available_Amount; Rec.Available_Amount)
                {
                    // Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(action)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        AvailableAmount: Decimal;

    local procedure CalcAvailableAmount()
    var
        ClaimCategoryRec: Record Claim_Category_Table;
        ClaimHistory: Record Expense_Claim_Table;
        UsedAmount: Decimal;
    begin
        AvailableAmount := 0;
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

            AvailableAmount := ClaimCategoryRec.Max_Amount - UsedAmount;
        end;
    end;

}