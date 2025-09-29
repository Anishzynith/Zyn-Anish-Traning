page 50182 ZYN_Company_Page
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'ZYN_Company';
    SourceTable = ZynithCompany;
    Permissions = tabledata "Company Information" = r;
    RefreshOnActivate = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Rec.Name)
                {
                }
                field("Display Name"; Rec."Display Name")
                {
                }
                field(IS_Master; Rec.IS_Master)
                {
                }
                field(Master_Company; Rec.Master_Company_Name)
                {
                }
            }
        }
    }
}