unit Docker.RunWithDocker;

interface

uses
  UtilityFunctions, SysUtils;

type
  TRunWithDocker = class
  const
    COMMAND_ERROR = 1;
    COMMAND_SUCESS = 0;
  public
    procedure Execute;
  end;

implementation

uses
  Vcl.Dialogs, Command.Runner, Constants.Version, System.Classes;

{ TRunWithDocker }

procedure TRunWithDocker.Execute;
var
  LLine, LContainerVersion, LContainerName: string;
  LReturn: TRunnerReturn;
  LPAServerPort: Integer;
  LHasPAServerPort: Boolean;
  LPorts: TArray<string>;
begin
  if not(ActiveProject.CurrentPlatform = 'Linux64') then
    raise Exception.Create('Plataform not suported');

  LContainerVersion := TVersion.GetInstance.Semantic + '-' + TVersion.GetInstance.Name;
  LContainerName := ExtractFileName(ActiveProject.FileName).Split(['.'])[0] + '_' + LContainerVersion;

  LReturn := Runner('docker start ' + LContainerName);

  if LReturn.ExitCode = COMMAND_ERROR then
    LReturn := Runner('docker run -tP --name ' + LContainerName + ' hashload/delphi-dev:' +
      LContainerVersion);

  if LReturn.ExitCode = COMMAND_SUCESS then
  begin
    LReturn := Runner('docker ps --filter name=teste_10.3.0-rio --format "{{.Ports}}"');

    LPorts := LReturn.Output.Split([',']);
    for LLine in LPorts do
    begin
      LHasPAServerPort := False;
      if LLine.Contains('->64211/tcp') then
      begin
        LPAServerPort := LLine.Substring(LLine.IndexOf(':') + 1, LLine.IndexOf('->') - LLine.IndexOf(':') - 1)
          .ToInteger;
        LHasPAServerPort := True;
        Break;
      end;
    end;

    if not LHasPAServerPort then
      raise Exception.Create('PAServer not found');
  end;

  if LReturn.ExitCode = COMMAND_ERROR then
    raise Exception.Create(LReturn.Output);

  ShowMessage('Version ' + TVersion.GetInstance.Semantic);
end;

end.
