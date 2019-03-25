unit OpenToolApi.Images;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TDataModuleImages = class(TDataModule)
    ImageListDocker: TImageList;
  private
    FIndexDocker: Integer;
    class var FInstance: TDataModuleImages;
  public
    class function GetInstance: TDataModuleImages;
    class procedure Release;
    property IndexDocker: Integer read FIndexDocker write FIndexDocker;
    constructor Create; reintroduce;
  end;

implementation

uses
  ToolsAPI;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TDataModuleImages.Create;
begin
  inherited Create(nil);
  FIndexDocker := (BorlandIDEServices as INTAServices).AddImages(ImageListDocker, 'docker');
end;

class function TDataModuleImages.GetInstance: TDataModuleImages;
begin
  if not Assigned(FInstance) then
    FInstance := TDataModuleImages.Create;

  Result := FInstance;
end;

class procedure TDataModuleImages.Release;
begin
  if Assigned(FInstance) then
    FInstance.Free;
end;

initialization

finalization

TDataModuleImages.Release;

end.
