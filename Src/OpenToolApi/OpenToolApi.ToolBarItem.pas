unit OpenToolApi.ToolBarItem;

interface

uses
  ToolsAPI, Vcl.ComCtrls, System.Classes, OpenToolApi.Images;

type

  TToolBarItem = class(TToolButton)
  public
    constructor Create(AOwner: TComponent); reintroduce;
  end;

implementation

{ TToolBarItem }

constructor TToolBarItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := 'Run With Docker';
  ImageIndex := TDataModuleImages.GetInstance.IndexDocker;
end;

end.
