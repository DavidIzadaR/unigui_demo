object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 654
  ClientWidth = 923
  Caption = 'Order Management System'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'border'
  PixelsPerInch = 96
  TextHeight = 13
  object UniToolBar1: TUniToolBar
    Left = 0
    Top = 0
    Width = 923
    Height = 65
    Hint = ''
    ButtonHeight = 64
    ButtonWidth = 82
    Images = UniMainModule.UniNativeImageList1
    BorderWidth = 2
    ShowCaptions = True
    LayoutConfig.Region = 'north'
    Layout = 'absolute'
    Anchors = [akLeft, akTop, akRight]
    Align = alTop
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    object btnMicro: TUniToolButton
      Left = 0
      Top = 0
      Hint = ''
      ImageIndex = 0
      Caption = 'Micro/Macro'
      TabOrder = 1
      OnClick = btnMicroClick
    end
    object btnEditUsers: TUniToolButton
      Left = 82
      Top = 0
      Action = UniMainModule.actEditOperators
      ImageIndex = 1
      TabOrder = 2
    end
    object btnEditOrders: TUniToolButton
      Left = 164
      Top = 0
      Action = UniMainModule.actEditOrders
      ImageIndex = 2
      TabOrder = 3
    end
    object btnReportSales: TUniToolButton
      Left = 246
      Top = 0
      Action = UniMainModule.actReportSales
      ImageIndex = 5
      TabOrder = 4
    end
  end
  object UniStatusBar1: TUniStatusBar
    Left = 0
    Top = 632
    Width = 923
    Hint = ''
    Panels = <
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
    SizeGrip = False
    Align = alBottom
    Anchors = [akLeft, akRight, akBottom]
    LayoutConfig.Region = 'south'
    ParentColor = False
    Color = clWindow
  end
  object UniTreeMenu1: TUniTreeMenu
    Left = 0
    Top = 65
    Width = 225
    Height = 567
    Hint = ''
    Anchors = [akLeft, akTop, akBottom]
    Items.FontData = {0100000000}
    LayoutConfig.Region = 'west'
    Images = UniMainModule.UniNativeImageList1
    SourceMenu = UniMainModule.UniMenuItems1
    OnSelectionChange = UniTreeMenu1SelectionChange
  end
  object UniPageControl1: TUniPageControl
    Left = 225
    Top = 65
    Width = 698
    Height = 567
    Hint = ''
    ActivePage = UniTabSheet1
    Images = UniMainModule.UniNativeImageList1
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    LayoutConfig.Region = 'center'
    TabOrder = 3
    object UniTabSheet1: TUniTabSheet
      Hint = ''
      Caption = 'UniTabSheet1'
      Layout = 'fit'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 256
      ExplicitHeight = 128
    end
  end
  object UniTimer1: TUniTimer
    Interval = 10000
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 424
    Top = 248
  end
end
