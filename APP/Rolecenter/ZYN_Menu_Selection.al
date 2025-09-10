page 50170 ANISH_RoleCenter
{
    PageType = RoleCenter;
    ApplicationArea = all;
    Caption = 'ANISH Role Center';

    layout
    {
        area(RoleCenter)
        {
            // group(Asset_Management) // This replaces Finance with Asset Management
            // {
            //     Caption = 'Asset Management';

            //     part(AssetPagePart; Asset_Page) // Replace with your actual page ID
            //     {
            //         ApplicationArea = All;
            //     }
            // }
        }
    }

    actions
    {

        area(Sections)
        {
            group(Asset)
            {
                action(Asset_Page)
                {
                    RunObject = Page Asset_Page;
                    ApplicationArea = all;
                }
                action(Company_Asset_Page)
                {
                    RunObject = page Company_Asset_Page;
                }
                action(Employee_Asset_Page)
                {
                    RunObject = page Employee_Asset_Page;
                }

            }
            group(Leave_Request)
            {
                action(Employee_Page)
                {
                    RunObject = page Employee_Page;
                }
                action(Leave_Request_Page)
                {
                    RunObject = page Leave_Request_Page;
                }
                action(Leave_Category_Page)
                {
                    RunObject = page Leave_Category_Page;
                }
            }
            group(Expense)
            {
                action(Expense_Page)
                {
                    RunObject = page Expense_Tracker_Page;
                }
                action(Expense_Category_Page)
                {
                    RunObject = page Expense_Category_Page;
                }
                action(Expense_Budget_List_Page)
                {
                    RunObject = page ExpenseBudget_ListPage;
                }
                action(Recurring_Expense_Page)
                {
                    RunObject = page Recurring_Expense_ListPage;
                }
            }
            group(Income)
            {
                action(Income_Page)
                {
                    RunObject = page Income_Tracker_Page;
                }
                action(Income_Category_Page)
                {
                    RunObject = page Income_Category_ListPage;
                }
            }
            group(Contact)
            {
                action(Contacts)
                {
                    RunObject = page "Contact List";
                }
            }
            group(Customer)
            {
                action(Customer_List)
                {
                    RunObject = page Customer_List_New;
                }
            }
            group(Technician)
            {
                action(Problem_List)
                {
                    RunObject = page ProblemList;
                }
                action(Tech_List)
                {
                    RunObject = page TechnicianList;
                }
            }

        }

    }
}