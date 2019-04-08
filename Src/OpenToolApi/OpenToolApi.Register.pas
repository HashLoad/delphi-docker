unit OpenToolApi.Register;

interface

uses
  ToolsAPI, Vcl.ComCtrls, OpenToolApi.LocalMenuItem, OpenToolApi.CommandMessage, OpenToolApi.MenuItem;

procedure Register;

implementation

uses
  Vcl.ActnList, Vcl.Menus;

procedure AddLocalMenuDocker;
var
  LNotifierMenuIndex: Integer;
begin
  LNotifierMenuIndex := (BorlandIDEServices as IOTAProjectManager).AddMenuItemCreatorNotifier
    (TNotifierLocalMenuItem.Create);
end;

procedure AddMenuItemDocker;
var
  LMenuItem: TDockerMenuItem;
begin
  LMenuItem := TDockerMenuItem.Create;
  try
    LMenuItem.AddMenuItem;
  finally
    LMenuItem.Free;
  end;
end;

procedure AddCommandMessage;
var
  LMessageServices: IOTAMessageServices;
begin
  LMessageServices := (BorlandIDEServices as IOTAMessageServices);
  TCommandMessage.GetInstance.Initialize(LMessageServices);
end;

procedure Register;
begin
  AddLocalMenuDocker;
  AddMenuItemDocker;
  AddCommandMessage;
end;

end.
