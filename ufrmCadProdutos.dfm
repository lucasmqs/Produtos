object frmCadProdutos: TfrmCadProdutos
  Left = 0
  Top = 0
  Caption = 'CADASTRAR - Produtos'
  ClientHeight = 452
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 63
    Height = 13
    Caption = 'CATEGORIA:'
  end
  object Label2: TLabel
    Left = 32
    Top = 73
    Width = 82
    Height = 13
    Caption = 'SUBCATEGORIA:'
  end
  object Label3: TLabel
    Left = 32
    Top = 122
    Width = 53
    Height = 13
    Caption = 'PRODUTO:'
  end
  object Label4: TLabel
    Left = 32
    Top = 173
    Width = 63
    Height = 13
    Caption = 'DESCRI'#199#195'O:'
  end
  object Label6: TLabel
    Left = 32
    Top = 290
    Width = 111
    Height = 13
    Caption = 'QUANTIDADE M'#205'NIMA:'
  end
  object Label7: TLabel
    Left = 32
    Top = 344
    Width = 90
    Height = 13
    Caption = 'VALOR UNIT'#193'RIO:'
  end
  object Label5: TLabel
    Left = 32
    Top = 222
    Width = 147
    Height = 13
    Caption = 'CARACTER'#205'STICAS T'#201'CNICAS'
  end
  object btnOk: TSpeedButton
    Left = 32
    Top = 380
    Width = 137
    Height = 51
    Caption = 'OK'
    Enabled = False
    OnClick = btnOkClick
  end
  object btnCancelar: TSpeedButton
    Left = 184
    Top = 380
    Width = 137
    Height = 51
    Caption = 'CANCELAR'
    OnClick = btnCancelarClick
  end
  object cbxCategoria: TComboBox
    Left = 32
    Top = 40
    Width = 289
    Height = 21
    TabOrder = 0
    OnChange = cbxCategoriaChange
  end
  object cbxSubCategoria: TComboBox
    Left = 32
    Top = 89
    Width = 289
    Height = 21
    TabOrder = 1
    OnChange = cbxSubCategoriaChange
  end
  object edtProduto: TEdit
    Left = 32
    Top = 138
    Width = 289
    Height = 21
    TabOrder = 2
  end
  object edtDescricao: TEdit
    Left = 32
    Top = 188
    Width = 289
    Height = 21
    TabOrder = 3
  end
  object edtCaracteristicasTecnicas: TEdit
    Left = 32
    Top = 237
    Width = 289
    Height = 21
    TabOrder = 4
  end
  object edtQtdMinima: TEdit
    Left = 200
    Top = 286
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object edtVlrUnitario: TEdit
    Left = 200
    Top = 336
    Width = 121
    Height = 21
    TabOrder = 6
  end
end
