unit UsersDM;

interface

uses
  SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmUsers = class(TDataModule)
    dsUsers: TDataSource;
    tblUsers: TFDTable;
    tblUsersUsername: TStringField;
    tblUsersPassword: TStringField;
    ActionList1: TActionList;
    actToggleAdmin: TAction;
    tblUsersRoleId: TIntegerField;
    tblRoles: TFDTable;
    tblRolesId: TIntegerField;
    tblRolesName: TStringField;
    dsRoles: TDataSource;
    tblUsersRole: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure tblUsersBeforePost(DataSet: TDataSet);
    procedure actToggleAdminExecute(Sender: TObject);
  private
  public
    { Public declarations }
  end;

function dmUsers: TdmUsers;

implementation

{$R *.dfm}

uses
  uniGUIDialogs,
  UniGUIVars, uniGUIMainModule, MainModule;

const
  Admin_Role    = 1;
  Operator_Role = 2;
  Customer_Role = 3;

function dmUsers: TdmUsers;
begin
  Result := TdmUsers(UniMainModule.GetModuleInstance(TdmUsers));
end;

procedure TdmUsers.actToggleAdminExecute(Sender: TObject);
var
  newRole : integer;
begin
  if tblUsers.State <> dsBrowse then
    ShowMessage('Commit any pending udpate before requesting admin status changes!')
  else
    if not tblUsersRoleId.IsNull and (tblUsersRoleId.Value = Customer_Role) then
      ShowMessage('A customer cannot be promoted or demoted to Admin!')
    else
    begin
      if tblUsersRoleId.IsNull or (tblUsersRoleId.Value = Operator_Role) then
        newRole := Admin_Role
      else
        newRole := Operator_Role;

      tblUsers.Edit;
      tblUsersRoleId.Value := newRole;
      tblUsers.Post;
    end;
end;

procedure TdmUsers.DataModuleCreate(Sender: TObject);
begin
  tblRoles.Open;
  tblUsers.Open;
end;

procedure TdmUsers.DataModuleDestroy(Sender: TObject);
begin
  tblUsers.Close;
  tblRoles.Close;
end;

procedure TdmUsers.tblUsersBeforePost(DataSet: TDataSet);
const
  Admin_Role = 1;
var
  AdminQty : integer;
  oldAdmin : boolean;
  newAdmin : boolean;
begin
  AdminQty := tblUsers.Connection.ExecSQLScalar('SELECT count(*) FROM Users WHERE RoleID = 1');

  oldAdmin := tblUsersRoleId.CurValue = Admin_Role;
  newAdmin := tblUsersRoleId.NewValue = Admin_Role;

  if (oldAdmin and not newAdmin) and (AdminQty = 1) then
  begin
    ShowMessage('You need at least one admin account!');
    tblUsers.Cancel;
  end
end;

initialization
  RegisterModuleClass(TdmUsers);

end.
