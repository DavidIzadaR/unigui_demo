program OMS_Svc;

uses
  SvcMgr,
  ServiceModule in 'ServiceModule.pas' {UniServiceModule: TUniGUIService},
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  Mainm in 'Mainm.pas' {MainmForm: TUnimForm},
  Services in 'Services.pas',
  _dLoginForm in '_dLoginForm.pas' {dLoginForm: TUniLoginForm},
  _mLoginForm in '_mLoginForm.pas' {mLoginForm: TUnimLoginForm},
  _dOperatorsForm in '_dOperatorsForm.pas' {dOperatorsForm: TUniForm},
  _mOperatorsForm in '_mOperatorsForm.pas' {mOperatorsForm: TUnimForm},
  _dOrdersForm in '_dOrdersForm.pas' {dOrdersForm: TUniForm},
  _mOrdersForm in '_mOrdersForm.pas' {mOrdersForm: TUnimForm},
  _dSalesReportForm in '_dSalesReportForm.pas' {dSalesReportForm: TUniForm},
  _mSalesReportForm in '_mSalesReportForm.pas' {mSalesReportForm: TUnimForm},
  ReportDM in 'ReportDM.pas' {frDataModule: TDataModule},
  Interfaces in 'Interfaces.pas',
  Registration in 'Registration.pas',
  SpringExtension in 'SpringExtension.pas',
  OrdersDM in 'OrdersDM.pas' {dmOrders: TDataModule},
  UsersDM in 'UsersDM.pas' {dmUsers: TDataModule};

{$R *.res}

begin
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TUniServiceModule, UniServiceModule);
  Application.Run;
end.
