unit uBuscarTabelas;
interface

uses  FireDac.Comp.Client, VCL.DIalogs,System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
      FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,FireDAC.Stan.Pool, FireDAC.Stan.Async,
      FireDAC.Phys,Data.DB, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,FireDAC.Comp.UI;

type TTipoBD = (tpMYSQL,tpFirebird);
type uTabelas = class
    FQuery : TFDQuery ;
    //FConection : TFDConnection ;
  private
    procedure ConectarQuery() ;
  public
    Constructor Create (tipoBD : TTipoBD);
    Destructor Destroy ;
end;

implementation

uses uClasseConexao, uMenu ;

Constructor uTabelas.Create (tipoBD : TTipoBD);
begin
  //
end;

procedure uTabelas.ConectarQuery;
begin
  FQuery := TFDQuery.Create(nil);
  //FQuery.Connection := ;
end;



destructor uTabelas.Destroy;
begin
  FreeAndNil(FQuery);
end;

end.
