pageextension 50135 MyCustomerext extends "Customer Card"
{
  

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


 