page 50157 Company_Asset_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Company_Asset_Table;
    CardPageId = Company_Asset_Card;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
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

        area(Factboxes)
        {
            part(AssetSummaryFactBox; Company_Asset_FactBox)
            {
                ApplicationArea = All;
            }
        }


    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
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