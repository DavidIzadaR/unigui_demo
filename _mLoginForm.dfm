object mLoginForm: TmLoginForm
  Left = 0
  Top = 0
  ClientHeight = 977
  ClientWidth = 600
  Caption = 'Login Form'
  TitleButtons = <>
  OnCreate = UnimLoginFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  DesignOrientation = True
  ScrollPosition = 0
  ScrollHeight = 47
  PlatformData = {}
  object UnimFieldSet1: TUnimFieldSet
    Left = 0
    Top = 0
    Width = 600
    Height = 913
    Hint = ''
    Title = 'Enter Credentials'
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    DesignSize = (
      600
      913)
    object edtUsername: TUnimEdit
      Left = 48
      Top = 40
      Width = 505
      Height = 47
      Hint = ''
      Anchors = [akLeft, akTop, akRight]
      Text = ''
      FieldLabel = 'Username'
      FieldLabelAlign = laTop
    end
    object edtPassword: TUnimEdit
      Left = 48
      Top = 128
      Width = 505
      Height = 47
      Hint = ''
      Anchors = [akLeft, akTop, akRight]
      Text = 'edtPassword'
      PasswordChar = '*'
      FieldLabel = 'Password'
      FieldLabelAlign = laTop
    end
  end
  object UnimContainerPanel1: TUnimContainerPanel
    Left = 0
    Top = 913
    Width = 600
    Height = 64
    Hint = ''
    Align = alBottom
    Anchors = [akLeft, akRight, akBottom]
    DesignSize = (
      600
      64)
    object btnOK: TUnimButton
      Left = 11
      Top = 6
      Width = 105
      Height = 47
      Hint = ''
      Caption = 'OK'
      UI = 'confirm'
      OnClick = btnOKClick
    end
    object btnCancel: TUnimButton
      Left = 483
      Top = 6
      Width = 105
      Height = 47
      Hint = ''
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      UI = 'decline'
    end
  end
end
