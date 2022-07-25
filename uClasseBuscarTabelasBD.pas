  unit uClasseBuscarTabelasBD;
interface

uses
  Data.DB,
  uClasseConexao,
  IniFiles,
  System.SysUtils,
  DataSnap.DBClient;

type buscarTabelas = class
      dir         : string;
      FTipoBD     : TTipoBD;
      FDS         : TDataSource;
      FTipo       : TTIpoBD ;
      conexaoFB   : TConexao ;
      conexaoMY   : TConexao ;
      FNomeBanco  : String ;
      FSenha      : String;
      FUsuario    : String ;
      FPorta      : String ;
      FServidor   : String ;
      GravaIni    : TIniFile;
  public
    Constructor Create( tipo : TTipoBD );
    Destructor  Destroy ; override ;
    function    buscarTabela() : TDataSource ;
    function    buscarTabelaEspecifica( sel : String ): TDataSource;
    function    buscaColuna(sNomeColuna : String ; sNomeTabela : String): TDataSource;
    procedure   inserirTabelas(sel: String);
  private
    procedure lerDadosBancoFB;
    procedure lerDadosBancoMY;
    procedure criarObjetos ( tipo : TTipoBD) ;
    procedure configurarConexaoBancoDados;
end;

implementation

Constructor buscarTabelas.Create(tipo : TTipoBD);
begin
  criarObjetos(tipo);
  FTipoBD := tipo ;
  configurarConexaoBancoDados;
end;

Destructor buscarTabelas.Destroy;
begin
    FDs.Free ;
    conexaoFB.Free;
    conexaoMY.Free;
    GravaIni.Free;
end;


function buscarTabelas.buscarTabela() : TDataSource;
begin
  case FTipoBD of
  tpMYSQL :   begin
                conexaoMY.setFQry('SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_NAME = "participantes" or TABLE_NAME = "produtos" ' +
                                  'or TABLE_NAME = "tribprodutos" OR  TABLE_NAME = "cadgrupo"');//
                FDs.DataSet := conexaoMY.getFQry ;
        end;
  tpFirebird: begin
                conexaoFB.setFQry('SELECT RDB$RELATION_NAME FROM RDB$RELATIONS WHERE RDB$VIEW_BLR IS NULL ORDER BY RDB$RELATION_NAME');
                FDs.DataSet := conexaoFB.getFQry ;
              end;
  end;
  result := FDs  ;
end;

function buscarTabelas.buscarTabelaEspecifica( sel : String ) : TDataSource ;
begin
  case FTipoBD of
    tpMYSQL:   begin
                conexaoMY.setFQry('SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = "' + sel + '"');
                FDs.DataSet := conexaoMY.getFQry ;
               end;
    tpFirebird:begin
                conexaoFB.setFQry('SELECT * FROM ' + sel );
                FDs.DataSet := conexaoFB.getFQry ;
               end ;
  end;
  result := FDs ;
end;

function buscarTabelas.buscaColuna(sNomeColuna : String ; sNomeTabela : String) : TDataSource ;
begin
  case FTipoBD of
  tpMYSQL:   begin
              //conexaoMY.setFQry('select rdb$field_name from rdb$relation_fields where rdb$relation_name=' + sel + '''');
                //conexaoMY.setFQry('SELECT COLUMN_NAME FROM ' + sNomeTabela + ' WHERE TABLE_NAME ='+ sel + '''');
              FDs.DataSet := conexaoMY.getFQry ;
             end;
  tpFirebird:begin
              conexaoFB.setFQry('SELECT ' + sNomeColuna + ' FROM ' + sNomeTabela);
              FDs.DataSet := conexaoFB.getFQry ;
             end ;
  end;
  result := FDs ;
end;

procedure buscarTabelas.criarObjetos(tipo : TTipoBD);
begin
  case tipo of
  tpMYSQL     : begin
                  conexaoMY := TConexao.Create(tpMYSQL);
                end;
  tpFirebird  : begin
                  conexaoFB := TConexao.Create(tpFirebird);
                end;
  end;
  dir       := GetCurrentDir;
  FDS       := TDataSource.Create(nil);
  GravaIni  := TIniFile.Create(dir + '\config.ini');
end;

procedure buscarTabelas.inserirTabelas(sel : String);
begin
  conexaoMY.setFQry(sel);
end;


procedure buscarTabelas.configurarConexaoBancoDados;
begin
  case FTipoBD of
    tpMYSQL:
      begin
        try
          lerDadosBancoMY;
          conexaoMY.ConfigurarConexao(FNomeBanco, FSenha, FUsuario, FPorta, FServidor);
        finally
          //conexaoMY.Free;
        end;
      end;
    tpFirebird:
      begin
        try
          lerDadosBancoFB;
          conexaoFB.ConfigurarConexao(FNomeBanco, FSenha, FUsuario, FPorta, FServidor);
        finally
          //conexaoFB.Free;
        end;
      end;
  end;
end;

procedure buscarTabelas.lerDadosBancoFB;
begin

  FNomeBanco  := GravaIni.ReadString('PARAMETROSFB','DataBase','');
  FSenha      := GravaIni.ReadString('PARAMETROSFB','Password','') ;
  FUsuario    := GravaIni.ReadString('PARAMETROSFB','User_name','');
  FPorta      := GravaIni.ReadString('PARAMETROSFB','Port','') ;
  FServidor   := GravaIni.ReadString('PARAMETROSFB','Server','') ;

end;

procedure buscarTabelas.lerDadosBancoMY;
begin

  FNomeBanco  := GravaIni.ReadString('PARAMETROSMY','DataBase','') ;
  FSenha      := GravaIni.ReadString('PARAMETROSMY','Password','') ;
  FUsuario    := GravaIni.ReadString('PARAMETROSMY','User_name','') ;
  FPorta      := GravaIni.ReadString('PARAMETROSMY','Port','') ;
  FServidor   := GravaIni.ReadString('PARAMETROSMY','Server','') ;

end;
end.
