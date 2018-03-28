object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 300
  ClientWidth = 619
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
  object Label1: TLabel
    Left = 56
    Top = 216
    Width = 101
    Height = 13
    Caption = 'Nombre de boucles : '
  end
  object Edit1: TEdit
    Left = 56
    Top = 32
    Width = 505
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 56
    Top = 72
    Width = 233
    Height = 25
    Caption = 'Test assembleur '
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 56
    Top = 128
    Width = 233
    Height = 25
    Caption = 'Test Pascal'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 163
    Top = 213
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '10000000'
  end
  object Memo1: TMemo
    Left = 344
    Top = 72
    Width = 217
    Height = 220
    TabOrder = 4
  end
end
