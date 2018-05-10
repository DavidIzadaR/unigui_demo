object dmUsers: TdmUsers
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 154
  Width = 219
  object dsUsers: TDataSource
    DataSet = tblUsers
    Left = 24
    Top = 16
  end
  object tblUsers: TFDTable
    BeforePost = tblUsersBeforePost
    IndexFieldNames = 'Username'
    Connection = UniMainModule.Conn
    UpdateOptions.UpdateTableName = 'Users'
    TableName = 'Users'
    Left = 24
    Top = 72
    object tblUsersUsername: TStringField
      FieldName = 'Username'
      Origin = 'Username'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 16
    end
    object tblUsersPassword: TStringField
      FieldName = 'Password'
      Origin = 'Password'
      Required = True
      Size = 32
    end
    object tblUsersRoleId: TIntegerField
      FieldName = 'RoleId'
      Origin = 'RoleId'
    end
    object tblUsersRole: TStringField
      FieldKind = fkLookup
      FieldName = 'Role'
      LookupDataSet = tblRoles
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'RoleId'
      Size = 50
      Lookup = True
    end
  end
  object ActionList1: TActionList
    Left = 152
    Top = 48
    object actToggleAdmin: TAction
      Category = 'tblUsers'
      Caption = 'Toggle Admin Status'
      ImageIndex = 3
      OnExecute = actToggleAdminExecute
    end
  end
  object tblRoles: TFDTable
    Active = True
    IndexFieldNames = 'Id'
    Connection = UniMainModule.Conn
    UpdateOptions.UpdateTableName = 'Roles'
    TableName = 'Roles'
    Left = 88
    Top = 72
    object tblRolesId: TIntegerField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tblRolesName: TStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 32
    end
  end
  object dsRoles: TDataSource
    DataSet = tblRoles
    Left = 88
    Top = 16
  end
end
