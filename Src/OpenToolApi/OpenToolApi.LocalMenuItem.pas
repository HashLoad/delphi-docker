unit OpenToolApi.LocalMenuItem;

interface

uses
  ToolsAPI, Vcl.ActnList, System.Classes, Dialogs;

type
  TNotifierLocalMenuItem = class(TNotifierObject, IOTANotifier, IOTAProjectMenuItemCreatorNotifier)
  public
    function IsProject(const AIdent: string): Boolean;
    procedure AddMenu(const AProject: IOTAProject; const AIdentList: TStrings;
      const AProjectManagerMenuList: IInterfaceList; AIsMultiSelect: Boolean);
  end;

  TLocalMenuItem = class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
  private
    FCaption: string;
    FChecked: Boolean;
    FEnabled: Boolean;
    FHelpContext: Integer;
    FName: string;
    FParent: string;
    FPosition: Integer;
    FVerb: string;
    FOnExecute: TNotifyEvent;
  public
    function GetCaption: string;
    function GetChecked: Boolean;
    function GetEnabled: Boolean;
    function GetHelpContext: Integer;
    function GetName: string;
    function GetParent: string;
    function GetPosition: Integer;
    function GetVerb: string;
    procedure SetCaption(const Value: string);
    procedure SetChecked(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetHelpContext(Value: Integer);
    procedure SetName(const Value: string);
    procedure SetParent(const Value: string);
    procedure SetPosition(Value: Integer);
    procedure SetVerb(const Value: string);
    property Caption: string read GetCaption write SetCaption;
    property Checked: Boolean read GetChecked write SetChecked;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property HelpContext: Integer read GetHelpContext write SetHelpContext;
    property Name: string read GetName write SetName;
    property Parent: string read GetParent write SetParent;
    property Position: Integer read GetPosition write SetPosition;
    property Verb: string read GetVerb write SetVerb;
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
    function GetIsMultiSelectable: Boolean;
    procedure SetIsMultiSelectable(Value: Boolean);
    procedure Execute(const MenuContextList: IInterfaceList); overload;
    function PreExecute(const MenuContextList: IInterfaceList): Boolean;
    function PostExecute(const MenuContextList: IInterfaceList): Boolean;
    property IsMultiSelectable: Boolean read GetIsMultiSelectable write SetIsMultiSelectable;
    constructor Create;
  end;

implementation

constructor TLocalMenuItem.Create;
begin
  FCaption := 'Run With Docker';
  FEnabled := True;
  FPosition := pmmpRunNoDebug + 10;
end;

procedure TLocalMenuItem.Execute(const MenuContextList: IInterfaceList);
begin
  ShowMessage('teste');
end;

function TLocalMenuItem.GetCaption: string;
begin
  Result := FCaption;
end;

function TLocalMenuItem.GetChecked: Boolean;
begin
  Result := FChecked;
end;

function TLocalMenuItem.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TLocalMenuItem.GetHelpContext: Integer;
begin
  Result := FHelpContext;
end;

function TLocalMenuItem.GetIsMultiSelectable: Boolean;
begin

end;

function TLocalMenuItem.GetName: string;
begin
  Result := FName;
end;

function TLocalMenuItem.GetParent: string;
begin
  Result := FParent;
end;

function TLocalMenuItem.GetPosition: Integer;
begin
  Result := FPosition;
end;

function TLocalMenuItem.GetVerb: string;
begin
  Result := FVerb;
end;

function TLocalMenuItem.PostExecute(const MenuContextList: IInterfaceList): Boolean;
begin

end;

function TLocalMenuItem.PreExecute(const MenuContextList: IInterfaceList): Boolean;
begin

end;

procedure TLocalMenuItem.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TLocalMenuItem.SetChecked(Value: Boolean);
begin
  FChecked := Value;
end;

procedure TLocalMenuItem.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TLocalMenuItem.SetHelpContext(Value: Integer);
begin
  FHelpContext := Value;
end;

procedure TLocalMenuItem.SetIsMultiSelectable(Value: Boolean);
begin

end;

procedure TLocalMenuItem.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TLocalMenuItem.SetParent(const Value: string);
begin
  FParent := Value;
end;

procedure TLocalMenuItem.SetPosition(Value: Integer);
begin
  FPosition := Value;
end;

procedure TLocalMenuItem.SetVerb(const Value: string);
begin
  FVerb := Value;
end;

{ TNotifierLocalMenu }

procedure TNotifierLocalMenuItem.AddMenu(const AProject: IOTAProject; const AIdentList: TStrings;
  const AProjectManagerMenuList: IInterfaceList; AIsMultiSelect: Boolean);
begin
  if IsProject(AProject.ApplicationType) and (not AIsMultiSelect) and Assigned(AProject) and
    (AIdentList.IndexOf(sProjectContainer) <> -1) and Assigned(AProjectManagerMenuList) then
  begin
    AProjectManagerMenuList.Add(TLocalMenuItem.Create);
  end;
end;

function TNotifierLocalMenuItem.IsProject(const AIdent: string): Boolean;
begin
  Result := (AIdent = sApplication) or (AIdent = sConsole) or (AIdent = sPackage);
end;

end.
