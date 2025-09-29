
// codeunit 50116 ZYN_compchangesubs
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::ZYN_compchangepublisher, 'onaddcustomercreated', '', false, false)]
//     local procedure OnCustomerCreated("customer rec": Record Customer)
//     var
//         TargetCustomer: Record Customer;
//         CompanyName: Text;
//     begin
//         CompanyName := 'ANISH';
//         if TargetCustomer.ChangeCompany(CompanyName) then begin
//             if not TargetCustomer.Get("customer rec"."No.") then begin
//                 TargetCustomer.Init();
//                 TargetCustomer.TransferFields("customer rec");
//                 TargetCustomer.Insert();
//             end;
//         end else
//             Error('Unable to access target company: %1', CompanyName);
//     end;
// }