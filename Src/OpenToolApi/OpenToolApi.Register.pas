unit OpenToolApi.Register;

interface

uses
  ToolsAPI, Vcl.ComCtrls, OpenToolApi.LocalMenuItem, OpenToolApi.CommandMessage,
  OpenToolApi.ToolBarItem;

procedure Register;

implementation

uses
  OpenToolApi.Events, Vcl.ActnList, Vcl.Menus, UtilityFunctions;

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
  LAction: TAction;
  LMenuItem: TMenuItem;
begin
  LServices := (BorlandIDEServices as INTAServices);
  LServices.MenuBeginUpdate;
  try
    LServices.AddImages(TToolBarItem.GetInstance.ImageListDocker);

    UtilityFunctions.CreateMenuItem('RunWithDocker', 'Run With Docker', 'Run',
      TToolBarItem.GetInstance.RunWithDocker, nil,
      False, True, 'Alt+F9');

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
  AddLocalMenuDocker;
  AddToolBarDocker;
  AddCommandMessage;
end;

end.
