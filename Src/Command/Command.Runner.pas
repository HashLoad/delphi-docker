unit Command.Runner;

interface

uses
  DOSCommand, OpenToolApi.CommandMessage;

procedure Runner(ACommand, APath: string; ALoadPackages: Boolean);

implementation

uses
  System.SysUtils;

procedure Runner(ACommand, APath: string; ALoadPackages: Boolean);
var
  LDosCommand: TDosCommand;
begin
  LDosCommand := TDosCommand.Create(nil);
  try
    LDosCommand.OnNewLine := procedure(ASender: TObject; const ANewLine: string; AOutputType: TOutputType)
      begin
        TCommandMessage.GetInstance.WriteLn(ANewLine);
      end;

    LDosCommand.InputToOutput := False;
    LDosCommand.CurrentDir := APath;
    LDosCommand.CommandLine := GetEnvironmentVariable('COMSPEC');
    LDosCommand.Execute;
    LDosCommand.SendLine(ACommand, False);
    LDosCommand.SendLine(#13, False);
    LDosCommand.SendLine('', True);
  finally

  end;
end;

end.
