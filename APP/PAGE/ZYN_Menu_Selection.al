page 50170 ZYN_ANISH_RoleCenter
{
    PageType = RoleCenter;
    ApplicationArea = all;
    Caption = 'ANISH Role Center';
    layout
    {
        area(RoleCenter)
        {
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
                    RunObject = Page ZYN_Asset_Page;
                    ApplicationArea = all;
                }
                action(Company_Asset_Page)
                {
                    RunObject = page ZYN_Company_Asset_Page;
                }
                action(Employee_Asset_Page)
                {
                    RunObject = page ZYN_Employee_Asset_Page;
                }
            }
            group(Leave_Request)
            {
                action(Employee_Page)
                {
                    RunObject = page ZYN_Employee_Page;
                }
                action(Leave_Request_Page)
                {
                    RunObject = page ZYN_Leave_Request_Page;
                }
                action(Leave_Category_Page)
                {
                    RunObject = page ZYN_Leave_Category_Page;
                }
            }
            group(Expense)
            {
                action(Expense_Page)
                {
                    RunObject = page ZYN_Expense_Tracker_Page;
                }
                action(Expense_Category_Page)
                {
                    RunObject = page ZYN_Expense_Category_Page;
                }
                action(Expense_Budget_List_Page)
                {
                    RunObject = page ZYN_ExpenseBudget_ListPage;
                }
                action(Recurring_Expense_Page)
                {
                    RunObject = page ZYN_Recurring_Expense_ListPage;
                }
            }
            group(Income)
            {
                action(Income_Page)
                {
                    RunObject = page ZYN_Income_Tracker_Page;
                }
                action(Income_Category_Page)
                {
                    RunObject = page ZYN_Income_Category_ListPage;
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
                    RunObject = page ZYN_Customer_List_New;
                }
            }
            group(Technician)
            {
                action(Problem_List)
                {
                    RunObject = page "ZYN_ProblemList";
                }
                action(Tech_List)
                {
                    RunObject = page "ZYN_TechnicianList";
                }
            }
        }
    }
}