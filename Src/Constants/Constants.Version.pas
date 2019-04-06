unit Constants.Version;

interface

type

  TVersion = class
  private
    FName: string;
    FSemantic: string;
    class var FInstance: TVersion;
  public
    class function GetInstance: TVersion;
    class procedure Release;
    property Name: string read FName write FName;
    property Semantic: string read FSemantic write FSemantic;
    constructor Create;
  end;

implementation

{ TVersion }

constructor TVersion.Create;
begin
  // {$IFDEF CONDITIONALEXPRESSIONS}
{$IFDEF VER330}
  FName := 'Rio';
  FSemantic := '10.3.0';
{$ENDIF}
{$IFDEF VER331}
  FName := 'Rio';
  FSemantic := '10.3.1'
{$ENDIF}
  // {$IF RTLVersion >= 14.0}
  // {$DEFINE HAS_ERROUTPUT}
  // {$IFEND}
  // {$ENDIF}
  // end;
end;

class function TVersion.GetInstance: TVersion;
begin
  if not Assigned(FInstance) then
    FInstance := TVersion.Create;

  Result := FInstance;
end;

class procedure TVersion.Release;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

initialization

finalization

TVersion.Release;

end.
