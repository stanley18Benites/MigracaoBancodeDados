object frmConsulta: TfrmConsulta
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 682
  ClientWidth = 1315
  Color = 13290186
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object panel1: TPanel
    Left = 0
    Top = 0
    Width = 1315
    Height = 682
    Align = alClient
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object pnlFull: TPanel
      Left = 198
      Top = 84
      Width = 559
      Height = 558
      BevelOuter = bvNone
      Color = clMedGray
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 213
        Top = 70
        Width = 114
        Height = 13
        Caption = 'TABELA SELECIONADA:'
      end
      object Label1: TLabel
        Left = 13
        Top = 70
        Width = 153
        Height = 13
        Caption = 'TABELAS DO BANCO DE DADOS'
      end
      object label_nomeTabSelecionada: TLabel
        Left = 336
        Top = 72
        Width = 288
        Height = 13
        AutoSize = False
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 559
        Height = 66
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Tabelas do Banco de dados de terceiro'
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
      end
      object DBGrid1: TDBGrid
        Left = 213
        Top = 90
        Width = 341
        Height = 458
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = DBGrid1CellClick
        OnDragOver = DBGrid1DragOver
      end
      object DBGrid5: TDBGrid
        Left = 13
        Top = 90
        Width = 194
        Height = 458
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = DBGrid5CellClick
      end
    end
    object Panel3: TPanel
      Left = 1081
      Top = 84
      Width = 208
      Height = 125
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object dbGridMySQL: TDBGrid
        Left = 5
        Top = 4
        Width = 193
        Height = 115
        FixedColor = clSilver
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbGridMySQLCellClick
      end
    end
    object Panel4: TPanel
      Left = 189
      Top = 1
      Width = 1137
      Height = 70
      Align = alCustom
      BevelOuter = bvNone
      Caption = 'Configuracao'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clScrollBar
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
    end
    object Panel6: TPanel
      Left = 777
      Top = 84
      Width = 291
      Height = 558
      BevelOuter = bvNone
      Color = clMedGray
      ParentBackground = False
      TabOrder = 3
      object DBGrid6: TDBGrid
        Left = 146
        Top = 49
        Width = 128
        Height = 465
        BorderStyle = bsNone
        Color = clGrayText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 291
        Height = 43
        Align = alTop
        BevelOuter = bvNone
        Caption = 'TABELAS PARA CONVERSAO'
        ParentBackground = False
        ParentColor = True
        TabOrder = 1
      end
      object Panel9: TPanel
        Left = 12
        Top = 49
        Width = 130
        Height = 465
        BevelOuter = bvNone
        TabOrder = 2
        object StringGrid1: TStringGrid
          Left = 3
          Top = 19
          Width = 128
          Height = 442
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = cl3DDkShadow
          ColCount = 1
          DefaultColWidth = 125
          DefaultRowHeight = 15
          FixedCols = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          OnDragDrop = StringGrid1DragDrop
          OnDragOver = StringGrid1DragOver
        end
      end
      object StatusBar1: TStatusBar
        Left = 15
        Top = 518
        Width = 259
        Height = 19
        Align = alNone
        Panels = <>
      end
    end
    object pnlLateral: TPanel
      Left = 1
      Top = 2
      Width = 186
      Height = 640
      Align = alCustom
      BevelOuter = bvNone
      Color = clMedGray
      ParentBackground = False
      TabOrder = 4
      OnMouseMove = pnlLateralMouseMove
      object Panel5: TPanel
        Left = 30
        Top = 518
        Width = 112
        Height = 46
        Align = alCustom
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object SpeedButton2: TSpeedButton
          Left = 0
          Top = 0
          Width = 112
          Height = 46
          Align = alClient
          Caption = 'TRANSFERIR'
          Flat = True
          OnClick = SpeedButton2Click
          OnMouseMove = SpeedButton1MouseMoveSpeedButton1MouseMoveSpeedButton2MouseMove
          ExplicitTop = 5
        end
      end
      object Panel8: TPanel
        Left = 30
        Top = 569
        Width = 112
        Height = 46
        Align = alCustom
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        object SpeedButton1: TSpeedButton
          Left = 0
          Top = 0
          Width = 112
          Height = 46
          Align = alClient
          Caption = 'FECHAR'
          Flat = True
          OnClick = SpeedButton1Click
          OnMouseMove = SpeedButton1MouseMove
          ExplicitTop = -7
        end
      end
    end
    object StringGrid2: TStringGrid
      Left = 1123
      Top = 215
      Width = 128
      Height = 395
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = cl3DDkShadow
      ColCount = 1
      DefaultColWidth = 125
      DefaultRowHeight = 15
      FixedCols = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 5
      OnDragDrop = StringGrid1DragDrop
      OnDragOver = StringGrid1DragOver
    end
  end
end
