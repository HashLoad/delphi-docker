unit OpenToolApi.Events;

interface

uses
  ToolsAPI, System.Classes, Vcl.Controls;

type

  TEventsToolBar = class(TInterfacedObject, INTACustomizeToolbarNotifier, IOTANotifier)
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
     procedure CreateButton(AOwner: TComponent; var Button: TControl;
      Action: TBasicAction);
    procedure FilterAction(Action: TBasicAction; ViewingAllCommands: Boolean;
      var DisplayName: string; var Display: Boolean; var Handled: Boolean);
    procedure FilterCategory(var Category: string; var Display: Boolean;
      var Handled: Boolean);
    procedure ResetToolbar(var Toolbar: TWinControl);
    procedure ShowToolbar(Toolbar: TWinControl; Show: Boolean);
    procedure ToolbarModified(Toolbar: TWinControl);
  end;

implementation

{ TEventsToolBar }

procedure TEventsToolBar.AfterSave;
begin
//
end;

procedure TEventsToolBar.BeforeSave;
begin
//
end;

procedure TEventsToolBar.CreateButton(AOwner: TComponent; var Button: TControl; Action: TBasicAction);
begin
//
end;

procedure TEventsToolBar.Destroyed;
begin
//
end;

procedure TEventsToolBar.FilterAction(Action: TBasicAction; ViewingAllCommands: Boolean; var DisplayName: string;
  var Display, Handled: Boolean);
begin
//
end;

procedure TEventsToolBar.FilterCategory(var Category: string; var Display, Handled: Boolean);
begin
//
end;

procedure TEventsToolBar.Modified;
begin
//
end;

procedure TEventsToolBar.ResetToolbar(var Toolbar: TWinControl);
begin
//
end;

procedure TEventsToolBar.ShowToolbar(Toolbar: TWinControl; Show: Boolean);
begin
//
end;

procedure TEventsToolBar.ToolbarModified(Toolbar: TWinControl);
begin
//
end;

end.
