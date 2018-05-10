unit Server.Registration;

interface

uses
  uniTreeView,
  uniTreeMenu,
  uniImageList,
  Server.Resources,
  Spring.Collections;

type

  TFormDefs   = IDictionary<TClass, TModuleDef>;
  TMainTreeMenu  = IDictionary<string, string>;

  TServerRegistration = class
  private
    FFormDefs   : TFormDefs;
    FMainTreeMenu  : TMainTreeMenu;

    procedure LoadFormDefs;
    procedure LoadMenuNodes;
    function  GetFormDefs   : TFormDefs;
    function  GetMenuNodes  : TMainTreeMenu;
  public
    constructor Create;

    procedure RegServerWeb;
    procedure PopulateNavTree (aNavTree  : TUniTreeView; aImageList : TUniNativeImageList);
    procedure PopulateTreeMenu(aTreeMenu : TUniTreeMenu; aImageList : TUniNativeImageList);

    property  FormDefs  : TFormDefs   read GetFormDefs;
    property  MenuNodes : TMainTreeMenu  read GetMenuNodes;
  end;

implementation

uses
  TypInfo,
  Classes,
  SysUtils,
  Spring,
  Spring.Container,
  Spring.Services,
  Session.RegServices,
  Session.RegServices.Default,
  uniGUIAbstractClasses,
  MainModule;

procedure TServerRegistration.RegServerWeb;
begin
  GlobalContainer.RegisterType<TSessionRegistration>.Implements<ISessionRegistration>.AsTransient;

  GlobalContainer.Build;
end;

constructor TServerRegistration.Create;
begin
  inherited Create;

  FFormDefs := TCollections.CreateDictionary<TClass, TModuleDef>;
  LoadFormDefs;

  FMainTreeMenu := TCollections.CreateDictionary<string, string>;
  LoadMenuNodes;
end;

function TServerRegistration.GetFormDefs: TFormDefs;
begin
  Result := FFormDefs;
end;

function TServerRegistration.GetMenuNodes: TMainTreeMenu;
begin
  Result := FMainTreeMenu;
end;

procedure TServerRegistration.LoadFormDefs;
var
  FormDef : Server.Resources.TModuleDef;
begin
  for FormDef in Server.Resources.ModuleDefs do
    FFormDefs.Add(FormDef.ModuleClass, FormDef);
end;

procedure TServerRegistration.LoadMenuNodes;
var
  NavNode : Server.Resources.TNavNode;
  FrmClassName : string;
begin
  for NavNode in Server.Resources.NavTree do
  begin
    if NavNode.FormIdx = 0 then
      FrmClassName := ''
    else
      FrmClassName := Server.Resources.ModuleDefs[NavNode.FormIdx].ModuleClass.ClassName;

    FMainTreeMenu.Add(NavNode.Caption, FrmClassName);
  end;
end;

procedure TServerRegistration.PopulateNavTree(aNavTree : TUniTreeView; aImageList : TUniNativeImageList);
var
  NodeIdx   : integer;
  Caption   : string;
  Level     : integer;
  IconFile  : string;
  IconIndex : integer;
  CurrNode  : TUniTreeNode;
  Parent    : TUniTreeNode;
  TreeNodes : TUniTreeNodes;
begin
  TreeNodes := aNavTree.Items;
  TreeNodes.Clear;
  aImageList.Clear;

  CurrNode  := nil;
  for NodeIdx := 1 to NodeQty do
  begin
    Caption   := NavTree[NodeIdx].Caption;
    Level     := NavTree[NodeIdx].Level;
    IconFile  := 'Icons\' + Caption + '.ICO';

    Parent := CurrNode;
    while (Parent <> nil) and (Parent.Level >= Level) do
      Parent := Parent.Parent;
    CurrNode := TreeNodes.AddChild(Parent, Caption);

    if FileExists(IconFile) then
      IconIndex := aImageList.AddIconFile(IconFile)
    else
      IconIndex := -1;

    CurrNode.ImageIndex := IconIndex;
  end;
end;

procedure TServerRegistration.PopulateTreeMenu(aTreeMenu: TUniTreeMenu; aImageList: TUniNativeImageList);
begin

end;

end.
