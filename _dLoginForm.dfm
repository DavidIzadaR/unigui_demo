object dLoginForm: TdLoginForm
  Left = 0
  Top = 0
  ClientHeight = 157
  ClientWidth = 380
  Caption = 'Login Form'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Layout = 'form'
  OnCreate = UniLoginFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniContainerPanel1: TUniContainerPanel
    Left = 0
    Top = 106
    Width = 380
    Height = 51
    Hint = ''
    ParentColor = False
    Align = alBottom
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 0
    ExplicitTop = 121
    object UniFieldContainer1: TUniFieldContainer
      Left = 0
      Top = 0
      Width = 380
      Height = 51
      Hint = ''
      ParentColor = False
      Align = alClient
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 1
      Layout = 'table'
      LayoutAttribs.Columns = 2
      DesignSize = (
        380
        51)
      object btnOk: TUniButton
        Left = 46
        Top = 9
        Width = 75
        Height = 28
        Hint = ''
        Caption = 'OK'
        Anchors = [akLeft, akTop, akBottom]
        TabOrder = 1
        OnClick = btnOkClick
      end
      object btnCancel: TUniButton
        Left = 266
        Top = 9
        Width = 75
        Height = 28
        Hint = ''
        Caption = 'Cancel'
        ModalResult = 2
        Anchors = [akTop, akRight, akBottom]
        TabOrder = 2
      end
    end
  end
  object UniFieldSet1: TUniFieldSet
    Left = 0
    Top = 0
    Width = 380
    Height = 106
    Hint = ''
    Title = 'Enter Credentials'
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    Layout = 'form'
    LayoutConfig.Region = 'center'
    TabOrder = 1
    ExplicitHeight = 121
    object edtUsername: TUniEdit
      Left = 40
      Top = 20
      Width = 121
      Hint = ''
      Text = ''
      TabOrder = 1
      ClearButton = True
      FieldLabel = 'Username'
    end
    object edtPassword: TUniEdit
      Left = 40
      Top = 62
      Width = 121
      Hint = ''
      PasswordChar = '*'
      Text = ''
      TabOrder = 2
      ClearButton = True
      FieldLabel = 'Password'
    end
  end
end
