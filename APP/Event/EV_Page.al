pageextension 50135 MyCustomerext extends "Customer Card"
{
    /*  layout
      {
          modify(Name)
          {
              trigger OnAfterValidate();
              var
                  Publisher: Codeunit MyPublishers;
              begin
                  Publisher.OnAfterNewCustomerCreated(Rec.Name);
              end;
          }*/

    var
        IsNewCustomer: Boolean;

    trigger OnOpenPage()
    begin
        if Rec."No." = '' then
            IsNewCustomer := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsNewCustomer and (Rec.Name = '') then begin
            Message('Please enter a customer name before closing the page.');
            exit(false); // prevent closing
        end;

        exit(true); // allow closing
    end;

      trigger OnClosePage()
    var
        Publisher: Codeunit MyPublishers;
    begin
        if IsNewCustomer and (Rec.Name <> '') then
            Publisher.OnAfterNewCustomerCreated(Rec.Name);
    end;
}


 /*   procedure AddNewCustomer()
    var
        Customer: Record Customer;
    begin
        Customer.Init();
        // Customer."No." := 'CUST001'; // Or use NoSeries
        Customer.Name := 'Contoso Ltd.';
        //Customer."Phone No." := '1234567890';
        // Customer."E-Mail" := 'info@contoso.com';
        Customer.Insert();
    end;

    trigger OnAfterGetRecord()
    var
        Publisher: Codeunit MyPublishers;
    begin
        Publisher.OnAfterNewCustomerCreated(Rec.Name);
    end;
}
*/