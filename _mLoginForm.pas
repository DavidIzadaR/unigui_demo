unit _mLoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIRegClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniGUIBaseClasses, unimFieldSet, uniEdit, unimEdit, uniButton, unimButton;

type
  TmLoginForm = class(TUnimLoginForm)
    UnimFieldSet1: TUnimFieldSet;
    UnimContainerPanel1: TUnimContainerPanel;
    edtUsername: TUnimEdit;
    edtPassword: TUnimEdit;
    btnOK: TUnimButton;
    btnCancel: TUnimButton;
    procedure btnOKClick(Sender: TObject);
    procedure UnimLoginFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function mLoginForm: TmLoginForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function mLoginForm: TmLoginForm;
begin
  Result := TmLoginForm(UniMainModule.GetFormInstance(TmLoginForm));
end;

procedure TmLoginForm.btnOKClick(Sender: TObject);
begin
  if uniMainModule.Login(edtUsername.Text, edtPassword.Text, false) then
    ModalResult := mrOk
  else
    ShowMessage('Invalid credentials!');
end;

procedure TmLoginForm.UnimLoginFormCreate(Sender: TObject);
begin
  edtUsername.Text := UniApplication.Parameters.Values['username'];
  edtPassword.Text := UniApplication.Parameters.Values['password'];
end;

initialization
  RegisterAppFormClass(TmLoginForm);

end.
