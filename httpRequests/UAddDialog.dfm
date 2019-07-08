object FrmAddDialog: TFrmAddDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Dialog'
  ClientHeight = 130
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 18
    Height = 13
    Caption = 'Key'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 26
    Height = 13
    Caption = 'Value'
  end
  object edtKey: TEdit
    Left = 16
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtValue: TEdit
    Left = 16
    Top = 72
    Width = 265
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 230
    Top = 99
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 149
    Top = 99
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object cbFile: TCheckBox
    Left = 152
    Top = 32
    Width = 97
    Height = 17
    Caption = 'Use File as Value'
    TabOrder = 4
    OnClick = cbFileClick
  end
  object btnSelectFile: TButton
    Left = 280
    Top = 71
    Width = 25
    Height = 23
    Caption = '...'
    TabOrder = 5
    Visible = False
    OnClick = btnSelectFileClick
  end
end
