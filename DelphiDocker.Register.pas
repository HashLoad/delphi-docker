unit DelphiDocker.Register;

interface

uses
  ToolsAPI, Vcl.ComCtrls, DelphiDocker.LocalMenuItem;

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
// var
// LToolButton: TToolButton;
// LToolBarItem: TToolBar;
begin
  // LToolBarItem := (BorlandIDEServices as INTAServices).ToolBar[sDebugToolBar];
  // LToolButton := TToolButton.Create(LToolBarItem);
  // LToolButton.Caption := 'Run With Docker';
  // LToolButton.
  // LToolButton.Parent := LToolBarItem;
end;

procedure Register;
begin
  AddLocalMenuDocker;
  AddToolBarDocker;
end;

end.
