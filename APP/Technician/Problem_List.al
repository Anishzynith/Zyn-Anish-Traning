page 50119 "ProblemList"
{
    PageType = Listpart;
    SourceTable = "ProblemTable";
    CardPageId = "ProblemCard";
    ApplicationArea = all;
    Caption = 'Problem List';

    // InsertAllowed = false;
    // DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
