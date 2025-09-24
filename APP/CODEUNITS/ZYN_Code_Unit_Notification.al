codeunit 50114 "ZYN_Notification Handler"
{
    Subtype = Normal;
    procedure OpenLeaveRequest(Notif: Notification)
    var
        LeaveReq: Record ZYN_Leave_Request_Table;
        LeaveIDTxt: Text;
        LeaveID: Integer;
    begin
        // Read LeaveID from notification
        LeaveIDTxt := Notif.GetData('LeaveID');
        if not Evaluate(LeaveID, LeaveIDTxt) then
            Error('Invalid Leave ID: %1', LeaveIDTxt);
        // Find leave request record
        if LeaveReq.Get(LeaveID) then
            Page.Run(Page::ZYN_Leave_Request_Page, LeaveReq) // Change page name/ID if needed
        else
            Error('Leave request %1 not found.', LeaveID);
    end;
}
