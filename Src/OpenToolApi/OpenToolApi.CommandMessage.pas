unit OpenToolApi.CommandMessage;

interface

uses
  ToolsAPI;

type
  TCommandMessage = class
    FService: IOTAMessageServices;
    FGroup: IOTAMessageGroup;
  private
    class var FInstance: TCommandMessage;
  public
    class function GetInstance: TCommandMessage;
    class procedure Release;
    Procedure Initialize(AService: IOTAMessageServices);
    procedure WriteLn(ALine: string);
    procedure Clear;
  end;

implementation

procedure TCommandMessage.Clear;
begin
  FService.ClearMessageGroup(FGroup);
end;

class procedure TCommandMessage.Release;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

class function TCommandMessage.GetInstance: TCommandMessage;
begin
  if not Assigned(FInstance) then
    FInstance := TCommandMessage.Create;
  Result := FInstance;
end;

procedure TCommandMessage.Initialize(AService: IOTAMessageServices);
begin
  FService := AService;
  FGroup := FService.AddMessageGroup('Docker');

  FGroup.AutoScroll := True;
  FGroup.CanClose := False;
  FService.AddTitleMessage('Docker initialized..', FGroup);
end;

procedure TCommandMessage.WriteLn(ALine: string);
begin
  FService.ShowMessageView(FGroup);
  FService.AddTitleMessage(ALine, FGroup);
end;

initialization

finalization
  TCommandMessage.Release;

end.
