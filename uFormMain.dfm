object formMain: TformMain
  Left = 0
  Top = 0
  Align = alClient
  Caption = #1050#1088#1086#1089#1089
  ClientHeight = 401
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheel = FormMouseWheel
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 584
    Top = 216
    object N1: TMenuItem
      Caption = #1056#1077#1078#1080#1084
      object menuOffline: TMenuItem
        Caption = #1054#1073#1091#1095#1077#1085#1080#1077' ('#1086#1092#1092#1083#1072#1081#1085')'
        OnClick = menuOfflineClick
      end
      object menuOnline: TMenuItem
        Caption = #1047#1072#1076#1072#1095#1072' '#8470'20 ('#1086#1085#1083#1072#1081#1085')'
        OnClick = menuOnlineClick
      end
    end
    object N3: TMenuItem
      Caption = #1054#1082#1085#1072
      object N4: TMenuItem
        AutoCheck = True
        Caption = #1053#1072#1074#1080#1075#1072#1090#1086#1088
        Checked = True
        OnClick = N4Click
      end
      object N5: TMenuItem
        AutoCheck = True
        Caption = #1050#1086#1085#1089#1086#1083#1100
        Checked = True
        OnClick = N5Click
      end
      object N6: TMenuItem
        AutoCheck = True
        Caption = #1057#1074#1103#1079#1100
        OnClick = N6Click
      end
      object N7: TMenuItem
        AutoCheck = True
        Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082' '#1089#1077#1088#1074#1077#1088#1091
        OnClick = N7Click
      end
    end
  end
end
