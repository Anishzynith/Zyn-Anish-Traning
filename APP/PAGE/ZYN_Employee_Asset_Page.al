page 50159 ZYN_Employee_Asset_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZYN_Employee_Table;
    CardPageId = ZYN_Employee_Asset_Card;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Employee_ID; Rec.Employee_ID)
                { }
                field(Serial_NO; Rec.Serial_NO)
                { }
                field(Asset_Status; Rec.Asset_Status)
                { }
                field(Assigned_Date; Rec.Assigned_Date)
                {
                    Editable = IsAssignedEditable;
                }
                field(Returned_Date; Rec.Returned_Date)
                {
                    Editable = IsReturnedEditable;
                }
                field(Lost_Date; Rec.Lost_Date)
                {
                    Editable = IsLostEditable;
                }
                field(Asset_Type; Rec.Asset_Type)
                { }
                field(Asset_ID; Rec.Asset_ID)
                { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetEditableFields();
    end;

    trigger OnAfterGetRecord()
    begin
        SetEditableFields();
    end;

    var
        IsAssignedEditable: Boolean;
        IsReturnedEditable: Boolean;
        IsLostEditable: Boolean;

    procedure SetEditableFields()
    begin
        IsAssignedEditable := false;
        IsReturnedEditable := false;
        IsLostEditable := false;
        case Rec.Asset_Status of
            ZYN_Asset_Status_Enum::Assigned:
                begin
                    IsAssignedEditable := true;
                    IsReturnedEditable := true;
                    IsLostEditable := true;
                end;
            ZYN_Asset_Status_Enum::Returned:
                begin
                    IsAssignedEditable := true;
                    IsReturnedEditable := true;
                end;
            ZYN_Asset_Status_Enum::Lost:
                begin
                    IsAssignedEditable := true;
                    IsLostEditable := true;
                end;
        end;
    end;
}
