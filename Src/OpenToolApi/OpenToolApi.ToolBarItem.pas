unit OpenToolApi.ToolBarItem;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TToolBarItem = class(TDataModule)
    ImageListDocker: TImageList;
    ActionListDocker: TActionList;
    ToolBarItemDocker: TAction;
    MainMenuDocker: TMainMenu;
    Este21: TMenuItem;
    procedure ActionListDockerExecute(Action: TBasicAction; var Handled: Boolean);
  private
    class var FInstance: TToolBarItem;
  public
    class function GetInstance: TToolBarItem;
    class procedure Release;
    constructor Create; reintroduce;
  end;

implementation

uses
  ToolsAPI;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TToolBarItem.ActionListDockerExecute(Action: TBasicAction; var Handled: Boolean);
begin
//
end;

constructor TToolBarItem.Create;
begin
  inherited Create(nil);
end;

class function TToolBarItem.GetInstance: TToolBarItem;
begin
  if not Assigned(FInstance) then
    FInstance := TToolBarItem.Create;

  Result := FInstance;
end;

class procedure TToolBarItem.Release;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

initialization

finalization

TToolBarItem.Release;

end.
