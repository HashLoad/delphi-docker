unit Command.Runner;

interface

uses
  DOSCommand, OpenToolApi.CommandMessage;

function Runner(ACommand, APath: string): Cardinal;

implementation

uses
  System.SysUtils, Vcl.Forms;

function Runner(ACommand, APath: string): Cardinal;
var
  LDosCommand: TDosCommand;
begin
  LDosCommand := TDosCommand.Create(nil);
  try
    LDosCommand.OnNewLine := procedure(ASender: TObject; const ANewLine: string; AOutputType: TOutputType)
      begin
//        TCommandMessage.GetInstance.WriteLn(ANewLine);
      end;

    LDosCommand.OnTerminated := procedure(ASender: TObject)
      begin
//        ASender.Free;
      end;

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
end;



end.
