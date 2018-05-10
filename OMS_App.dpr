{$define UNIGUI_VCL} // Comment out this line to turn this project into an ISAPI module'

{$ifndef UNIGUI_VCL}
library
{$else}
program
{$endif}
  OMS_App;

uses
  uniGUIISAPI,
  Forms,
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
  UsersDM in 'UsersDM.pas' {dmUsers: TDataModule},
  Server.Registration in 'Server.Registration.pas',
  Server.Resources in 'Server.Resources.pas',
  Session.RegServices.Default in 'Session.RegServices.Default.pas',
  Session.RegServices in 'Session.RegServices.pas';

{$R *.res}

{$ifndef UNIGUI_VCL}
exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;
{$endif}

begin
{$ifdef UNIGUI_VCL}
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
{$endif}
end.
