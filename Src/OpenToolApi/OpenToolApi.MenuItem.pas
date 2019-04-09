unit OpenToolApi.MenuItem;

interface

uses
  ToolsAPI, OpenToolApi.Tools;

type

  TDockerMenuItem = class
  private
    procedure OnExecute(ASender: TObject);
  public
    procedure AddMenuItem;
  end;

implementation

uses
  Docker.RunWithDocker;

{ TDockerMenuItem }

procedure TDockerMenuItem.AddMenuItem;
var
  LServices: INTAServices;
begin
  LServices := (BorlandIDEServices as INTAServices);
  LServices.MenuBeginUpdate;
  try
    CreateMenuItem('RunWithDocker', 'Run With Docker', 'Run', OnExecute, nil, False, True, 'Alt+F9');
  finally
    LServices.MenuEndUpdate;
  end;
end;

procedure TDockerMenuItem.OnExecute(ASender: TObject);
var
  LRunWithDocker: TRunWithDocker;
begin
  LRunWithDocker := TRunWithDocker.Create;
  try
    LRunWithDocker.Execute(ActiveProject);
  finally
    LRunWithDocker.Free;
  end;
end;

end.
