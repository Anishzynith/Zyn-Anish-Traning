// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

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
