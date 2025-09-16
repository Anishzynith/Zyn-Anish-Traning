page 50158 Company_Asset_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Company_Asset_Table;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Asset_Type; Rec.Asset_Type)
                {
                    ApplicationArea = All;
                }
                field(Serial_NO; Rec.Serial_NO)
                {
                    ApplicationArea = All;
                }
                field(Procured_Date; Rec.Procured_Date)
                {
                    ApplicationArea = All;
                }
                field(Vendor_Name; Rec.Vendor_Name)
                {
                    ApplicationArea = All;
                }
                field(Available_Asset; Rec.Available_Asset)
                {
                    ApplicationArea = All;
                    Editable = IsAvailableEditable;
                }
            }
        }
    }
    var
        myInt: Integer;
        IsAvailableEditable: Boolean;

    trigger OnAfterGetRecord()
    var
        FiveYearsAgo: Date;
    begin
        FiveYearsAgo := CalcDate('-5Y', WorkDate);
        if Rec.Procured_Date < FiveYearsAgo then begin
            IsAvailableEditable := false;
            Rec.Available_Asset := false;
        end else begin
            IsAvailableEditable := true;
            Rec.Available_Asset := true;
        end;
    end;
}