unit Wrapper.DockerCompose;

interface

function DockerComposeUp(APath: string): Boolean;
function DockerComposeDown(APath: string): Boolean;
function DockerComposePS(APath: string): Boolean;
procedure WaitComposeUp(APath: string);

implementation

uses
  Command.Runner, Command.Cmd, System.SysUtils;

Const
  DOCKER_COMPOSE = 'docker-compose';
  DOCKER_COMPOSE_PS = DOCKER_COMPOSE + ' ps';
  DOCKER_COMPOSE_DOWN = DOCKER_COMPOSE + ' down';
  DOCKER_COMPOSE_UP = DOCKER_COMPOSE + ' up';
  DOCKER_COMPOSE_UP_D = DOCKER_COMPOSE_UP + ' -d';
  DOCKER_COMPOSE_LOGS_F = DOCKER_COMPOSE + ' logs -f';

function DockerComposePS(APath: string): Boolean;
begin
  Runner(DOCKER_COMPOSE_PS, APath);
end;

function DockerComposeUp(APath: string): Boolean;
begin
  Runner(DOCKER_COMPOSE_UP_D, APath);
  Sleep(100);
  TCommandCmd.GetInstance.Run(DOCKER_COMPOSE_LOGS_F, APath);
end;

function DockerComposeDown(APath: string): Boolean;
begin
  Runner(DOCKER_COMPOSE_DOWN, APath);
end;


procedure WaitComposeUp(APath: string);
begin
  Runner(DOCKER_COMPOSE_PS, APath);
end;

end.
