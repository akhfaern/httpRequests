object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'HTTP Requests'
  ClientHeight = 468
  ClientWidth = 669
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 36
    Height = 13
    Caption = 'Method'
  end
  object Label3: TLabel
    Left = 159
    Top = 56
    Width = 39
    Height = 13
    Caption = 'Protocol'
  end
  object edtURL: TEdit
    Left = 8
    Top = 24
    Width = 296
    Height = 21
    TabOrder = 0
    Text = 'http://localhost/test/test1.php'
  end
  object cmbRequestMethod: TComboBox
    Left = 8
    Top = 75
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = 'POST'
    Items.Strings = (
      'POST'
      'GET')
  end
  object cmbHttp: TComboBox
    Left = 159
    Top = 75
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'HTTP 1.1'
    Items.Strings = (
      'HTTP 1.1'
      'HTTP 1.0')
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 112
    Width = 296
    Height = 145
    Caption = 'Cookies'
    TabOrder = 3
    object lbCookieList: TListBox
      Left = 16
      Top = 24
      Width = 265
      Height = 81
      ItemHeight = 13
      TabOrder = 0
    end
    object btnAddCookie: TButton
      Left = 63
      Top = 111
      Width = 50
      Height = 21
      Caption = 'Add'
      TabOrder = 1
      OnClick = btnAddCookieClick
    end
    object btnRemoveCookie: TButton
      Left = 119
      Top = 111
      Width = 50
      Height = 21
      Caption = 'Remove'
      TabOrder = 2
      OnClick = btnRemoveCookieClick
    end
    object btnLoadCookieList: TButton
      Left = 231
      Top = 111
      Width = 50
      Height = 21
      Caption = 'Load'
      TabOrder = 3
      OnClick = btnLoadCookieListClick
    end
    object btnSaveCookieList: TButton
      Left = 175
      Top = 111
      Width = 50
      Height = 21
      Caption = 'Save'
      TabOrder = 4
      OnClick = btnSaveCookieListClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 263
    Width = 296
    Height = 145
    Caption = 'Params'
    TabOrder = 4
    object lbParamList: TListBox
      Left = 16
      Top = 24
      Width = 265
      Height = 81
      ItemHeight = 13
      TabOrder = 0
    end
    object btnAddParam: TButton
      Left = 63
      Top = 111
      Width = 50
      Height = 21
      Caption = 'Add'
      TabOrder = 1
      OnClick = btnAddParamClick
    end
    object btnRemoveParam: TButton
      Left = 119
      Top = 111
      Width = 50
      Height = 21
      Caption = 'Remove'
      TabOrder = 2
      OnClick = btnRemoveParamClick
    end
    object btnSaveParamList: TButton
      Left = 175
      Top = 111
      Width = 50
      Height = 21
      Caption = 'Save'
      TabOrder = 3
      OnClick = btnSaveParamListClick
    end
    object btnLoadParamList: TButton
      Left = 231
      Top = 111
      Width = 50
      Height = 21
      Caption = 'Load'
      TabOrder = 4
      OnClick = btnLoadParamListClick
    end
  end
  object btnRun: TButton
    Left = 148
    Top = 435
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 5
    OnClick = btnRunClick
  end
  object btnStop: TButton
    Left = 229
    Top = 435
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 6
    OnClick = btnStopClick
  end
  object Progress: TProgressBar
    Left = 8
    Top = 414
    Width = 296
    Height = 15
    TabOrder = 7
  end
  object GroupBox3: TGroupBox
    Left = 320
    Top = 18
    Width = 337
    Height = 175
    Caption = 'Save Options'
    TabOrder = 8
    object Label4: TLabel
      Left = 16
      Top = 112
      Width = 307
      Height = 11
      Caption = 
        'RegEx Example: <\s*div[^>]*>(.*?)<\s*/\s*div> (To match all div ' +
        'tags)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbSaveResultsToFile: TCheckBox
      Left = 12
      Top = 16
      Width = 121
      Height = 17
      Caption = 'Save Results To File'
      TabOrder = 0
    end
    object edtSaveFile: TEdit
      Left = 12
      Top = 39
      Width = 292
      Height = 21
      TabOrder = 1
    end
    object btnSelectSaveFile: TButton
      Left = 304
      Top = 38
      Width = 25
      Height = 23
      Caption = '...'
      TabOrder = 2
      OnClick = btnSelectSaveFileClick
    end
    object cbFilterRegEx: TCheckBox
      Left = 12
      Top = 64
      Width = 145
      Height = 17
      Caption = 'Filter Results with RegEx'
      TabOrder = 3
    end
    object edtRegEx: TEdit
      Left = 12
      Top = 86
      Width = 317
      Height = 21
      TabOrder = 4
    end
    object cbIgnoreCase: TCheckBox
      Left = 12
      Top = 125
      Width = 97
      Height = 17
      Caption = 'Ignore Case'
      TabOrder = 5
    end
    object cbExplicitCapture: TCheckBox
      Left = 12
      Top = 144
      Width = 97
      Height = 17
      Caption = 'Explicit Capture'
      TabOrder = 6
    end
    object cbMultiLine: TCheckBox
      Left = 120
      Top = 125
      Width = 74
      Height = 17
      Caption = 'Multi Line'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object cbCompiled: TCheckBox
      Left = 120
      Top = 144
      Width = 74
      Height = 17
      Caption = 'Compiled'
      TabOrder = 8
    end
    object cbSingleLine: TCheckBox
      Left = 200
      Top = 125
      Width = 97
      Height = 17
      Caption = 'Single Line'
      TabOrder = 9
    end
    object cbIgnorePatternSpace: TCheckBox
      Left = 200
      Top = 144
      Width = 121
      Height = 17
      Caption = 'IgnorePatternSpace'
      TabOrder = 10
    end
  end
  object GroupBox4: TGroupBox
    Left = 320
    Top = 199
    Width = 340
    Height = 261
    Caption = 'Results'
    TabOrder = 9
    object memDebug: TMemo
      Left = 12
      Top = 16
      Width = 317
      Height = 213
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object btnClearResults: TButton
      Left = 261
      Top = 235
      Width = 75
      Height = 21
      Caption = 'Clear'
      TabOrder = 1
      OnClick = btnClearResultsClick
    end
  end
  object IdHTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    CookieManager = IdCookieManager
    Left = 80
    Top = 104
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Text Files (*.txt)|*.txt'
    Left = 200
    Top = 48
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'Text Files (*.txt)|*.txt'
    Left = 88
    Top = 48
  end
  object IdCookieManager: TIdCookieManager
    Left = 152
    Top = 112
  end
end
