unit FRMCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope,
  Data.Bind.Components, REST.Client, Data.Bind.ObjectScope, REST.Response.Adapter, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.StorageBin;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Get: TButton;
    Post: TButton;
    Put: TButton;
    Delete: TButton;
    Consultar: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    FDMemTable1: TFDMemTable;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Edit3: TEdit;
    procedure EditKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure GetClick(Sender: TObject);
    procedure PostClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure CarregarRESTClient;
    procedure PutClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConsultarLB;
    procedure Gets;
    procedure Puts;
    procedure Posts;
    procedure Deletes;
  public
    { Public declarations }
    function GetClient: string;
  end;

var
  Form2: TForm4;

implementation

uses
  System.JSON, System.JSON.Writers, System.JSON.Types, REST.Utils, System.JSON.Readers, IdHTTP, REST.Json, ObjCliente;

{$R *.dfm}

procedure TForm4.CarregarRESTClient;
begin
  RESTClient2.ResetToDefaults;
  RESTRequest2.ResetToDefaults;
  RESTResponse2.ResetToDefaults;
  RESTClient2.BaseURL := 'http://localhost:211/datasnap/rest/TServerMethods1/';

  Memo1.Text := EmptyStr;
end;

procedure TForm4.ConsultarLB;
begin
  RESTRequest1.Params[0].Value := '0';
  RESTRequest1.Execute;
end;

procedure TForm4.EditKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = Ord(#13) then
    Get.OnClick(Self);
end;

procedure TForm4.GetClick(Sender: TObject);
begin
  //Gets;
  GetClient;
end;

function TForm4.GetClient: string;
var
  VItens : TItems;
  VJsonObject : TJSONObject;
  VJsonPar : TJSONPair;
  VJsonArray : TJSONArray;
  AUrl: string;
  AEnvio: TStringStream;
  AJsonResult: string;
  Http : TIdHTTP;
  DadosJSon : TJSONValue;
begin
  try

    Self.CarregarRESTClient;

    //RESTRequest2.Resource := '/GetClientes';
        RESTRequest2.Resource := '/BuscaCliente';

  //RESTClient2.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  //RESTClient2.AcceptCharset := 'UTF-8, *;q=0.8';
  //RESTClient2.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '5432']);
  //RESTClient2.ContentType := CONTENTTYPE_APPLICATION_JSON;
        RESTRequest2.Resource := '/pessoas/{id}';
  //RESTClient2.HandleRedirects := True;
  //RESTClient2.RaiseExceptionOn500 := False;
  //RESTRequest2.Client := RESTClient2;

    RESTRequest2.Method := TRESTRequestMethod.rmGET;

        RESTRequest2.Params.AddItem('idpessoa', '1', TRESTRequestParameterKind.pkURLSEGMENT, [], ctAPPLICATION_JSON);
        //RESTRequest2.Params.AddItem('caso', '1');

    //ShowMessage(RESTClient2.BaseURL);

    RESTRequest2.Execute;

      RESTResponse2.ContentType := CONTENTTYPE_APPLICATION_JSON; //

    VJsonObject := RESTResponse2.JSONValue as TJSONObject;

    VJsonPar := VJsonObject.Get(0);

    AJsonResult := TJson.Format(RESTResponse2.JSONValue);

    //ShowMessage(VJsonPar.ToString);
    TJSONObject.ParseJsonValue(RESTResponse2.Content.Trim);
    ShowMessage(RESTResponse2.Content.Trim);

    VJsonArray := VJsonPar.JsonValue as TJSONArray;

    //VCliente := TJson.JsonToObject<TCliente>(VJsonArray.Get(0).ToJSON);
    //VCliente := TJson.JsonToObject<TCliente>(VJsonArray.Get(0).ToJSON);

    //Edit1.Text := VCliente.Id.ToString;
    //Edit2.Text := VCliente.Nome;

    Memo1.Lines.Clear;
    //Memo1.Lines := VCliente.Id.ToString;
    //Memo1.Lines := VCliente.Nome;

    Memo1.Lines.Append(AJsonResult);
    //Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest2.Method));
    //Memo1.Lines.Append(RESTResponse2.Content);

  finally
    VItens.Free;
  end;
end;

procedure TForm4.Gets;
var
  SR: TStringReader;
  JR: TJsonTextReader;
begin//Update na �tica do Delphi e Insert no REST *Universal
  if Edit1.Text = EmptyStr then
    Edit1.Text := '0';

  {
  RESTClient2.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient2.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient2.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '5432']);
  RESTClient2.ContentType := CONTENTTYPE_APPLICATION_JSON;
  }
  RESTRequest2.Resource := '/Paciente/{id}';
  //RESTClient2.HandleRedirects := True;
  //RESTClient2.RaiseExceptionOn500 := False;
  RESTRequest2.Client := RESTClient2;
  RESTRequest2.Method := TRESTRequestMethod.rmGET;
  RESTRequest2.Params.AddItem('id', URIEncode(Edit1.Text), TRESTRequestParameterKind.pkURLSEGMENT);
  RESTRequest2.Execute;

  RESTResponse2.ContentType := CONTENTTYPE_APPLICATION_JSON;

  Memo1.Lines.Clear;
  Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest2.Method));
  Memo1.Lines.Append(RESTResponse2.Content);

  //  Utilizando JSON READERS - System.JSON.Readers  RESTClient2.ResetToDefaults;
  SR := TStringReader.Create(RESTResponse2.Content);
  JR := TJsonTextReader.Create(SR);
  RESTResponse2.ResetToDefaults;
  try  RESTClient2.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    try  RESTClient2.AcceptCharset := 'UTF-8, *;q=0.8';
      while JR.Read do
        if JR.TokenType = TJsonToken.PropertyName then
        begin  RESTClient2.HandleRedirects := True;
          if JR.Value.ToString = 'NOME' then
          begin  RESTRequest2.Client := RESTClient2;
            JR.Read;  RESTRequest2.Method := rmPOST;
            Edit2.Text := JR.Value.ToString;
          end;
        end;
    finally
      JR.Free;
    end;
  finally
    SR.Free;
  end;

end;

procedure TForm4.PostClick(Sender: TObject);
begin
  Posts;
end;

procedure TForm4.Posts;
//Update na �tica do Delphi e Insert no REST *Universal
var
  t: TStringWriter;
  Jw: TJsonTextWriter;
begin

  if Edit1.Text = EmptyStr then
    Edit1.Text := '0';

  t := TStringWriter.Create;

  //  Utilizando JSON WRITER - System.JSON.Writers
  Jw := TJsonTextWriter.Create(t);
  jw.Formatting := TJsonFormatting.None;     //Indented;
  jw.WriteStartObject;
  jw.WritePropertyName('idpessoa');
  jw.WriteValue(Edit1.Text);
  jw.WritePropertyName('nmprimeiro');
  jw.WriteValue(Edit2.Text);
  jw.WriteEndObject;
  Memo1.Lines.Clear;
  Memo1.Lines.Append(t.ToString);

  RESTClient2.ResetToDefaults;
  RESTRequest2.ResetToDefaults;
  RESTResponse2.ResetToDefaults;
  RESTClient2.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient2.AcceptCharset := 'UTF-8, *;q=0.8';
  //RESTClient2.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '5432']);
  RESTClient2.ContentType := 'application/json';
  RESTClient2.HandleRedirects := True;
  RESTClient2.RaiseExceptionOn500 := False;


  Self.CarregarRESTClient;

  RESTRequest2.Client := RESTClient2;
  RESTRequest2.Method := rmPOST;

  //RESTRequest2.Params.AddItem('JPaciente', t.ToString, TRESTRequestParameterKind.pkREQUESTBODY, [poDoNotEncode], ctAPPLICATION_JSON);
  RESTRequest2.Params.AddItem('AJsonDados', '1', TRESTRequestParameterKind.pkURLSEGMENT, [poDoNotEncode], ctAPPLICATION_JSON);

  RESTRequest2.Resource := '/Post/';
  RESTRequest2.Response := RESTResponse2;
  RESTRequest2.SynchronizedEvents := False;
  RESTRequest2.Execute;

  Memo1.Lines.Clear;
  Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest2.Method));
  Memo1.Lines.Append(RESTResponse2.Content);

end;

procedure TForm4.PutClick(Sender: TObject);
begin
  Puts;
end;

procedure TForm4.Puts;
//Insert na �tica do Delphi e Update no REST *Universal
var
  JO: TJSONObject;
begin

  RESTClient2.ResetToDefaults;
  RESTRequest2.ResetToDefaults;
  RESTResponse2.ResetToDefaults;

  Self.CarregarRESTClient;

  JO := TJSONObject.Create;
  JO.AddPair('nmprimeiro', Edit1.Text);
  //JO.AddPair('nome', Edit2.Text);
  //JO.AddPair('cep', Edit3.Text);


  //RESTClient2.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  //RESTClient2.AcceptCharset := 'UTF-8, *;q=0.8';
  //RESTClient2.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '5432']);

  RESTClient2.ContentType := 'application/json';
  RESTRequest2.Resource := '/InserirDados/';

  //RESTClient2.HandleRedirects := True;
  //RESTClient2.RaiseExceptionOn500 := False;

  RESTRequest2.Client := RESTClient2;
  RESTRequest2.Method := TRESTRequestMethod.rmPut;

  //RESTRequest2.Body.Add(JO.ToString, ContentTypeFromString('application/json'));
  RestRequest2.Params.AddUrlSegment('nmprimeiro', Edit1.Text);
  RESTRequest2.Params.ParameterByName('nmprimeiro').Value := Edit1.Text;
  //RESTRequest2.Params.AddItem('caso', '1', TRESTRequestParameterKind.pkURLSEGMENT, [], ctAPPLICATION_JSON);

  RESTRequest2.Execute;

  Memo1.Lines.Clear;
  Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest2.Method));
  Memo1.Lines.Append(JO.ToJSON);
  Memo1.Lines.Append(RESTResponse2.Content);

  JO.DisposeOf;

end;

procedure TForm4.DeleteClick(Sender: TObject);
begin
  Deletes;
end;

procedure TForm4.Deletes;
begin

  if Edit1.Text = EmptyStr then
    Edit1.Text := '0';

  Memo1.Lines.Clear;
  RESTClient2.ResetToDefaults;
  RESTRequest2.ResetToDefaults;
  RESTResponse2.ResetToDefaults;

  {
  RESTClient2.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient2.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient2.BaseURL := Format('http://%s:%s/datasnap/rest', ['localhost', '5432']);
  RESTClient2.ContentType := 'application/json';
  }

  Self.CarregarRESTClient;
  RESTRequest2.Resource := '/DeletarDados/{caso}';
  //RESTClient2.HandleRedirects := True;
  //RESTClient2.RaiseExceptionOn500 := False;

  RESTRequest2.SynchronizedEvents := False;
  RESTRequest2.Client := RESTClient2;
  RESTRequest2.Response := RESTResponse2;
  RESTRequest2.Method := rmDELETE;

  RESTRequest2.Params.AddItem('nmprimeiro', URIEncode(Edit1.Text), TRESTRequestParameterKind.pkURLSEGMENT, [], ctAPPLICATION_JSON);
  RESTRequest2.Execute;

  Memo1.Lines.Clear;
  Memo1.Lines.Append(RESTRequestMethodToString(RESTRequest2.Method));
  Memo1.Lines.Append(RESTRequest2.Params.ParameterByName('nmprimeiro').ToString);

end;

end.
