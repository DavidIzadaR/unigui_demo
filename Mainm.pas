unit Mainm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUImForm, uniGUIBaseClasses,
  uniLabel, unimLabel, uniButton, unimButton, uniToolBar, unimToolbar,
  uniBitBtn, unimBitBtn, uniGUImJSForm, unimPanel, unimMenu;

type
  TMainmForm = class(TUnimForm)
    btnEditUsers: TUnimBitBtn;
    btnEditOrders: TUnimBitBtn;
    UnimContainerPanel1: TUnimContainerPanel;
    btnReportSales: TUnimBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MainmForm: TMainmForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function MainmForm: TMainmForm;
begin
  Result := TMainmForm(UniMainModule.GetFormInstance(TMainmForm));
end;

initialization
  RegisterAppFormClass(TMainmForm);

end.
