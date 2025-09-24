page 50174 ZYN_Subscriber_Card
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZYN_Subscriber_Table;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(ID; Rec.ID)
                { }
                field(Customer_No; Rec.Customer_No)
                { }
                field(Plan_ID; Rec.Plan_ID)
                { }
                field(start_Date; Rec.start_Date)
                { }
                field(End_Date; Rec.End_Date)
                { }
                field(Subscriber_Status; Rec.Subscriber_Status)
                { }
                field(Next_Bill_Date; Rec.Next_Bill_Date)
                { }
            }
        }
    }
}