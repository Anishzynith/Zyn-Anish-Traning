page 50133 Income_Category_Page
{
    PageType = Card;
    //  ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Income_Category_Table;

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
        
    }

}