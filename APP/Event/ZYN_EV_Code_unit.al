codeunit 50128 MyScbscribers
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"MyPublishers", 'OnAfterNewCustomerCreated', '', true, true)]
    procedure CheckCustomerNameOnAfterNewCustomerCreated(line: Text[50])
    begin
        Message('New Customer %1 has been Created', line);
    end;
}