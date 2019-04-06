unit Command.Runner;

interface

uses
  DOSCommand, OpenToolApi.CommandMessage;

function Runner(ACommand, APath: string): Cardinal;

implementation

uses
  System.SysUtils, Vcl.Forms;

var
  FMonitorLock: TObject;

function Runner(ACommand, APath: string): Cardinal;
var
  LDosCommand: TDosCommand;
begin
  System.TMonitor.Enter(FMonitorLock);
  try
    LDosCommand := TDosCommand.Create(nil);
    try
      LDosCommand.InputToOutput := False;
      LDosCommand.CurrentDir := APath;
      LDosCommand.CommandLine := ACommand;
      LDosCommand.Execute;

      while LDosCommand.IsRunning do
      begin
        Application.ProcessMessages;
        Sleep(0);
      end;

      Result := LDosCommand.ExitCode

    finally
      LDosCommand.Free;
    end;
  finally
    System.TMonitor.Exit(FMonitorLock);
  end;
end;

end.
