unit Session.Registration;

interface

procedure RegSessionWeb;

implementation

uses
  Spring.Services,
  ServerModule,
  MainModule,
  uniGUIForm,
  uniGUIFrame,
  Server.Resources,
  Server.Registration,
  Session.RegServices;

procedure RegisterModules;
var
  FormDef : TFormDef;
begin
  for FormDef in uniServerModule.ServerRegistration.FormDefs.Values do
  begin
    if FormDef.ModuleClass.InheritsFrom(TUniForm) or FormDef.ModuleClass.InheritsFrom(TUniFrame) then
      UniMainModule.RegVar.RegisterModule(FormDef.ModuleClass, FormDef.Singleton);
  end;
end;

procedure RegSessionWeb;
begin
//  UniMainModule.UserIQRegVar := ServiceLocator.GetService<ISessionRegistration>;
//  UniMainModule.UserIQModel  := ServiceLocator.GetService<IIQFrameworkServices>;

  RegisterModules;

//  UniMainModule.UserContainer.Build;
end;

end.
