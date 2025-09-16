codeunit 50145 compchangepublisher
{
    [IntegrationEvent(false, false)]
    procedure onaddcustomercreated("customer rec": Record Customer)
    begin
    end;
}
codeunit 50116 compchangesubs
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::compchangepublisher, 'onaddcustomercreated', '', false, false)]
    local procedure OnCustomerCreated("customer rec": Record Customer)
    var
        TargetCustomer: Record Customer;
        CompanyName: Text;
    begin
        CompanyName := 'ANISH';
        if TargetCustomer.ChangeCompany(CompanyName) then begin
            if not TargetCustomer.Get("customer rec"."No.") then begin
                TargetCustomer.Init();
                TargetCustomer.TransferFields("customer rec");
                TargetCustomer.Insert();
            end;
        end else
            Error('Unable to access target company: %1', CompanyName);
    end;
}