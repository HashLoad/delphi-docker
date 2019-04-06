unit Docker.Utils;

interface

function DockerIsRunning: Boolean;
function DockerIsInstalled: Boolean;

implementation

uses
  Winapi.TlHelp32, Winapi.Windows, System.SysUtils;

function processExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(exeFileName)) or
      (UpperCase(FProcessEntry32.szExeFile) = UpperCase(exeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function DockerIsRunning: Boolean;
begin
  processExists('dockerd.exe')
end;

function DockerIsInstalled: Boolean;
begin
  Result := processExists('where docker');
end;


end.
