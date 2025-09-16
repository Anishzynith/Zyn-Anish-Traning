pageextension 50114 ModifypageExt extends "Customer Card"
{
    actions
    {
        addfirst(processing)
        {
            action(Modify)
            {
                ApplicationArea = All;
                Caption = 'Modify';
                Image = EditLines;
                RunObject = page "modifyList";
            }
        }
    }
}
