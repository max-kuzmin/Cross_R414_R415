object formConnectToServer: TformConnectToServer
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103':'
  ClientHeight = 81
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 398
    Height = 73
    Align = alTop
    Caption = #1054#1089#1085#1086#1074#1085#1086#1077':'
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 16
      Width = 54
      Height = 13
      Caption = #1055#1086#1079#1099#1074#1085#1086#1081':'
    end
    object Label2: TLabel
      Left = 167
      Top = 16
      Width = 14
      Height = 13
      Caption = 'IP:'
    end
    object Label3: TLabel
      Left = 288
      Top = 16
      Width = 29
      Height = 13
      Caption = #1055#1086#1088#1090':'
    end
    object Edit1: TEdit
      Left = 71
      Top = 13
      Width = 90
      Height = 21
      TabOrder = 0
      Text = #1055#1077#1090#1091#1093
    end
    object Edit2: TEdit
      Left = 187
      Top = 13
      Width = 95
      Height = 21
      TabOrder = 1
      Text = '127.0.0.1'
    end
    object Edit3: TEdit
      Left = 323
      Top = 13
      Width = 65
      Height = 21
      TabOrder = 2
      Text = '2106'
    end
    object Button1: TButton
      Left = 11
      Top = 40
      Width = 94
      Height = 25
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 294
      Top = 40
      Width = 94
      Height = 25
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
      Enabled = False
      TabOrder = 4
      OnClick = Button2Click
    end
  end
end
