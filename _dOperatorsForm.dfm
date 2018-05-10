object dOperatorsForm: TdOperatorsForm
  Left = 0
  Top = 0
  ClientHeight = 441
  ClientWidth = 495
  Caption = 'Users'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  LayoutConfig.Region = 'center'
  PixelsPerInch = 96
  TextHeight = 13
  object dbgCustomers: TUniDBGrid
    Left = 0
    Top = 36
    Width = 495
    Height = 405
    Hint = ''
    DataSource = dmUsers.dsUsers
    LoadMask.Message = 'Loading data...'
    LayoutConfig.Region = 'center'
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    Columns = <
      item
        FieldName = 'Username'
        Title.Alignment = taCenter
        Title.Caption = 'Username'
        Width = 100
      end
      item
        FieldName = 'Password'
        Title.Alignment = taCenter
        Title.Caption = 'Password'
        Width = 196
      end
      item
        FieldName = 'Role'
        Title.Alignment = taCenter
        Title.Caption = 'Role'
        Width = 304
      end>
  end
  object barTop: TUniToolBar
    Left = 0
    Top = 0
    Width = 495
    Height = 36
    Hint = ''
    ButtonHeight = 34
    ButtonWidth = 34
    Images = UniMainModule.UniNativeImageList1
    LayoutConfig.Region = 'north'
    Layout = 'border'
    Anchors = [akLeft, akTop, akRight]
    Align = alTop
    TabOrder = 1
    ParentColor = False
    Color = clBtnFace
    object btnToggleAdmin: TUniToolButton
      Left = 0
      Top = 0
      Action = dmUsers.actToggleAdmin
      ImageIndex = 3
      LayoutConfig.Region = 'west'
      TabOrder = 1
    end
    object cntUsers: TUniToolButton
      Left = 34
      Top = 0
      Width = 450
      Hint = ''
      Style = tbsContainer
      Caption = ''
      LayoutConfig.Region = 'east'
      LayoutConfig.Margin = '5px'
      Layout = 'border'
      TabOrder = 2
      object dbnCustomers: TUniDBNavigator
        Left = 209
        Top = 0
        Width = 241
        Height = 26
        Hint = ''
        DataSource = dmUsers.dsUsers
        LayoutConfig.Region = 'east'
        IconSet = icsFontAwesome
        TabOrder = 1
      end
    end
  end
end
