unit _mOperatorsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniBasicGrid, uniDBGrid, unimDBListGrid, unimDBGrid, uniGUIBaseClasses,
  uniDBNavigator, unimDBNavigator, uniToolBar, unimToolbar,
  Interfaces,
  UsersDM;

type
  TmOperatorsForm = class(TUnimForm, IOperatorsEditorForm)
    dbgUsers: TUnimDBGrid;
    barUsers: TUnimToolBar;
    btnToggleAdmin: TUnimToolButton;
    UnimContainerPanel1: TUnimContainerPanel;
    UnimToolButton1: TUnimToolButton;
    dbnUsers: TUnimDBNavigator;
  private
    { Private declarations }
  public
    procedure ShowAsModal;
  end;

function mOperatorsForm : TmOperatorsForm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function mOperatorsForm : TmOperatorsForm;
begin
  Result := TmOperatorsForm(UniMainModule.GetFormInstance(TmOperatorsForm));
end;

procedure TmOperatorsForm.ShowAsModal;
begin
  ShowModal;
end;

end.
