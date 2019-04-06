unit Docker.RunWithDocker;

interface

type
  TRunWithDocker = class
  public
    procedure Execute;
  end;

implementation

uses
  Vcl.Dialogs, Command.Runner, Constants.Version;

{ TRunWithDocker }

procedure TRunWithDocker.Execute;
begin
//  Runner('dir');
  Runner('docker ps');
  ShowMessage('Version ' + TVersion.GetInstance.Semantic);
end;

end.
