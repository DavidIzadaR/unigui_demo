unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes,
  Services, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, uniImageList, uniGUIBaseClasses, uniGUIClasses, frxClass,
  Spring.Container, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, Vcl.Menus, uniMainMenu, TypInfo,
  Session.RegServices;

type
  TUniMainModule = class(TUniGUIMainModule)
    Conn: TFDConnection;
    ActionList1: TActionList;
    actEditOperators: TAction;
    actEditOrders: TAction;
    UniImageListAdapter1: TUniImageListAdapter;
    actReportSales: TAction;
    UniNativeImageList1: TUniNativeImageList;
    UniMenuItems1: TUniMenuItems;
    itmDashboard: TUniMenuItem;
    itmUsers: TUniMenuItem;
    itmProducts: TUniMenuItem;
    Charts1: TUniMenuItem;
    Bar1: TUniMenuItem;
    Pie1: TUniMenuItem;
    UniMenuItem1: TUniMenuItem;
    itmEmployees: TUniMenuItem;
    itmOperators: TUniMenuItem;
    itmSuppliers: TUniMenuItem;
    itmInventory: TUniMenuItem;
    itmCategories: TUniMenuItem;
    itmCatalog: TUniMenuItem;
    itmAreas: TUniMenuItem;
    itmPurchaseOrders: TUniMenuItem;
    SalesOrders1: TUniMenuItem;
    itmOnlineInventory: TUniMenuItem;
    itmPhysicalInventory: TUniMenuItem;
    itmReceptions: TUniMenuItem;

    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure actEditOperatorsExecute(Sender: TObject);
    procedure actEditOrdersExecute(Sender: TObject);
    procedure actReportSalesExecute(Sender: TObject);
    procedure UniGUIMainModuleNewComponent(AComponent: TComponent);
  private
    FContainer  : TContainer;
    FServices   : TServices;
    FUsername   : string;
    FIsAdmin    : boolean;
    FRegVar     : ISessionRegistration;

    procedure SetPlatform(aDesktop: Boolean);
  public
    function Login(const aUsername, aPassword : string; aDesktop : boolean) : boolean;

    property Container  : TContainer           read FContainer;
    property Services   : TServices            read FServices;
    property Username   : string               read FUsername;
    property IsAdmin    : boolean              read FIsAdmin;
    property RegVar     : ISessionRegistration read FRegVar;
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  Variants,
  UniGUIVars, ServerModule, uniGUIApplication,
  Messages,
  uniGUIDialogs,
  Spring.Services,
  Registration;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

{ TUniMainModule }

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  FContainer := TContainer.Create;
  FRegVar    := ServiceLocator.GetService<ISessionRegistration>;

  Conn.Open;
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  Conn.Close;
  FServices.Free;

  FContainer.Free;
end;

{ Login validation and session platform selection }

function TUniMainModule.Login(const aUsername, aPassword: string; aDesktop : boolean): boolean;
var
  UserFound : boolean;
  IsAdmin   : Variant;
begin
  Result := false;

  IsAdmin :=
    Conn.ExecSQLScalar
    (
      Format
      (
        'SELECT RoleID FROM Users WHERE Username = ''%s'' AND Password = ''%s''',
        [aUserName, aPassword]
      )
    ) = 1;

  UserFound := not VarIsClear(IsAdmin);
  if UserFound then
  begin
    FUsername := aUsername;

    FIsAdmin := not VarIsNull(IsAdmin) and IsAdmin;

    actEditOperators.Visible := FIsAdmin;

    Result := true;

    SetPlatform(aDesktop);
  end;
end;

{ Platform selection }

procedure TUniMainModule.SetPlatform(aDesktop: Boolean);
begin
  if aDesktop then
    RegisterTypesForDesktop(Container)
  else
    RegisterTypesForMobile(Container);

  FServices := TServices.Create;
end;

{ Launching pad business logic actions }

procedure TUniMainModule.actEditOrdersExecute(Sender: TObject);
begin
  Services.EditOrders;
end;

procedure TUniMainModule.actEditOperatorsExecute(Sender: TObject);
begin
  Services.EditUsers;
end;

procedure TUniMainModule.actReportSalesExecute(Sender: TObject);
begin
  Services.ReportSales;
end;

procedure TUniMainModule.UniGUIMainModuleNewComponent(AComponent: TComponent);
begin
  if AComponent is TfrxReport then
    (AComponent as TfrxReport).EngineOptions.UseGlobalDataSetList := False;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
