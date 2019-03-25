unit DelphiDocker.Register;

interface

uses
  ToolsAPI, Vcl.ComCtrls, DelphiDocker.LocalMenuItem;

procedure Register;

implementation

uses
  DelphiDocker.Images;

procedure AddLocalMenuDocker;
var
  LNotifierMenuIndex: Integer;
begin
  LNotifierMenuIndex := (BorlandIDEServices as IOTAProjectManager).AddMenuItemCreatorNotifier
    (TNotifierLocalMenuItem.Create);
end;

procedure AddToolBarDocker;

end;

procedure Register;
begin
  AddLocalMenuDocker;
  AddToolBarDocker;
end;

end.
