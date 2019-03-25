unit OpenToolApi.Register;

interface

uses
  ToolsAPI, Vcl.ComCtrls, OpenToolApi.LocalMenuItem, OpenToolApi.ToolBarItem;

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
  LToolButton: TToolButton;
  LToolBarItem: TToolBar;
begin
  LToolBarItem := (BorlandIDEServices as INTAServices).ToolBar[sDebugToolBar];
  LToolButton := TToolBarItem.Create(LToolBarItem);
  LToolButton.Parent := LToolBarItem;
end;

procedure Register;
begin
  AddLocalMenuDocker;
  AddToolBarDocker;
end;

end.
