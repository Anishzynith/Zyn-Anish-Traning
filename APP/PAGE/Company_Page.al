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
                field("Evaluation Company"; Rec."Evaluation Company")
                {
                }
                field("Display Name"; Rec."Display Name")
                {
                }
                field(Id; Rec.Id)
                {
                }
                field("Business Profile Id"; Rec."Business Profile Id")
                {
                }
            }
        }
    }
}