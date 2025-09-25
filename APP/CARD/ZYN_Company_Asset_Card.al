page 50158 ZYN_Company_Asset_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Company_Asset_Table;
    Caption = 'ZYN Compoany Asset Card';
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Asset_Type; Rec.Asset_Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Asset Type';
                }
                field(Serial_NO; Rec.Serial_NO)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Serial No';
                }
                field(Procured_Date; Rec.Procured_Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Procured Date';
                }
                field(Vendor_Name; Rec.Vendor_Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Vendor Name';
                }
                field(Available_Asset; Rec.Available_Asset)
                {
                    ApplicationArea = All;
                    Editable = IsAvailableEditable;
                    ToolTip = 'Is Asset Available?';
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