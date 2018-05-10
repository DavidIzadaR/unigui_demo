unit Session.RegServices.Default;

interface

uses
  TypInfo,
  Classes,
  Vcl.Controls,
  Vcl.ComCtrls,
  Spring,
  Spring.Collections,
  Spring.Collections.Lists,
  Spring.Container,
  Spring.Services,
  Session.RegServices;

type

  { TModule }

  TModule = class(TInterfacedObject, IModule)
  strict private
    class var
      FSequence : integer;
  private
    FClass      : TClass;
    FName       : string;
    FIconIndex  : integer;
    FSingleton  : boolean;
    FDataModuleClass : TDataModuleClass;
    FOwnsDataModule  : boolean;

    function  GetName            : string;
    function  GetIconIndex       : integer;
    function  GetSingleton       : boolean;
    function  GetInstance        : TControl;
    function  GetIsFrame         : boolean;
    function  GetIsForm          : boolean;
    function  GetSequence        : integer;
    procedure SetIconIndex       (const Value : integer);
    function  GetDataModuleClass : TDataModuleClass;
    procedure SetDataModuleClass (const Value : TDataModuleClass);
    function  GetOwnsDataModule  : boolean;
    procedure SetOwnsDataModule  (const Value : boolean);

    procedure DoOnCreate    ; virtual;
    procedure DoOnDestroy   ; virtual;
  public
    constructor Create(aClass : TClass; aName : string; aSingleton : boolean = true);
  end;

  { TRegistration }

  TSessionRegistration = class(TInterfacedObject, ISessionRegistration)
  private
    FModules  : IModules;

    function GetModules     : IModules;
  public
    constructor Create;

    procedure RegisterModule  (aModuleClass : TClass; aSingleton : boolean);
    procedure RegisterServerModules;

    function  GetModuleByTreeCaption(aTreeCaption : string) : IModule;

    function  GetModule       (aModuleName   : string ) : IModule;

    function  CreateInstance  (aModuleName   : string ) : TControl;
    procedure ReleaseInstance (aInstance     : TObject);

    procedure ShowModuleAsTab (aModuleName   : string; aID : integer = -1);
    procedure ShowModuleAsForm(aModuleName   : string; aID : integer = -1);
  end;

implementation

uses
  System.SysUtils,
  Spring.Container.Common,
  uniGUIApplication,
  uniGUIForm,
  uniGUIFrame,
  ServerModule,
  Main,
  MainModule,
  Server.Resources;

{ TModule }

constructor TModule.Create(aClass : TClass; aName : string; aSingleton : boolean = true);
var
  Reg : IRegistration;
  TypeInfo : PTypeInfo;
begin
  inherited Create();

  FClass      := aClass;
  FName       := aName;
  FIconIndex  := -1;
  FSingleton  := aSingleton;

  TypeInfo := PTypeInfo(aClass.ClassInfo);

  if FClass.InheritsFrom(TUniFrame) then
    Reg :=
      UniMainModule.Container.
        RegisterType(TypeInfo).
        Implements(TypeInfo).
        InjectConstructor([UniMainModule.MainForm])
  else
    if FClass.InheritsFrom(TUniForm) then
      Reg :=
        UniMainModule.Container.
          RegisterType(TypeInfo).
          Implements(TypeInfo).
          InjectConstructor([uniGUIApplication.UniApplication])
    else
      raise Exception.Create('Trying to register unsupported module: ' + aClass.ClassName);

  if FSingleton then
    Reg.AsSingleton
  else
    Reg.AsTransient;
end;

function TModule.GetName: string;
begin
  Result := FName;
end;

function TModule.GetSequence: integer;
begin
  Inc(FSequence);
  Result := FSequence;
end;

function TModule.GetSingleton: boolean;
begin
  Result := FSingleton;
end;

procedure TModule.SetIconIndex(const Value: integer);
begin
  FIconIndex := Value;
end;

function TModule.GetIconIndex: integer;
begin
  Result := FIconIndex;
end;

function TModule.GetInstance: TControl;
begin
  Result := UniMainModule.Container.Resolve(FClass.ClassInfo).AsObject as TControl;
end;

function TModule.GetIsForm: boolean;
begin
  Result := FClass.InheritsFrom(TUniForm);
end;

function TModule.GetIsFrame: boolean;
begin
  Result := FClass.InheritsFrom(TUniFrame);
end;

procedure TModule.DoOnCreate;
begin

end;

procedure TModule.DoOnDestroy;
begin

end;

function  TModule.GetDataModuleClass : TDataModuleClass;
begin
  Result := FDataModuleClass;
end;

procedure TModule.SetDataModuleClass (const Value : TDataModuleClass);
begin 
  FDataModuleClass := Value;
end;

function  TModule.GetOwnsDataModule  : boolean;
begin
  Result := FOwnsDataModule;
end;

procedure TModule.SetOwnsDataModule  (const Value : boolean);
begin
  FOwnsDataModule := Value;
end;

{ TSessionRegistration }

constructor TSessionRegistration.Create;
begin
  FModules := TCollections.CreateDictionary<string, IModule>;
end;

function TSessionRegistration.CreateInstance(aModuleName : string) : TControl;
var
  aModule : IModule;
begin
  if UniMainModule.RegVar.Modules.TryGetValue(aModuleName, aModule) then
    Result := aModule.Instance
  else
    Result := nil;
end;

function TSessionRegistration.GetModule(aModuleName: string): IModule;
begin
  GetModules.TryGetValue(aModuleName, Result);
end;

function TSessionRegistration.GetModuleByTreeCaption(aTreeCaption : string): IModule;
var
  aClassName : string;
begin
  if uniServerModule.ServerRegistration.MenuNodes.TryGetValue(aTreeCaption, aClassName) then
    Result := GetModule(aClassName)
  else
    Result := nil;
end;

function TSessionRegistration.GetModules: IModules;
begin
  Result := FModules;
end;

procedure TSessionRegistration.RegisterModule(aModuleClass: TClass; aSingleton : boolean);
var
  Module : IModule;
begin
  Module := TModule.Create(aModuleClass, aModuleClass.ClassName, aSingleton);

  FModules.Add(aModuleClass.ClassName, Module);
end;

procedure TSessionRegistration.RegisterServerModules;
var
  FormDef : TModuleDef;
begin
  for FormDef in uniServerModule.ServerRegistration.FormDefs.Values do
  begin
    if FormDef.ModuleClass.InheritsFrom(TUniForm) or FormDef.ModuleClass.InheritsFrom(TUniFrame) then
      UniMainModule.RegVar.RegisterModule(FormDef.ModuleClass, FormDef.Singleton);
  end;
end;

procedure TSessionRegistration.ReleaseInstance(aInstance: TObject);
begin
  UniMainModule.Container.Release(aInstance);
end;

procedure TSessionRegistration.ShowModuleAsForm(aModuleName : string; aID : integer = -1);
begin

end;

procedure TSessionRegistration.ShowModuleAsTab(aModuleName : string; aID : integer = -1);
var
  aModule : IModule;
begin
  aModule := GetModule(aModuleName);
  if not Assigned(aModule) then
    raise Exception.Create(Format('Module <%s> not available!', [aModuleName]));

  MainForm.ShowModuleAsTab(aModule, aID);
end;

end.
