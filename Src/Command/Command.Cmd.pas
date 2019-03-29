unit Command.Cmd;

interface

uses
  DosCommand;

type
  TCommandCmd = class
  private
  class var
    FInstance: TCommandCmd;
    FDosCommand: TDosCommand;

    procedure OnReadLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);

    constructor Create;
    class procedure Release;
  public

    procedure Run(ACommand, APath: string);
    class function GetInstance: TCommandCmd;
    destructor Destroy; override;

  end;

implementation

uses
  OpenToolApi.CommandMessage;

{ TCommandCmd }

constructor TCommandCmd.Create;
begin
  FDosCommand := TDosCommand.Create(nil);
  FDosCommand.OnNewLine := OnReadLine;
end;

destructor TCommandCmd.Destroy;
begin
  FDosCommand.Stop;
  inherited;
end;

class function TCommandCmd.GetInstance: TCommandCmd;
begin
  if not Assigned(FInstance) then
    FInstance := TCommandCmd.Create;

  result := FInstance;
end;

procedure TCommandCmd.OnReadLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
begin
  TCommandMessage.GetInstance.WriteLn(ANewLine);
end;

class procedure TCommandCmd.Release;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

procedure TCommandCmd.Run(ACommand, APath: string);
begin
  FDosCommand.Stop;
  FDosCommand.CommandLine := ACommand;
  FDosCommand.CurrentDir := APath;
  FDosCommand.Execute;
end;

initialization

finalization

TCommandCmd.Release;

end.
