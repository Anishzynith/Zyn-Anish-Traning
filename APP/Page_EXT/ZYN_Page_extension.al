pageextension 50123 ZYN_CustomerCardExt extends "Customer Card"
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
                RunObject = page "ZYN_VisitorSource";
                RunPageLink = "CustomerNo" = field("No.");
            }
        }
    }
}