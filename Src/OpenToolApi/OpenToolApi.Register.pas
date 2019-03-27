unit OpenToolApi.Register;

interface

uses
  ToolsAPI, Vcl.ComCtrls, OpenToolApi.LocalMenuItem, OpenToolApi.CommandMessage,
  OpenToolApi.ToolBarItem;

procedure Register;

implementation

procedure AddLocalMenuDocker;
var
  LNotifierMenuIndex: Integer;
begin
  LNotifierMenuIndex := (BorlandIDEServices as IOTAProjectManager).AddMenuItemCreatorNotifier
    (TNotifierLocalMenuItem.Create);
end;

procedure AddToolBarDocker;
var
  LServices: INTAServices;
begin
  LServices := (BorlandIDEServices as INTAServices);
  LServices.MenuBeginUpdate;
  try
    LServices.NewToolbar('Docker', 'Docker');
    LServices.AddToolButton('Docker', 'DockerWithDocker', TToolBarItem.GetInstance.ToolBarItemDocker);
  finally
    LServices.MenuEndUpdate;
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
  // AddLocalMenuDocker;
  AddToolBarDocker;
  // AddCommandMessage;
end;

end.
