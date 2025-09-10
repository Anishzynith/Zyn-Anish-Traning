pageextension 50139 "My RoleCenter Ext" extends "Business Manager Role Center"
{
    layout
    {
        addlast(rolecenter)
        {
            part(SubscriberCues; Customer_Page_Fact)
            {
                ApplicationArea = All;
            }


        }

    }
    // Removed OnOpenPage trigger as triggers are not allowed on Role Center pages.
}