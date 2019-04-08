unit Command.Runner;

interface

uses
  DOSCommand, OpenToolApi.CommandMessage, OpenToolApi.Tools, System.Classes;

type
  TRunnerReturn = record
    ExitCode: Integer;
    Output: string;
    constructor Create(AExitCode: Integer; AOutput: string);
  end;

function Runner(APath, ACommand: string): TRunnerReturn; overload;
function Runner(ACommand: string): TRunnerReturn; overload;

implementation

uses
  System.SysUtils, Vcl.Forms;

procedure OnReadLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
begin
  TCommandMessage.GetInstance.WriteLn(ANewLine);
end;

function DoRunner(APath, ACommand: string): TRunnerReturn;
var
  LDosCommand: TDosCommand;
begin
  LDosCommand := TDosCommand.Create(nil);
  try
    TCommandMessage.GetInstance.WriteLn(APath + '>' + ACommand);
    LDosCommand.OnNewLine := OnReadLine;
    LDosCommand.InputToOutput := False;
    LDosCommand.CurrentDir := APath;
    LDosCommand.CommandLine := ACommand;
    LDosCommand.Execute;

    while LDosCommand.IsRunning do
    begin
      Application.ProcessMessages;
    end;

    Result := TRunnerReturn.Create(LDosCommand.ExitCode, LDosCommand.Lines.Text);
  finally
    LDosCommand.Free;
  end;
end;

function Runner(ACommand: string): TRunnerReturn;
begin
  Result := DoRunner(ExtractFilePath(ActiveProject.FileName), ACommand);
end;

function Runner(APath, ACommand: string): TRunnerReturn;
begin
  Result := DoRunner(APath, ACommand);
end;

{ TRunnerReturn }

constructor TRunnerReturn.Create(AExitCode: Integer; AOutput: string);
begin
  ExitCode := AExitCode;
  Output := AOutput;
end;

end.
