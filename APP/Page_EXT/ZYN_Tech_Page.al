pageextension 50115 ZYN_PageExt extends "Business Manager Role Center"
{
    actions
    {
        // Add changes to page actions here
        addlast(embedding)
        {
            action(Technician)
            {
                Caption = 'Technician';
                ApplicationArea = all;
                Image = View;
                RunObject = page "ZYN_TechnicianList";
            }
        }
    }
}