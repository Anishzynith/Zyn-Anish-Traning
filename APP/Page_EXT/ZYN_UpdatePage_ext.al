pageextension 50106 ZYN_CompanyPageExt extends Companies
{
    actions
    {
        addlast(processing)
        {
            action(UpdateField)
            {
                ApplicationArea = All;
                Caption = 'Update Field';
                Image = EditLines;
                RunObject = page ZYN_updatefieldcard;
            }
        }
    }
}