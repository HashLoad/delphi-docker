unit Constants.Version;

interface

uses
  SysUtils, Winapi.Windows;

type

  TSemanticVersion = record
    Major: integer;
    Minor: integer;
    Patch: integer;
    function ToString: string;
    constructor Create(AMajor: integer; AMinor: integer; APatch: integer);
  end;

  TVersion = class
  private
    FName: string;
    FSemantic: string;
    FIDEVersion: TSemanticVersion;
    function GetIDEVersion: TSemanticVersion;
    class var FInstance: TVersion;
  public
    class function GetInstance: TVersion;
    class procedure Release;
    property Name: string read FName write FName;
    property Semantic: string read FSemantic write FSemantic;
    constructor Create;
  end;

implementation

uses
  ToolsAPI;

{ TSemanticVersion }

constructor TSemanticVersion.Create(AMajor, AMinor, APatch: integer);
begin
  Major := AMajor;
  Minor := AMinor;
  Patch := APatch;
end;

function TSemanticVersion.ToString: string;
begin
  Result := Major.ToString + '.' + Minor.ToString + '.' + Patch.ToString;
end;

{ TVersion }

constructor TVersion.Create;
begin
  FIDEVersion := GetIDEVersion;

{$IFDEF VER330}
  FName := 'rio';

  if FIDEVersion.Minor.ToString.StartsWith('32') then
    FSemantic := '10.3.1';

  if FIDEVersion.Minor.ToString.StartsWith('32') then
    FSemantic := '10.3.0';
{$ENDIF}
{$IFDEF VER320}
  FName := 'tokyo';
  FSemantic := '10.2.3'
{$ENDIF}
end;

function TVersion.GetIDEVersion: TSemanticVersion;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
  LFileName: string;
begin
  LFileName := ParamStr(0);
  VerInfoSize := GetFileVersionInfoSize(PChar(LFileName), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(PChar(LFileName), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
        begin
          Result := TSemanticVersion.Create(HiWord(dwFileVersionMS), HiWord(dwFileVersionLS), LoWord(dwFileVersionLS));
        end;
  finally
    FreeMem(PVerInfo, VerInfoSize);
  end;
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
