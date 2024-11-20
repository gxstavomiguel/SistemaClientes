object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 295
  Width = 603
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=alex'
      'User_Name=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object driver: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\352b\Gustavo_Miguel_e_Joao_Lucas\sistemadeclientes\lib\libmyS' +
      'QL.dll'
    Left = 104
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 176
    Top = 24
  end
  object tb_clientes: TFDTable
    IndexFieldNames = 'game_id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'alex.games'
    TableName = 'alex.games'
    Left = 32
    Top = 152
    object tb_clientesgame_id: TFDAutoIncField
      FieldName = 'game_id'
      Origin = 'game_id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tb_clientesgame_nome: TStringField
      FieldName = 'game_nome'
      Origin = 'game_nome'
      Required = True
      Size = 50
    end
    object tb_clientesgame_desenvolvedor: TStringField
      FieldName = 'game_desenvolvedor'
      Origin = 'game_desenvolvedor'
      Required = True
      Size = 100
    end
    object tb_clientesgame_distribuidor: TStringField
      FieldName = 'game_distribuidor'
      Origin = 'game_distribuidor'
      Required = True
      Size = 100
    end
    object tb_clientesgame_genero: TStringField
      FieldName = 'game_genero'
      Origin = 'game_genero'
      Required = True
      Size = 50
    end
    object tb_clientesgame_plataforma: TStringField
      FieldName = 'game_plataforma'
      Origin = 'game_plataforma'
      Required = True
      Size = 30
    end
    object tb_clientesgame_data: TDateField
      FieldName = 'game_data'
      Origin = 'game_data'
      Required = True
      EditMask = '!99/99/0000;1;_'
    end
    object tb_clientesgame_preco: TStringField
      FieldName = 'game_preco'
      Origin = 'game_preco'
      Required = True
      Size = 10
    end
    object tb_clientesgame_imagem: TBlobField
      FieldName = 'game_imagem'
      Origin = 'game_imagem'
      Required = True
    end
  end
  object DataSource1: TDataSource
    DataSet = tb_clientes
    Left = 96
    Top = 152
  end
  object SQL_imprimir_cliente: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from games')
    Left = 424
    Top = 160
  end
  object SQL_con_cliente: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from games')
    Left = 192
    Top = 152
  end
  object DS_con_cliente: TDataSource
    DataSet = SQL_con_cliente
    Left = 272
    Top = 152
  end
end
