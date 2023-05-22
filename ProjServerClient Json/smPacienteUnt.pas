unit smPacienteUnt;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
    FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
    FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.PGDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
    FireDAC.DApt, REST.Types, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
    FireDAC.Phys.PG, REST.Client, REST.Response.Adapter, Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Comp.UI;

type
    TSM1 = class(TDSServerModule)
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    fdqExames: TFDQuery;
    fdqDados: TFDQuery;
    FDUpdateSQL1: TFDUpdateSQL;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Paciente(id: integer): TJSONArray;                // Get
    function UpdatePaciente(JPaciente: TJSONObject): boolean;  // Post
    function AcceptPaciente(JPaciente: TJSONObject): boolean;  // Put
    function CancelPaciente(id: integer): boolean;             // Delete
    function Exame (id: integer) : TJSONArray;

  end;

implementation


{$R *.dfm}

uses System.StrUtils;


{ TSM1 }

function TSM1.AcceptPaciente(JPaciente: TJSONObject): boolean;
//  Mapeamento padrão do Delphi para PUT
begin
  Result := False;
  if not FDUpdateSQL1.Commands[arInsert].Prepared then
    FDUpdateSQL1.Commands[arInsert].Prepare;

  FDUpdateSQL1.Commands[arInsert].ParamByName('NEW_CASO').AsInteger := JPaciente.GetValue('CASO').Value.ToInteger;

  FDUpdateSQL1.Commands[arInsert].ParamByName('NEW_NOME').AsString := JPaciente.GetValue('NOME').Value;

  Result := FDUpdateSQL1.Commands[arInsert].OpenOrExecute();

end;

function TSM1.CancelPaciente(id: integer): boolean;
//  Mapeamento padrão do Delphi para Delete
begin
  Result := False;
  if not FDUpdateSQL1.Commands[arDelete].Prepared then
    FDUpdateSQL1.Commands[arDelete].Prepare;

  FDUpdateSQL1.Commands[arDelete].ParamByName('OLD_CASO').AsInteger := id;
  Result := FDUpdateSQL1.Commands[arDelete].OpenOrExecute();
end;

function TSM1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TSM1.Exame(id: integer): TJSONArray;
//  Mapeamento padrão do Delphi para Get
var
  o : TJSONObject;
  I: integer;
begin
  fdqExames.Close;
  if id <= 0  then
    fdqExames.SQL.Text := 'select caso,data,glicemia,colesteroltotal,hdl,ldl, ' +
      'triglicerides from exames order by data'
  else
    begin
      fdqExames.SQL.Text := 'select caso,data,glicemia, colesteroltotal, hdl, ' +
        'ldl, triglicerides from exames where caso = :parCaso order by data';
      fdqExames.Params.Add('parCaso', ftInteger, ptInput);
      fdqExames.Params[0].AsInteger := id;
    end;
    fdqExames.Open();
    if fdqExames.Active then
      begin
        if fdqExames.RecordCount > 0 then
        begin
          Result := TJSONArray.Create;
          try
            fdqExames.First;
            while not(fdqExames.Eof) do
            begin
              o := TJSONObject.Create;
              for I := 0 to fdqExames.FieldCount - 1 do
                begin
                  if (fdqExames.Fields[I].IsNull) then
                    //Tratando valores nulos para não "quebrar" a aplicação
                    o.AddPair(fdqExames.Fields[I].DisplayName, 'nulo')
                  else
                    o.AddPair(fdqExames.Fields[I].DisplayName, fdqExames.Fields[I].AsInteger);
                end;
              Result.AddElement(o);
              fdqExames.Next;
            end;
          finally

          end;
        end;
      end;
end;

function TSM1.Paciente(id: integer): TJSONArray;
//  Mapeamento padrão do Delphi para Get
var
  o: TJSONObject;
  I: integer;

begin
  fdqDados.Close;
  if id <= 0 then
    fdqDados.SQL.Text := 'select caso, nome, altura, pesoatual, pesoinicial, ' +
                        'pesoideal, imc from dados order by caso '
  else
  begin
    fdqDados.SQL.Text := 'select caso, nome, altura, pesoatual, pesoinicial, ' +
     'pesoideal, imc from dados where caso = :parCaso ';
    fdqDados.Params.Add('parCaso', ftInteger, ptInput);
    fdqDados.Params[0].AsInteger := id;
  end;

  fdqDados.Open();
  if fdqDados.Active then
  begin
    if fdqDados.RecordCount > 0 then
    begin
      Result := TJSONArray.Create;
      try
        fdqDados.First;
        while not(fdqDados.Eof) do
        begin
          o := TJSONObject.Create;
          for I := 0 to fdqDados.FieldCount - 1 do
          begin
            if fdqDados.Fields[I].IsNull then
              //Tratando valores nulos para não "quebrar" a aplicação
              o.AddPair(fdqDados.Fields[I].DisplayName, 'nulo')
            else
              o.AddPair(fdqDados.Fields[I].DisplayName, fdqDados.Fields[I].AsInteger);

          end;
          Result.AddElement(o);
          fdqDados.Next;
        end;
      finally

      end;
      end
    else
    begin
      Result := TJSONArray.Create;
      o := TJSONObject.Create;
      o.AddPair('result', 'Não há dados para exibição');
      Result.AddElement(o);
    end;

  end;

end;

function TSM1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TSM1.UpdatePaciente(JPaciente: TJSONObject): boolean;
//  Mapeamento padrão do Delphi para POST
begin
  Result := False;
  if not(FDUpdateSQL1.Commands[arUpdate].Prepared) then
    FDUpdateSQL1.Commands[arUpdate].Prepare;

  FDUpdateSQL1.Commands[arUpdate].ParamByName('OLD_CASO').AsInteger :=
    JPaciente.GetValue('CASO').Value.ToInteger();
  FDUpdateSQL1.Commands[arUpdate].ParamByName('NEW_CASO').AsInteger :=
    FDUpdateSQL1.Commands[arUpdate].ParamByName('OLD_CASO').Value;
  FDUpdateSQL1.Commands[arUpdate].ParamByName('NEW_NOME').AsString :=
    JPaciente.GetValue('NOME').Value;
  Result := FDUpdateSQL1.Commands[arUpdate].OpenOrExecute();
end;

end.