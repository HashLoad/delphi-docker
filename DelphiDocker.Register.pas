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
 var
 LToolButton: TToolButton;
 LToolBarItem: TToolBar;
begin
   DataModuleImages := TDataModuleImages.Create(nil);
   LToolBarItem := (BorlandIDEServices as INTAServices).ToolBar[sDebugToolBar];
   LToolButton := TToolButton.Create(LToolBarItem);
   LToolButton.Caption := 'Run With Docker';
   LToolButton.Parent := LToolBarItem;
   LToolButton.ImageIndex := (BorlandIDEServices as INTAServices).AddImages(DataModuleImages.ImageList1, 'docker');
end;

procedure Register;
begin
  AddLocalMenuDocker;
  AddToolBarDocker;
end;

end.
