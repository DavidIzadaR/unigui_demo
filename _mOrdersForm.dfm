object mOrdersForm: TmOrdersForm
  Left = 0
  Top = 0
  ClientHeight = 977
  ClientWidth = 768
  Caption = 'Edit Orders'
  TitleButtons = <>
  PixelsPerInch = 96
  TextHeight = 13
  DesignOrientation = True
  ScrollPosition = 0
  ScrollHeight = 47
  PlatformData = {}
  object UnimCarousel1: TUnimCarousel
    Left = 0
    Top = 0
    Width = 768
    Height = 977
    Hint = ''
    Align = alClient
    AlignmentControl = uniAlignmentClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    PageIndex = 0
    ActivePage = cpOrders
    object cpOrders: TUnimCarouselPage
      Left = 0
      Top = 0
      Width = 768
      Height = 977
      Hint = 'Orders / Items'
      object pnlOrders: TUnimContainerPanel
        Left = 1
        Top = 1
        Width = 766
        Height = 408
        Hint = ''
        Align = alTop
        Anchors = [akLeft, akTop, akRight]
        object barOrders: TUnimToolBar
          Left = 0
          Top = 0
          Width = 766
          Height = 48
          Hint = ''
          Anchors = [akLeft, akTop, akRight]
          Images = UniMainModule.UniNativeImageList1
          Caption = 'Orders'
          LayoutAttribs.Pack = 'justify'
          object btnMarkAsPaid: TUnimToolButton
            Left = 0
            Top = 0
            Width = 48
            Height = 48
            Action = dmOrders.actMarkAsPaid
            ImageIndex = 2
          end
          object cntOrders: TUnimToolButton
            Left = 48
            Top = 0
            Width = 409
            Height = 48
            Hint = ''
            Style = tbsContainer
            Caption = 'cntOrders'
            object dbnOrders: TUnimDBNavigator
              Left = 0
              Top = 4
              Width = 340
              Height = 42
              Hint = ''
              DataSource = dmOrders.dsOrders
              VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
              LayoutConfig.Padding = '2px'
              TabOrder = 1
            end
          end
        end
        object dbgOrders: TUnimDBGrid
          Left = 0
          Top = 48
          Width = 766
          Height = 360
          Hint = ''
          Align = alClient
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dmOrders.dsOrders
          Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete]
          Columns = <
            item
              Title.Alignment = taCenter
              Title.Caption = 'ID'
              Title.Font.Height = -21
              FieldName = 'ID'
              Visible = False
              Width = 67
              ReadOnly = True
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'CustomerID'
              Title.Font.Height = -21
              FieldName = 'CustomerID'
              Visible = False
              Width = 115
              ReadOnly = True
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'Customer'
              Title.Font.Height = -21
              FieldName = 'Customer'
              Width = 223
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'Created'
              Title.Font.Height = -21
              FieldName = 'Posted'
              Width = 206
              ReadOnly = True
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'Total'
              Title.Font.Height = -21
              FieldName = 'Total'
              Width = 114
              ReadOnly = True
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'Paid'
              Title.Font.Height = -21
              FieldName = 'Paid'
              Width = 174
            end>
        end
      end
      object pnlItems: TUnimContainerPanel
        Left = 1
        Top = 409
        Width = 766
        Height = 567
        Hint = ''
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        object barItems: TUnimToolBar
          Left = 0
          Top = 0
          Width = 766
          Height = 48
          Hint = ''
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Items'
          LayoutAttribs.Pack = 'justify'
          object UnimToolButton2: TUnimToolButton
            Left = 0
            Top = 0
            Width = 48
            Height = 48
            Hint = ''
            Style = tbsContainer
            Caption = 'UnimToolButton2'
          end
          object cntItems: TUnimToolButton
            Left = 48
            Top = 0
            Width = 409
            Height = 48
            Hint = ''
            Style = tbsContainer
            Caption = 'cntItems'
            object dbnItems: TUnimDBNavigator
              Left = 0
              Top = 4
              Width = 340
              Height = 42
              Hint = ''
              DataSource = dmOrders.dsItems
              VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
              LayoutConfig.Padding = '2px'
              TabOrder = 1
            end
          end
        end
        object dbgItems: TUnimDBGrid
          Left = 0
          Top = 48
          Width = 766
          Height = 519
          Hint = ''
          Align = alClient
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dmOrders.dsItems
          Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete]
          Columns = <
            item
              Title.Caption = 'OrderID'
              Title.Font.Height = -21
              FieldName = 'OrderID'
              Visible = False
              Width = 114
              ReadOnly = True
            end
            item
              Title.Caption = 'ProductID'
              Title.Font.Height = -21
              FieldName = 'ProductID'
              Visible = False
              Width = 114
              ReadOnly = True
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'Product'
              Title.Font.Height = -21
              FieldName = 'Product'
              Width = 257
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'Quantity'
              Title.Font.Height = -21
              FieldName = 'Quantity'
              Width = 114
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'Price'
              Title.Font.Height = -21
              FieldName = 'Price'
              Width = 114
              ReadOnly = True
            end
            item
              Title.Alignment = taCenter
              Title.Caption = 'Total'
              Title.Font.Height = -21
              FieldName = 'Total'
              Width = 114
            end>
        end
      end
    end
    object cpCustomers: TUnimCarouselPage
      Left = 0
      Top = 0
      Width = 768
      Height = 977
      Hint = 'Customers'
      object barCustomers: TUnimToolBar
        Left = 1
        Top = 1
        Width = 766
        Height = 48
        Hint = ''
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Customers'
        LayoutAttribs.Pack = 'justify'
        object UnimToolButton6: TUnimToolButton
          Left = 0
          Top = 0
          Width = 48
          Height = 48
          Hint = ''
          Style = tbsContainer
          Caption = 'UnimToolButton6'
        end
        object cntCustomers: TUnimToolButton
          Left = 48
          Top = 0
          Width = 410
          Height = 48
          Hint = ''
          Style = tbsContainer
          Caption = 'cntCustomers'
          object dbnCustomers: TUnimDBNavigator
            Left = 0
            Top = 4
            Width = 340
            Height = 42
            Hint = ''
            DataSource = dmOrders.dsCustomers
            VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
            TabOrder = 1
          end
        end
      end
      object dbgCustomers: TUnimDBGrid
        Left = 1
        Top = 49
        Width = 766
        Height = 927
        Hint = ''
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmOrders.dsCustomers
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete]
        Columns = <
          item
            Title.Alignment = taCenter
            Title.Caption = 'ID'
            Title.Font.Height = -21
            FieldName = 'ID'
            Visible = False
            Width = 114
          end
          item
            Title.Alignment = taCenter
            Title.Caption = 'Name'
            Title.Font.Height = -21
            FieldName = 'Name'
            Width = 477
          end>
      end
    end
    object cpProducts: TUnimCarouselPage
      Left = 0
      Top = 0
      Width = 768
      Height = 977
      Hint = 'Products'
      object barProducts: TUnimToolBar
        Left = 1
        Top = 1
        Width = 766
        Height = 48
        Hint = ''
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Products'
        LayoutAttribs.Pack = 'justify'
        object UnimToolButton4: TUnimToolButton
          Left = 0
          Top = 0
          Width = 48
          Height = 48
          Hint = ''
          Style = tbsContainer
          Caption = 'UnimToolButton4'
        end
        object cntProducts: TUnimToolButton
          Left = 48
          Top = 0
          Width = 410
          Height = 48
          Hint = ''
          Style = tbsContainer
          Caption = 'cntProducts'
          object dbnProducts: TUnimDBNavigator
            Left = 0
            Top = 4
            Width = 340
            Height = 42
            Hint = ''
            DataSource = dmOrders.dsProducts
            VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
            TabOrder = 1
          end
        end
      end
      object dbgProducts: TUnimDBGrid
        Left = 1
        Top = 49
        Width = 766
        Height = 927
        Hint = ''
        Align = alClient
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dmOrders.dsProducts
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete]
        Columns = <
          item
            Title.Alignment = taCenter
            Title.Caption = 'ID'
            Title.Font.Height = -21
            FieldName = 'ID'
            Visible = False
            Width = 114
          end
          item
            Title.Alignment = taCenter
            Title.Caption = 'Description'
            Title.Font.Height = -21
            FieldName = 'Description'
            Width = 360
          end
          item
            Title.Alignment = taCenter
            Title.Caption = 'Price'
            Title.Font.Height = -21
            FieldName = 'Price'
            Width = 118
          end>
      end
    end
  end
end
