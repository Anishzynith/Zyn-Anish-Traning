page 50132 ZYN_Income_Category_ListPage
{
    PageType = List;
    ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = ZYN_Income_Category_Table;
    //  Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(IncomeCategory_ID; Rec.IncomeCategory_ID)
                {
                    //  ApplicationArea = All;
                    Caption = 'Category ID';
                }
                field(IncomeCategory_Name; Rec.IncomeCategory_Name)
                {
                    ApplicationArea = All;
                    Caption = 'Category Name';
                }
                field(IncomeDescription; Rec.IncomeDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
            }
        }
        area(FactBoxes)
        {
            part(Income_FactBox; "ZYN_Category Income FactBox")
            {
                Caption = 'Income FactBox';
                SubPageLink = "IncomeCategory_Name" = field("IncomeCategory_Name");
                ApplicationArea = All;
            }
        }
    }
}