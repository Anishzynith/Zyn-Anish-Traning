page 50177 Expense_Claim_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Expense_Claim_Table;
    CardPageId = Expense_Claim_Card;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Exp_Id; Rec.Exp_Id)
                {

                }
                field(Employee_ID; Rec.Employee_ID)
                {

                }
                field(Claiming_Category; Rec.Claiming_Category)
                {

                }
                field(Claim_Date; Rec.Claim_Date)
                {

                }
                field(Claim_Amount; Rec.Claim_Amount)
                {

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
                }
                field(Bill_FileName; Rec.Bill_FileName)
                {
                }
                field(Available_Amount; Rec.Available_Amount)
                {
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
            action(Cancel_Claim)
            {
                Caption = 'Cancel Claim';
                ApplicationArea = All;
                Image = Cancel;

                trigger OnAction()
                begin
                    // 1. Only pending claims can be cancelled
                    if Rec.Claim_Status <> Claim_Status::Pending_Approval then
                        Error('Only claims in Pending Approval status can be cancelled.');

                    // 2. Confirm with user
                    if not Confirm('Do you really want to cancel claim %1?', false, Rec.Exp_Id) then
                        exit;

                    // 3. Update status
                    Rec.Claim_Status := Claim_status::Cancelled;
                    Rec.Modify(true);

                    Message('Claim %1 cancelled successfully.', Rec.Exp_Id);

                    // 4. Refresh page
                    CurrPage.Update();
                end;
            }
            action(UploadBill)
            {
                Caption = 'Upload Bill';
                ApplicationArea = All;
                Image = Apply;

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                    FileName: Text;
                begin
                    if UploadIntoStream('Select Bill File', '', '', FileName, InStr) then begin
                        Rec."Bill_Reference".CreateOutStream(OutStr);
                        CopyStream(OutStr, InStr);

                        Rec."Bill_FileName" := FileName;
                        Rec.Modify(true);

                        Message('Bill file "%1" uploaded successfully.', FileName);
                    end;
                end;
            }

            action(DownloadBill)
            {
                Caption = 'Download Bill';
                ApplicationArea = All;
                Image = Download;
                trigger OnAction()
                var
                    InStr: InStream;
                    FileName: Text;
                begin
                    if Rec."Bill_Reference".HasValue then begin
                        Rec."Bill_Reference".CreateInStream(InStr);
                        FileName := Rec."Bill_FileName";
                        if FileName = '' then
                            FileName := 'BillFile.bin';

                        DownloadFromStream(InStr, 'Download Bill', '', '', FileName);
                    end else
                        Message('No bill file has been uploaded.');
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Claim_Status, Claim_Status::Pending_Approval); // Show only pending claims
    end;
}
