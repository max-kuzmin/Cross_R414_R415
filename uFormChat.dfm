object formChat: TformChat
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = #1056#1072#1079#1075#1086#1074#1086#1088
  ClientHeight = 184
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 387
    Height = 140
    Align = alClient
    Caption = #1057#1074#1103#1079#1100':'
    TabOrder = 0
    object Memo1: TMemo
      Left = 2
      Top = 15
      Width = 383
      Height = 91
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object GroupBox3: TGroupBox
      Left = 2
      Top = 106
      Width = 383
      Height = 32
      Align = alBottom
      TabOrder = 1
      object Edit1: TEdit
        Left = 3
        Top = 6
        Width = 285
        Height = 21
        TabOrder = 0
      end
      object Button1: TButton
        Left = 294
        Top = 3
        Width = 75
        Height = 25
        Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
        Enabled = False
        TabOrder = 1
        OnClick = Button1Click
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 387
    Top = 0
    Width = 64
    Height = 140
    Align = alRight
    Caption = #1058#1088#1091#1073#1082#1072':'
    TabOrder = 1
    object rbPiuB: TRadioButton
      Left = 6
      Top = 17
      Width = 113
      Height = 17
      Caption = #1055#1048#1059'-'#1041
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbPSSBM: TRadioButton
      Left = 6
      Top = 40
      Width = 113
      Height = 17
      Caption = #1055#1057#1057'-'#1041#1052
      TabOrder = 1
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 140
    Width = 451
    Height = 44
    Align = alBottom
    Caption = #1057#1086#1073#1077#1089#1077#1076#1085#1080#1082#1080':'
    TabOrder = 2
    object Label1: TLabel
      Left = 5
      Top = 18
      Width = 62
      Height = 13
      Caption = #1053#1072#1096#1072' '#1056'-414:'
    end
    object Label2: TLabel
      Left = 208
      Top = 18
      Width = 126
      Height = 13
      Caption = #1050#1088#1086#1089#1089' '#1089' '#1076#1088#1091#1075#1086#1081' '#1089#1090#1086#1088#1086#1085#1099':'
    end
    object Label3: TLabel
      Left = 73
      Top = 18
      Width = 48
      Height = 13
      Caption = #1054#1092#1092#1083#1072#1081#1085
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label4: TLabel
      Left = 340
      Top = 18
      Width = 48
      Height = 13
      Caption = #1054#1092#1092#1083#1072#1081#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object rb1r414: TRadioButton
      Left = 127
      Top = 15
      Width = 20
      Height = 17
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rb1cross: TRadioButton
      Left = 394
      Top = 15
      Width = 20
      Height = 17
      TabOrder = 1
    end
  end
end
