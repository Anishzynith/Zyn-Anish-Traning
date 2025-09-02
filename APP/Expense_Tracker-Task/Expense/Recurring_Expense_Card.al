page 50147 Recurring_Expense_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Recurring_Expense_Table;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Recurring_Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Recurring_Amount; Rec.Recurring_Amount)
                {
                    ApplicationArea = All;
                }
                field(Recurring_Cycle; Rec.Recurring_Cycle)
                {
                    ApplicationArea = All;
                }
                field(Start_Date; Rec.Start_Date)
                {
                    ApplicationArea = All;
                }
                field(Next_Cycle_Date; Rec.Next_Cycle_Date)
                {
                    ApplicationArea = All;

                }
            }
        }


        // actions
        // {
        //     area(Processing)
        //     {
        //         action(ActionName)
        //         {

        //             trigger OnAction()
        //             begin

        //             end;
        //         }
        //     }
        //}

    }
}