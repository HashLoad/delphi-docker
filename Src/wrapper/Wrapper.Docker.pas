unit Wrapper.Docker;

interface

function DockerIsRunning: Boolean;
function DockerIsInstalled: Boolean;

function DoDockerPreFlight: Boolean;

implementation

uses
  Command.Runner, System.SysUtils;

const
  Docker = 'docker';
  DOCKER_PS = Docker + ' ps';
  WHERE_DOCKER = 'where docker.exe';

function DockerIsRunning: Boolean;
begin
  Result := Runner(DOCKER_PS) = 0;
end;

function DockerIsInstalled: Boolean;
begin
  Result := Runner(WHERE_DOCKER) = 0;
end;

function DoDockerPreFlight: Boolean;
begin
  if not DockerIsInstalled then
    raise Exception.Create('Docker is not installed on your system.');

  if not DockerIsRunning then
    raise Exception.Create('Docker is not started.');
end;

end.
