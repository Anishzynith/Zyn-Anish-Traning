codeunit 50133 "ZYN_CompanySyncControl"
{
    Subtype = Normal;

    var
        SyncInProgress: Boolean;

    procedure IsInProgress(): Boolean
    begin
        exit(SyncInProgress);
    end;

    procedure SetInProgress(NewValue: Boolean)
    begin
        SyncInProgress := NewValue;
    end;
}