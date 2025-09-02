

pageextension 50123 CustomerCardExt extends "Customer Card"
{
    actions
    {
        addlast(processing)  //navigation is aslo works but in related section it will show
        {
            action(VisitLog)
            {
                ApplicationArea = All;
                Caption = 'Visit Log';
                Image = View;
                RunObject = page "VisitorSource";
                RunPageLink = "CustomerNo" = field("No.");
                // trigger OnAction()
                // begin
                //     Page.Run(Page::"VisitorSource");//list page
                // end;
            }
        }
    }
}