pageextension 50114 ZYN_ModifypageExt extends "Customer Card"
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
                RunObject = page ZYN_ModifyList;
            }
        }
    }
}
