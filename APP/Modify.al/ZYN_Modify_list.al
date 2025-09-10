

namespace DefaultNamespace;

using Microsoft.Sales.Customer;

page 50105 ModifyList
{
    PageType = List;
    SourceTable = ModifyTable;
    Caption = 'Modify List';
    //  CardPageId = "ModifyCard";
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No."; REC."No.")
                {
                    ApplicationArea = All;
                }
                field("Field"; Rec."Field")
                {
                    ApplicationArea = All;
                }
                field("OldValue"; Rec."OldValue")
                {
                    ApplicationArea = All;
                }
                field("NewValue"; Rec."NewValue")
                {
                    ApplicationArea = All;
                }
                field("UserID"; Rec."UserID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
