unit ServiceModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  uniGUIService;

type
  TUniServiceModule = class(TUniGUIService)
  private
    { Private declarations }
  protected
    procedure InitService; override;
  public
    { Public declarations }
    function GetServiceController: TServiceController; override;
  end;

var
  UniServiceModule: TUniServiceModule;

implementation

{$R *.dfm}

uses
  UniGUIVars;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  UniServiceModule.Controller(CtrlCode);
end;

function TUniServiceModule.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TUniServiceModule.InitService;
begin
  SetServerClass(UniGUIServerModuleClass);
end;

end.
