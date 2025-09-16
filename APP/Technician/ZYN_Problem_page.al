pageextension 50117 Problem_pageext extends "Customer Card"
{
    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action(Problem)
            {
                Caption = 'Problem';
                image = Report;
                ApplicationArea = all;
                // RunObject = page ProblemCard;
                trigger OnAction()
                var
                    cusRec: Record customer;
                    problemRec: Record ProblemTable;
                begin
                    cusRec.get(Rec."No.");
                    problemRec.Init();
                    problemRec."CustomerID" := cusRec."No.";
                    problemRec."CustomerName" := cusRec.Name;
                    problemRec.Insert(true);
                    PAGE.Run(Page::ProblemCard, problemRec)
                end;
            }
        }
    }
}

