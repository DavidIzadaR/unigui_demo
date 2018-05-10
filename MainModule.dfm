object UniMainModule: TUniMainModule
  OldCreateOrder = False
  OnCreate = UniGUIMainModuleCreate
  OnDestroy = UniGUIMainModuleDestroy
  Theme = 'neptune'
  MonitoredKeys.Keys = <>
  EnableSynchronousOperations = True
  ApplicationDataModuleOptions.CreateOnDemand = True
  OnNewComponent = UniGUIMainModuleNewComponent
  Height = 165
  Width = 277
  object Conn: TFDConnection
    ConnectionName = 'OMS_MSSQL'
    Params.Strings = (
      'ApplicationName=OMS'
      'Database=OMS'
      'DriverID=MSSQL'
      'Server=TPDAVID'
      'OSAuthent=Yes')
    Connected = True
    LoginPrompt = False
    Left = 16
    Top = 24
  end
  object ActionList1: TActionList
    Images = UniImageListAdapter1
    Left = 208
    Top = 24
    object actEditOperators: TAction
      Category = 'App Services'
      Caption = 'Operators'
      HelpKeyword = 'IOperatorsEditorForm'
      ImageIndex = 1
      OnExecute = actEditOperatorsExecute
    end
    object actEditOrders: TAction
      Category = 'App Services'
      Caption = 'Edit Orders'
      ImageIndex = 2
      OnExecute = actEditOrdersExecute
    end
    object actReportSales: TAction
      Category = 'App Services'
      Caption = 'Report Sales'
      ImageIndex = 5
      OnExecute = actReportSalesExecute
    end
  end
  object UniImageListAdapter1: TUniImageListAdapter
    UniImageList = UniNativeImageList1
    Left = 96
    Top = 24
  end
  object UniNativeImageList1: TUniNativeImageList
    Left = 96
    Top = 96
    Images = {
      1200000000000000060B0000006E617669636F6E3B66613B0000000006090000
      0075736572733B66613B00000000060B0000006465736B746F703B66613B0000
      0000060C000000656E76656C6F70653B66613B00000000060800000075736572
      3B66613B00000000060E0000006C696E652D63686172743B66613B0000000006
      1000000077696E646F772D636C6F73653B66613B000000000608000000736176
      653B66613B000000000608000000656469743B66613B00000000060700000063
      75743B66613B00000000060D0000006261722D63686172743B66613B00000000
      060D0000007069652D63686172743B66613B00000000060C000000626F6F6B6D
      61726B3B66613B00000000060C00000063616C656E6461723B66613B00000000
      0608000000666565643B66613B0000000006070000006661783B66613B000000
      000609000000696D6167653B66613B000000000609000000696E626F783B6661
      3B}
  end
  object UniMenuItems1: TUniMenuItems
    Left = 208
    Top = 93
    object itmDashboard: TUniMenuItem
      Caption = 'Dashboard'
      ImageIndex = 1
    end
    object itmUsers: TUniMenuItem
      Caption = 'Users'
      ImageIndex = 2
      object itmOperators: TUniMenuItem
        Action = actEditOperators
      end
      object itmSuppliers: TUniMenuItem
        Caption = 'Suppliers'
      end
      object itmEmployees: TUniMenuItem
        Caption = 'Customers'
      end
    end
    object itmProducts: TUniMenuItem
      Caption = 'Products'
      ImageIndex = 3
      object itmCategories: TUniMenuItem
        Caption = 'Categories'
      end
      object itmCatalog: TUniMenuItem
        Caption = 'Catalog'
      end
    end
    object itmInventory: TUniMenuItem
      Caption = 'Inventory'
      object itmAreas: TUniMenuItem
        Caption = 'Areas'
      end
      object itmOnlineInventory: TUniMenuItem
        Caption = 'Online Inventory'
      end
      object itmPhysicalInventory: TUniMenuItem
        Caption = 'Physical Inventory'
      end
      object itmReceptions: TUniMenuItem
        Caption = 'Receptions'
      end
    end
    object itmPurchaseOrders: TUniMenuItem
      Caption = 'Purchase Orders'
    end
    object SalesOrders1: TUniMenuItem
      Caption = 'Sales Orders'
    end
    object Charts1: TUniMenuItem
      Caption = 'Reports'
      ImageIndex = 4
      object Bar1: TUniMenuItem
        Action = actReportSales
      end
      object Pie1: TUniMenuItem
        Caption = 'Inventory Levels'
        ImageIndex = 10
      end
    end
    object UniMenuItem1: TUniMenuItem
      Caption = 'Exit'
      ImageIndex = 5
    end
  end
end
