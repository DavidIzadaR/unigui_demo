object dOrdersForm: TdOrdersForm
  Left = 0
  Top = 0
  ClientHeight = 432
  ClientWidth = 624
  Caption = 'Orders'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  LayoutConfig.Region = 'center'
  PixelsPerInch = 96
  TextHeight = 13
  object pc: TUniPageControl
    Left = 0
    Top = 0
    Width = 624
    Height = 432
    Hint = ''
    ActivePage = tsOrdersItems
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    LayoutConfig.Region = 'center'
    TabOrder = 0
    object tsOrdersItems: TUniTabSheet
      Hint = ''
      Caption = 'Orders / Items'
      Layout = 'border'
      object pnlOrders: TUniPanel
        Left = 0
        Top = 0
        Width = 616
        Height = 191
        Hint = ''
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        Caption = ''
        Layout = 'border'
        LayoutConfig.Region = 'center'
        object dbgOrders: TUniDBGrid
          Left = 1
          Top = 37
          Width = 614
          Height = 153
          Hint = ''
          DataSource = dmOrders.dsOrders
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 2
          LayoutConfig.Region = 'center'
          Align = alClient
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          Columns = <
            item
              FieldName = 'ID'
              Title.Alignment = taCenter
              Title.Caption = 'ID'
              Width = 64
              Visible = False
              Alignment = taCenter
              ReadOnly = True
            end
            item
              FieldName = 'CustomerID'
              Title.Caption = 'CustomerID'
              Width = 64
              Visible = False
            end
            item
              FieldName = 'Customer'
              Title.Alignment = taCenter
              Title.Caption = 'Customer'
              Width = 142
            end
            item
              FieldName = 'Posted'
              Title.Alignment = taCenter
              Title.Caption = 'Created'
              Width = 132
            end
            item
              FieldName = 'Total'
              Title.Alignment = taCenter
              Title.Caption = 'Total'
              Width = 69
              ReadOnly = True
            end
            item
              FieldName = 'Paid'
              Title.Alignment = taCenter
              Title.Caption = 'Paid'
              Width = 132
              ReadOnly = True
            end>
        end
        object barOrders: TUniToolBar
          Left = 1
          Top = 1
          Width = 614
          Height = 36
          Hint = ''
          ButtonHeight = 34
          ButtonWidth = 34
          Images = UniMainModule.UniNativeImageList1
          LayoutConfig.Region = 'north'
          Layout = 'border'
          Anchors = [akLeft, akTop, akRight]
          Align = alTop
          TabOrder = 2
          ParentColor = False
          Color = clBtnFace
          object btnPaid: TUniToolButton
            Left = 0
            Top = 0
            Action = dmOrders.actMarkAsPaid
            ImageIndex = 2
            LayoutConfig.Region = 'west'
            TabOrder = 1
          end
          object cntOrders: TUniToolButton
            Left = 34
            Top = 0
            Width = 244
            Hint = ''
            Style = tbsContainer
            Caption = ''
            LayoutConfig.Region = 'east'
            LayoutConfig.Margin = '5px'
            Layout = 'border'
            TabOrder = 2
            object dbnOrders: TUniDBNavigator
              Left = 4
              Top = 0
              Width = 240
              Height = 26
              Hint = ''
              DataSource = dmOrders.dsOrders
              LayoutConfig.Region = 'east'
              TabOrder = 1
            end
          end
        end
      end
      object pnlItems: TUniPanel
        Left = 0
        Top = 191
        Width = 616
        Height = 213
        Hint = ''
        Align = alBottom
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 1
        Caption = ''
        Collapsible = True
        CollapseDirection = cdBottom
        Layout = 'border'
        LayoutConfig.Split = True
        LayoutConfig.Region = 'south'
        object dbgItems: TUniDBGrid
          Left = 1
          Top = 37
          Width = 614
          Height = 175
          Hint = ''
          DataSource = dmOrders.dsItems
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 2
          LayoutConfig.Region = 'center'
          Align = alClient
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          Columns = <
            item
              FieldName = 'OrderID'
              Title.Caption = 'OrderID'
              Width = 64
              Visible = False
            end
            item
              FieldName = 'ProductID'
              Title.Caption = 'ProductID'
              Width = 64
              Visible = False
            end
            item
              FieldName = 'Product'
              Title.Alignment = taCenter
              Title.Caption = 'Product'
              Width = 142
            end
            item
              FieldName = 'Quantity'
              Title.Alignment = taCenter
              Title.Caption = 'Quantity'
              Width = 64
              Alignment = taCenter
            end
            item
              FieldName = 'Price'
              Title.Alignment = taCenter
              Title.Caption = 'Price'
              Width = 64
              ReadOnly = True
            end
            item
              FieldName = 'Total'
              Title.Alignment = taCenter
              Title.Caption = 'Total'
              Width = 64
            end>
        end
        object barItems: TUniToolBar
          Left = 1
          Top = 1
          Width = 614
          Height = 36
          Hint = ''
          ButtonHeight = 34
          ButtonWidth = 34
          LayoutConfig.Region = 'north'
          Layout = 'border'
          Anchors = [akLeft, akTop, akRight]
          Align = alTop
          TabOrder = 2
          ParentColor = False
          Color = clBtnFace
          object btnItems: TUniToolButton
            Left = 0
            Top = 0
            Hint = ''
            CreateOrder = 1
            Enabled = False
            Caption = ''
            LayoutConfig.Region = 'west'
            TabOrder = 2
          end
          object cntItems: TUniToolButton
            Left = 34
            Top = 0
            Width = 244
            Hint = ''
            CreateOrder = 2
            Style = tbsContainer
            Caption = ''
            LayoutConfig.Region = 'east'
            LayoutConfig.Margin = '5px'
            Layout = 'border'
            TabOrder = 1
            object dbnItems: TUniDBNavigator
              Left = 6
              Top = 4
              Width = 240
              Height = 26
              Hint = ''
              DataSource = dmOrders.dsItems
              LayoutConfig.Region = 'east'
              TabOrder = 1
            end
          end
        end
      end
    end
    object tsCustomers: TUniTabSheet
      Hint = ''
      Caption = 'Customers'
      Layout = 'border'
      object barCustomers: TUniToolBar
        Left = 0
        Top = 0
        Width = 616
        Height = 36
        Hint = ''
        ButtonHeight = 34
        ButtonWidth = 34
        LayoutConfig.Region = 'north'
        Layout = 'border'
        Anchors = [akLeft, akTop, akRight]
        Align = alTop
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        object btnCustomers: TUniToolButton
          Left = 0
          Top = 0
          Hint = ''
          Enabled = False
          Caption = ''
          LayoutConfig.Region = 'west'
          TabOrder = 1
        end
        object cntCustomers: TUniToolButton
          Left = 34
          Top = 0
          Width = 265
          Hint = ''
          Style = tbsContainer
          Caption = ''
          LayoutConfig.Region = 'east'
          LayoutConfig.Margin = '5px'
          Layout = 'border'
          TabOrder = 2
          object dbnCustomers: TUniDBNavigator
            Left = 24
            Top = 3
            Width = 240
            Height = 26
            Hint = ''
            DataSource = dmOrders.dsCustomers
            LayoutConfig.Region = 'east'
            TabOrder = 1
          end
        end
      end
      object dbgCustomers: TUniDBGrid
        Left = 0
        Top = 36
        Width = 616
        Height = 368
        Hint = ''
        DataSource = dmOrders.dsCustomers
        LoadMask.Message = 'Loading data...'
        LayoutConfig.Flex = 2
        LayoutConfig.Region = 'center'
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 1
        Columns = <
          item
            FieldName = 'ID'
            Title.Alignment = taCenter
            Title.Caption = 'ID'
            Width = 64
            Visible = False
            Alignment = taCenter
            ReadOnly = True
          end
          item
            FieldName = 'Name'
            Title.Alignment = taCenter
            Title.Caption = 'Name'
            Width = 388
          end>
      end
    end
    object tsProducts: TUniTabSheet
      Hint = ''
      Caption = 'Products'
      Layout = 'border'
      object barProducts: TUniToolBar
        Left = 0
        Top = 0
        Width = 616
        Height = 36
        Hint = ''
        ButtonHeight = 34
        ButtonWidth = 34
        LayoutConfig.Region = 'north'
        Layout = 'border'
        Anchors = [akLeft, akTop, akRight]
        Align = alTop
        TabOrder = 0
        ParentColor = False
        Color = clBtnFace
        object btnProducts: TUniToolButton
          Left = 0
          Top = 0
          Hint = ''
          Enabled = False
          Caption = ''
          LayoutConfig.Region = 'west'
          TabOrder = 1
        end
        object cntProducts: TUniToolButton
          Left = 34
          Top = 0
          Width = 305
          Hint = ''
          Style = tbsContainer
          Caption = ''
          LayoutConfig.Region = 'east'
          LayoutConfig.Margin = '5px'
          Layout = 'border'
          TabOrder = 2
          object dbnProducts: TUniDBNavigator
            Left = 71
            Top = 3
            Width = 240
            Height = 26
            Hint = ''
            DataSource = dmOrders.dsProducts
            LayoutConfig.Region = 'east'
            TabOrder = 1
          end
        end
      end
      object dbgProducts: TUniDBGrid
        Left = 0
        Top = 36
        Width = 616
        Height = 368
        Hint = ''
        DataSource = dmOrders.dsProducts
        LoadMask.Message = 'Loading data...'
        LayoutConfig.Flex = 2
        LayoutConfig.Region = 'center'
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 1
        Columns = <
          item
            FieldName = 'ID'
            Title.Alignment = taCenter
            Title.Caption = 'ID'
            Width = 64
            Visible = False
            Alignment = taCenter
            ReadOnly = True
          end
          item
            FieldName = 'Description'
            Title.Alignment = taCenter
            Title.Caption = 'Description'
            Width = 333
          end
          item
            FieldName = 'Price'
            Title.Alignment = taCenter
            Title.Caption = 'Price'
            Width = 64
          end>
      end
    end
  end
end
