unit DelphiDocker.Images;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TDataModuleImages = class(TDataModule)
    ImageList1: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleImages: TDataModuleImages;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
