unit OpenToolApi.ToolBarItem;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TToolBarItem = class(TDataModule)
    ImageListDocker: TImageList;
    ActionListDocker: TActionList;
    ToolBarItemDocker: TAction;
    MainMenuDocker: TMainMenu;
    Este21: TMenuItem;
    procedure ActionListDockerExecute(Action: TBasicAction; var Handled: Boolean);
    procedure ActionListDockerUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    class var FInstance: TToolBarItem;
  public
    class function GetInstance: TToolBarItem;
    class procedure teste(ASender:TObject);
    class procedure Release;
    constructor Create; reintroduce;
  end;

implementation

uses
  ToolsAPI, Vcl.Dialogs, Wrapper.DockerCompose, UtilityFunctions;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TToolBarItem.ActionListDockerExecute(Action: TBasicAction; var Handled: Boolean);
begin
  ShowMessage('Rodando com docker');
end;

procedure TToolBarItem.ActionListDockerUpdate(Action: TBasicAction; var Handled: Boolean);
begin
//  ShowMessage('Update');
end;

constructor TToolBarItem.Create;
begin
  inherited Create(nil);
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

class procedure TToolBarItem.teste(ASender: TObject);
var
 LDebugger: IOTADebuggerServices;
begin
  DockerComposeUp(ExtractFilePath(ActiveProject.FileName));

  ActiveProject.ProjectBuilder.BuildProject(TOTACompileMode.cmOTABuild, True, True);

//  (BorlandIDEServices as IOTADebuggerServices).CreateProcess('E:\Projetos\_playground\dosCommandTest\Win32\Debug\Project3.exe', '');
end;

initialization

finalization

TToolBarItem.Release;

end.
