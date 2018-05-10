unit ServerModule;

interface

uses
  Classes, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  Server.Registration;

type
  TUniServerModule = class(TUniGUIServerModule)
    FDManager1: TFDManager;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;

    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
  protected
    FServerRegistration : TServerRegistration;

    procedure FirstInit; override;
  public

    property ServerRegistration : TServerRegistration read FServerRegistration;
  end;

function UniServerModule: TUniServerModule;

implementation

{$R *.dfm}

uses
  UniGUIVars,
  IOUtils;

function UniServerModule: TUniServerModule;
begin
  Result:=TUniServerModule(UniGUIServerInstance);
end;

procedure TUniServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  FDManager1.Active := True;

  FServerRegistration := TServerRegistration.Create;
  FServerRegistration.RegServerWeb;
end;

procedure TUniServerModule.UniGUIServerModuleDestroy(Sender: TObject);
begin
  FServerRegistration.Free;
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

initialization
  RegisterServerModuleClass(TUniServerModule);
end.
