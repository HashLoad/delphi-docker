unit OpenToolApi.ToolBarItem;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TToolBarItem = class(TDataModule)
    ImageListDocker: TImageList;
  private
    FImageStartIndex: Integer;
    class var FInstance: TToolBarItem;
  public
    class function GetInstance: TToolBarItem;
    class procedure RunWithDocker(ASender: TObject);
    class procedure Release;
    constructor Create; reintroduce;
  end;

implementation

uses
  ToolsAPI, Vcl.Dialogs, Wrapper.DockerCompose, UtilityFunctions, Wrapper.Docker;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TToolBarItem.Create;
begin
  inherited Create(nil);
  FImageStartIndex := NativeServices.AddImages(ImageListDocker, 'docker');
end;

class function TToolBarItem.GetInstance: TToolBarItem;
begin
  if not Assigned(FInstance) then
    FInstance := TToolBarItem.Create;

  Result := FInstance;
end;

class procedure TToolBarItem.Release;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

class procedure TToolBarItem.RunWithDocker(ASender: TObject);
var
  LDebugger: IOTADebuggerServices;
  LMainMenu: TMainMenu;
  LMenuItem: TMenuItem;
begin
  if not DoDockerPreFlight then
    Exit;




  if not DockerComposeUp(ExtractFilePath(ActiveProject.FileName)) then
  begin
    MessageDlg('Can''t start docker compose or docker not started, verify output messages.',
      TMsgDlgType.mtError,
      [TMsgDlgBtn.mbOK],
      1);
    Exit;
  end;

  LMainMenu := NativeServices.MainMenu;

  LMenuItem := LMainMenu.Items.Find('Run').Find('Run');
  if Assigned(LMenuItem) then
    LMenuItem.Action.Execute;

end;

initialization

finalization

TToolBarItem.Release;

end.
