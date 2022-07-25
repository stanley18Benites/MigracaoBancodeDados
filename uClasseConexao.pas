unit uClasseConexao;
interface

uses
  FireDac.Comp.Client,
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,Data.DB,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDac.Phys.FB;

  type TTipoBD = ( tpMYSQL,tpFirebird);
  type TConexao = class
    private
      FTipoBD     : TTipoBD;
      FConnection : TFDConnection ;
      FQry        : TFDQuery ;
      procedure criarObjetos;
    public
      Constructor Create(tipo: TTipoBD);
      Destructor  destroy ; override ;
      property    Connection : TFDConnection read FConnection write FConnection ;
      property    Qry : TFDQuery read FQry write FQry ;
      procedure   setFQry(slc: String);
      function    ConfigurarConexao(nomeBanco:String; SPassword:String; User_Name:String; Port:String; Server:String ): boolean;
      function    getConexao: TFDConnection;
      function    getFQry: TFDQuery;
  end;
implementation

Constructor TConexao.Create(tipo : TTipoBD);
begin

  criarObjetos;
  FTipoBD         := tipo;
  FQry.Connection := FConnection ;

end;

Destructor TConexao.Destroy;
begin

  FreeAndNil(FConnection);
  FQry.Close;
  FQry.Free;

  //FreeAndNil(FQry);

end;

function TConexao.ConfigurarConexao(nomeBanco:String; SPassword:String; User_Name:String; Port:String; Server:String ): boolean;
begin
  try
    if not FConnection.Connected then
    begin
      case FTipoBD of
        tpMYSQL :begin
                  with FConnection.Params do
                    begin
                      FConnection.Params.Clear ;
                      FConnection.Params.Add('DriverID=MySQL');
                      FConnection.Params.Add('Database=' + nomeBanco);
                      FConnection.Params.Add('CharacterSet=utf8');
                      FConnection.Params.Add('Password=' + SPassword);
                      FConnection.Params.Add('User_Name=' + User_Name);
                      FConnection.Params.Add('Port=' + Port);
                      FConnection.Params.Add('Server=' + Server);
                      FConnection.Params.Add('LoginPrompt := false');
                    end;
                  end;
      tpFirebird:begin
                  with FConnection.Params do
                   begin
                     FConnection.Params.CLEAR ;
                     FConnection.Params.Add('DriverID=FB');
                     FConnection.Params.Add('Database=' + nomeBanco);
                     FConnection.Params.Add('CharacterSet=utf8');
                     FConnection.Params.Add('Password=' + SPassword + '');
                     FConnection.Params.Add('User_Name=' + User_Name);
                     FConnection.Params.Add('Port=' + Port);
                     FConnection.Params.Add('Protocol=Local');
                     FConnection.Params.Add('Server=' + Server);
                   end;
                  end;
      end;
      FConnection.Connected := true ;
    end
    else if FConnection.Connected then
      result := true ;
  except
    on e : Exception do
    begin
      result := false
    end;
  end;
end;

procedure TConexao.setFQry(slc : String ) ;
begin
  try
    FQry.Close;
    FQry.SQL.Clear;
    FQry.SQL.Add(slc);
    FQry.Open;
  Except
    on e : Exception do
    begin
      FQry.ExecSQL;
    end;
  end;

end;

function TConexao.getFQry() : TFDQuery;
begin

  result := Qry ;

end;

procedure TConexao.criarObjetos;
begin
  FConnection := TFDConnection.Create(nil);
  FQry        := TFDQuery.Create(nil);
end;

function TConexao.getConexao : TFDConnection;
begin

  result := Connection ;

end;
end.

