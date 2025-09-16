pageextension 50106 CompanyPageExt extends Companies
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
                RunObject = page "updatefieldcard";
            }
        }
    }
}