unit Docker.RunWithDocker;

interface

uses
  OpenToolApi.Tools, SysUtils, ToolsAPI;

type
  TRunWithDocker = class
  const
    COMMAND_ERROR = 1;
    COMMAND_SUCESS = 0;
  public
    procedure Execute(AProject: IOTAProject);
  end;

implementation

uses
  Vcl.Dialogs, Command.Runner, Constants.Version, System.Classes, Vcl.Menus;

{ TRunWithDocker }

procedure TRunWithDocker.Execute(AProject: IOTAProject);
var
  LReturn: TRunnerReturn;
  LMainMenu: TMainMenu;
  LMenuItem: TMenuItem;
begin
  ProjectGroup.ActiveProject := AProject;

  if not(ActiveProject.CurrentPlatform = 'Linux64') then
    raise Exception.Create('Plataform not suported');

  LReturn := Runner('docker-compose up -d');

  if LReturn.ExitCode = COMMAND_SUCESS then
  begin
    LMainMenu := NativeServices.MainMenu;

    LMenuItem := LMainMenu.Items.Find('Run').Find('Run');
    if Assigned(LMenuItem) then
      LMenuItem.Action.Execute;
  end
  else
    raise Exception.Create(LReturn.Output);
end;

end.
