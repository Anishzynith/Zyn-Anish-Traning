page 50118 ProblemCard
{
    PageType = Card;
    SourceTable = ProblemTable;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            group(general)
            {
                field(EntryNO; Rec.EntryNO)
                {
                    Caption = 'EntryNo';
                }
                field(CustomerID; Rec.CustomerID)
                {
                    Caption = 'CustomerID';
                }
                field(CustomerName; Rec.CustomerName)
                {
                    Caption = 'CustomerName';
                }
                field(Issue; Rec.Issue)
                {
                    Caption = 'Issue';
                    // Editable = true;
                }
                field(Issuse_Department; Rec.Issuse_Department)
                {
                    Caption = 'Issue Departmwnt';
                    // Editable = true;
                }
                field(Technician_Name; Rec.Technician_Name)
                {
                    Caption = 'Technician Name';
                    // Editable = true;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    // Editable = true;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                }
            }
        }
    }
}