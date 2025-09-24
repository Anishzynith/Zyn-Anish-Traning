pageextension 50139 "ZYN_My RoleCenter Ext" extends "Business Manager Role Center"
{
    layout
    {
        addlast(rolecenter)
        {
            part(SubscriberCues; ZYN_Customer_Page_Fact)
            {
                ApplicationArea = All;
            }
        }
    }
    // Removed OnOpenPage trigger as triggers are not allowed on Role Center pages.
}