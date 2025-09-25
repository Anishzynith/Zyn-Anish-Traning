page 50160 ZYN_Employee_Asset_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Employee_Table;
    Caption = 'ZYN Employee Asset Card';
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Employee_ID; Rec.Employee_ID)
                {
                    Caption = 'Employee ID';
                    ToolTip = 'Enter Employee ID';
                }
                field(Serial_NO; Rec.Serial_NO)
                {
                    Caption = 'Serial No.';
                    ToolTip = 'Enter Serial No.';
                }
                field(Asset_Status; Rec.Asset_Status)
                {
                    Caption = 'Asset Status';
                    ToolTip = 'Select Asset Status';
                }
                field(Assigned_Date; Rec.Assigned_Date)
                {
                    Editable = IsAssignedEditable;
                    Caption = 'Assigned Date';
                    ToolTip = 'Enter Assigned Date';
                }
                field(Returned_Date; Rec.Returned_Date)
                {
                    Editable = IsReturnedEditable;
                    Caption = 'Returned Date';
                    ToolTip = 'Enter Returned Date';
                }
                field(Lost_Date; Rec.Lost_Date)
                {
                    Editable = IsLostEditable;
                    Caption = 'Lost Date';
                    ToolTip = 'Enter Lost Date';
                }
                field(Asset_Type; Rec.Asset_Type)
                {
                    Caption = 'Asset Type';
                    ToolTip = 'Enter Asset Type';
                }
            }
        }
    }
    var
        myInt: Integer;

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
                    //IsLostEditable := true;
                end;
            ZYN_Asset_Status_Enum::Lost:
                begin
                    IsAssignedEditable := true;
                    IsLostEditable := true;
                end;
        end;
    end;
}