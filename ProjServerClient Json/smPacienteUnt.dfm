object SM1: TSM1
  Height = 436
  Width = 764
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\dev006\Documents\PostgreSQL\psqlodbc_12_02_0000\psqlodb' +
      'c\libpq.dll'
    Left = 208
    Top = 64
  end
  object fdqExames: TFDQuery
    Connection = FDConnection1
    Left = 408
    Top = 224
  end
  object fdqDados: TFDQuery
    Connection = FDConnection1
    Left = 192
    Top = 224
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Connection = FDConnection1
    Left = 304
    Top = 160
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=postgres'
      'User_Name=postgres'
      'Password=postgre'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    Left = 64
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 512
    Top = 104
  end
end
