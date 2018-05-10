object dmOrders: TdmOrders
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 197
  Width = 278
  object dsOrders: TDataSource
    DataSet = tblOrders
    Left = 24
    Top = 24
  end
  object dsItems: TDataSource
    DataSet = tblItems
    Left = 160
    Top = 25
  end
  object tblCustomers: TFDTable
    IndexFieldNames = 'ID'
    Connection = UniMainModule.Conn
    UpdateOptions.UpdateTableName = 'Customers'
    TableName = 'Customers'
    Left = 96
    Top = 72
    object tblCustomersID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tblCustomersUserName: TStringField
      FieldName = 'UserName'
      Origin = 'UserName'
      Required = True
      Size = 64
    end
  end
  object tblProducts: TFDTable
    IndexFieldNames = 'ID'
    Connection = UniMainModule.Conn
    UpdateOptions.UpdateTableName = 'Products'
    TableName = 'Products'
    Left = 216
    Top = 72
    object tblProductsID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tblProductsDescription: TStringField
      FieldName = 'Description'
      Origin = 'Description'
      Required = True
      Size = 64
    end
    object tblProductsPrice: TCurrencyField
      FieldName = 'Price'
      Origin = 'Price'
    end
  end
  object tblOrders: TFDTable
    OnCalcFields = tblOrdersCalcFields
    IndexFieldNames = 'ID'
    Connection = UniMainModule.Conn
    UpdateOptions.UpdateTableName = 'Orders'
    TableName = 'Orders'
    Left = 24
    Top = 72
    object tblOrdersID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tblOrdersCustomerID: TIntegerField
      FieldName = 'CustomerID'
      Origin = 'CustomerID'
      Required = True
    end
    object tblOrdersCustomer: TStringField
      DisplayWidth = 23
      FieldKind = fkLookup
      FieldName = 'Customer'
      LookupDataSet = tblCustomers
      LookupKeyFields = 'ID'
      LookupResultField = 'Name'
      KeyFields = 'CustomerID'
      Size = 64
      Lookup = True
    end
    object tblOrdersPosted: TDateTimeField
      FieldName = 'Posted'
      Origin = 'Posted'
    end
    object tblOrdersTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Total'
      ReadOnly = True
      Calculated = True
    end
    object tblOrdersPaid: TDateTimeField
      FieldName = 'Paid'
      Origin = 'Paid'
    end
  end
  object tblItems: TFDTable
    AfterPost = tblItemsAfterPost
    OnCalcFields = tblItemsCalcFields
    IndexFieldNames = 'OrderID;ProductID'
    MasterSource = dsOrders
    MasterFields = 'ID'
    DetailFields = 'OrderID'
    Connection = UniMainModule.Conn
    UpdateOptions.UpdateTableName = 'Items'
    TableName = 'Items'
    Left = 160
    Top = 72
    object tblItemsOrderID: TIntegerField
      DisplayWidth = 10
      FieldName = 'OrderID'
      Origin = 'OrderID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tblItemsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'ProductID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tblItemsProduct: TStringField
      DisplayWidth = 23
      FieldKind = fkLookup
      FieldName = 'Product'
      LookupDataSet = tblProducts
      LookupKeyFields = 'ID'
      LookupResultField = 'Description'
      KeyFields = 'ProductID'
      Size = 64
      Lookup = True
    end
    object tblItemsQuantity: TIntegerField
      DisplayWidth = 10
      FieldName = 'Quantity'
      Origin = 'Quantity'
      Required = True
    end
    object tblItemsPrice: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Price'
      LookupDataSet = tblProducts
      LookupKeyFields = 'ID'
      LookupResultField = 'Price'
      KeyFields = 'ProductID'
      ReadOnly = True
      Lookup = True
    end
    object tblItemsTotal: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Total'
      Calculated = True
    end
  end
  object dsCustomers: TDataSource
    DataSet = tblCustomers
    Left = 96
    Top = 24
  end
  object dsProducts: TDataSource
    DataSet = tblProducts
    Left = 216
    Top = 24
  end
  object ActionList1: TActionList
    Images = UniMainModule.UniImageListAdapter1
    Left = 128
    Top = 136
    object actMarkAsPaid: TAction
      Category = 'tblOrders'
      Caption = 'Mark as Paid'
      ImageIndex = 2
      OnExecute = actMarkAsPaidExecute
    end
  end
end
