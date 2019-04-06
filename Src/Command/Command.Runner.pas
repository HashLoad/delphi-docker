unit Command.Runner;

interface

uses
  DOSCommand, OpenToolApi.CommandMessage;

function Runner(APath, ACommand: string): Integer; overload;
function Runner(ACommand: string): Integer; overload;

implementation

uses
  System.SysUtils, Vcl.Forms;

var
  FMonitorLock: TObject;

function DoRunner(APath, ACommand: string): Integer;
var
  LDosCommand: TDosCommand;
begin
//System.TMonitor.Enter(FMonitorLock);
  try
    LDosCommand := TDosCommand.Create(nil);
    try
//      LDosCommand.InputToOutput := False;
      LDosCommand.CurrentDir := APath;
      LDosCommand.CommandLine := ACommand;
      LDosCommand.Execute;

      while LDosCommand.IsRunning do
      begin
        Application.ProcessMessages;
      end;

      Result := LDosCommand.ExitCode;
    finally
      LDosCommand.Free;
    end;
  finally
//    System.TMonitor.Exit(FMonitorLock);
  end;
end;

function Runner(ACommand: string): Integer;
begin
  Result := DoRunner('C:/', ACommand);
end;

function Runner(APath, ACommand: string): Integer;
begin
  Result := DoRunner(APath, ACommand);
end;

end.
