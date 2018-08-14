object dmProdutos: TdmProdutos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 254
  Width = 428
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Port=3308'
      'Database=tmp_db'
      'User_Name=root'
      'Password=masterkey'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 40
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files (x86)\MySQL\MySQL Server 5.5\lib\libmysql.dll'
    Left = 56
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 56
    Top = 144
  end
  object qryCategorias: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'Select * From Tb_Cat_Produtos;')
    Left = 192
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = qryCategorias
    OnDataChange = DataSource1DataChange
    Left = 256
    Top = 64
  end
  object qrySubCategorias: TFDQuery
    Connection = FDConnection1
    Left = 336
    Top = 64
  end
  object qryProdutos: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'Select c.CATEGORIA, s.SUBCATEGORIA, P.* From TB_PRODUTOS p Inner' +
        ' Join'
      
        '   TB_SUB_CAT_PRODUTOS s On (p.COD_CAT_SUB_CAT = s.COD_CAT_SUB_C' +
        'AT) Inner Join'
      
        '   TB_CAT_PRODUTOS c on (s.COD_CATEGORIA = c.CODIGO) Order By CA' +
        'TEGORIA, SUBCATEGORIA, PRODUTO;')
    Left = 216
    Top = 168
  end
end
