object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 430
  ClientWidth = 924
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object Get: TButton
    Left = 8
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 0
    OnClick = GetClick
  end
  object Post: TButton
    Left = 94
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Post'
    TabOrder = 1
    OnClick = PostClick
  end
  object Put: TButton
    Left = 296
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Put'
    TabOrder = 2
    OnClick = PutClick
  end
  object Delete: TButton
    Left = 392
    Top = 97
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = DeleteClick
  end
  object Consultar: TButton
    Left = 175
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 48
    Top = 8
    Width = 121
    Height = 23
    TabOrder = 5
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 48
    Top = 37
    Width = 121
    Height = 23
    TabOrder = 6
    Text = 'Edit2'
  end
  object Memo1: TMemo
    Left = 473
    Top = 97
    Width = 435
    Height = 266
    Lines.Strings = (
      'Memo1')
    TabOrder = 7
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 128
    Width = 459
    Height = 235
    DataSource = DataSource1
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object Edit3: TEdit
    Left = 48
    Top = 68
    Width = 121
    Height = 23
    TabOrder = 9
    Text = 'Edit3'
  end
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 344
    Top = 16
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 448
    Top = 8
  end
  object RESTResponse1: TRESTResponse
    Left = 560
    Top = 16
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 728
    Top = 336
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = FDMemTable1
    ScopeMappings = <>
    Left = 600
    Top = 328
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'result'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 696
    Top = 168
    Content = {
      4144425310000000EE020000FF00010001FF02FF03040016000000460044004D
      0065006D005400610062006C0065003100050016000000460044004D0065006D
      005400610062006C0065003100060000000000070000080032000000090000FF
      0AFF0B04000C00000072006500730075006C00740005000C0000007200650073
      0075006C0074000C00010000000E000D000F00FF000000100001110001120001
      13000114000115000116000C00000072006500730075006C0074001700FF0000
      00FEFEFF18FEFF19FEFF1AFF1B1C0000000000FF1D0000FE0100005B005B007B
      0022006900640070006500730073006F00610022003A002200310022002C0022
      006E006D007000720069006D006500690072006F0022003A0022005000610075
      006C006F0022002C0022006E006D0073006500670075006E0064006F0022003A
      00220046006100670075006E0064006500730022002C00220064007400720065
      00670069007300740072006F0022003A002200320031005C002F00300033005C
      002F00320030003200330022007D002C007B0022006900640070006500730073
      006F00610022003A002200320022002C0022006E006D007000720069006D0065
      00690072006F0022003A0022004A006F0061006F0022002C0022006E006D0073
      006500670075006E0064006F0022003A002200530065007600650072006F0022
      002C0022006400740072006500670069007300740072006F0022003A00220032
      0031005C002F00300031005C002F00320030003200330022007D002C007B0022
      006900640070006500730073006F00610022003A002200330022002C0022006E
      006D007000720069006D006500690072006F0022003A00220050006500640072
      006F0022002C0022006E006D0073006500670075006E0064006F0022003A0022
      00500065007200660022002C0022006400740072006500670069007300740072
      006F0022003A002200300031005C002F00300039005C002F00FEFEFEFEFEFF1E
      FEFF1F200028000000FF21FEFEFE0E004D0061006E0061006700650072001E00
      5500700064006100740065007300520065006700690073007400720079001200
      5400610062006C0065004C006900730074000A005400610062006C0065000800
      4E0061006D006500140053006F0075007200630065004E0061006D0065000A00
      54006100620049004400240045006E0066006F0072006300650043006F006E00
      730074007200610069006E00740073001E004D0069006E0069006D0075006D00
      43006100700061006300690074007900180043006800650063006B004E006F00
      74004E0075006C006C00140043006F006C0075006D006E004C00690073007400
      0C0043006F006C0075006D006E00100053006F00750072006300650049004400
      180064007400570069006400650053007400720069006E006700100044006100
      7400610054007900700065000800530069007A00650014005300650061007200
      63006800610062006C006500120041006C006C006F0077004E0075006C006C00
      0800420061007300650014004F0041006C006C006F0077004E0075006C006C00
      12004F0049006E0055007000640061007400650010004F0049006E0057006800
      6500720065001A004F0072006900670069006E0043006F006C004E0061006D00
      6500140053006F007500720063006500530069007A0065001C0043006F006E00
      730074007200610069006E0074004C0069007300740010005600690065007700
      4C006900730074000E0052006F0077004C00690073007400060052006F007700
      0A0052006F0077004900440010004F0072006900670069006E0061006C001800
      520065006C006100740069006F006E004C006900730074001C00550070006400
      61007400650073004A006F00750072006E0061006C0012005300610076006500
      50006F0069006E0074000E004300680061006E00670065007300}
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse2
    Left = 432
    Top = 368
  end
  object RESTClient2: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/datasnap/rest'
    ContentType = 'application/json'
    Params = <>
    SynchronizedEvents = False
    Left = 48
    Top = 368
  end
  object RESTRequest2: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient2
    Params = <
      item
      end>
    Resource = 'TServerMethods1/buscacliente/'
    Response = RESTResponse2
    SynchronizedEvents = False
    Left = 160
    Top = 368
  end
  object RESTResponse2: TRESTResponse
    ContentType = 'application/json'
    Left = 272
    Top = 368
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 688
    Top = 96
  end
end
