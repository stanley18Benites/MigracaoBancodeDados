unit uTabelas;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.CheckLst,
  Vcl.Buttons,
  Data.DB,
  Vcl.ComCtrls,
  DataSnap.DBClient;

type dadosCDS     = array of TClientDataSet;
type THackDBGrid  = class(TDBGrid);
type
  TfrmConsulta = class(TForm)
    panel1  : TPanel;
    pnlFull : TPanel;
    Label2  : TLabel;
    Label1  : TLabel;
    Panel2  : TPanel;
    DBGrid1 : TDBGrid;
    DBGrid5 : TDBGrid;
    Panel3  : TPanel;
    dbGridMySQL: TDBGrid;
    Panel4  : TPanel;
    Panel6  : TPanel;
    label_nomeTabSelecionada: TLabel;
    pnlLateral: TPanel;
    DBGrid6 : TDBGrid;
    Panel5  : TPanel;
    SpeedButton2: TSpeedButton;
    Panel7  : TPanel;
    Panel8  : TPanel;
    SpeedButton1: TSpeedButton;
    Panel9: TPanel;
    StringGrid1: TStringGrid;
    StatusBar1: TStatusBar;
    StringGrid2: TStringGrid;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid5CellClick(Column: TColumn);
    procedure DBGrid1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure dbGridMySQLCellClick(Column: TColumn);
    procedure SpeedButton1MouseMoveSpeedButton1MouseMoveSpeedButton2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pnlLateralMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure StringGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure StringGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SpeedButton2Click(Sender: TObject);
  private
    procedure criarObjetos;
    procedure DrawControl(Control: TWinControl);
    procedure aplicaBorda;
    procedure apllyStyle;
    procedure configuraNomeColunaDBGrid;
    procedure alimentaDados(sNomeColuna : String; sNomeTabela : String);
  public
    class procedure criarForm ();
  end;
implementation
{$R *.dfm}
uses
  uMenu,
  uClasseBuscarTabelasBD,
  uClasseConexao,
  migracaoBD.Pages.Messages,
  migracaoBd.View.Style.Colors;
var
  frmConsulta : TfrmConsulta;
  objMY       : buscarTabelas ;
  objFB       : buscarTabelas ;
  objDBGrid   : buscarTabelas ;
  objDBGridMySQL : buscarTabelas ;
  cds         : TClientDataSet ;
  valor_linha , valor_coluna : String ;

class procedure TfrmConsulta.criarForm ();
begin
  frmConsulta := TfrmConsulta.Create(Application);
  frmConsulta.ShowModal();
end;

procedure TfrmConsulta.FormCreate(Sender: TObject);
begin
  criarObjetos;
  configuraNomeColunaDBGrid;
  aplicaBorda ;
  apllyStyle;
  StringGrid1.Cells[0,0] := 'COLUNAS BD' ;
  DBGrid5.DataSource      := objFB.buscarTabela();
  dbGridMySQL.DataSource  := objMY.buscarTabela();
end;

procedure TfrmConsulta.FormDestroy(Sender: TObject);
begin
  FreeAndNil(OBJmy);
  FreeAndNil(objFB);
  FreeAndNil(objDBGrid);
  FreeAndNil(objDBGridMySQL);
  FreeAndNil(Cds);
end;

procedure TfrmConsulta.SpeedButton1Click(Sender: TObject);
begin
  close ;
end;

procedure TfrmConsulta.SpeedButton1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  panel8.Color := COLOR_TITULO_ICONE;
  panel8.Cursor := crHandPoint;
end;

procedure TfrmConsulta.SpeedButton1MouseMoveSpeedButton1MouseMoveSpeedButton2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Begin;
    panel5.Color := COLOR_TITULO_ICONE;
    panel5.Cursor := crHandPoint;
  End;
end;

procedure TfrmConsulta.SpeedButton2Click(Sender: TObject);
var i : Integer ;
begin
  for I := 1 to StringGrid1.RowCount do
  begin
    objMY.buscaColuna(StringGrid1.Cells[0,i] , label_nomeTabSelecionada.caption);
  end;

  //OBJmy.inserirTabelas('INSERT INTO :tabela () values () ');
end;

procedure TfrmConsulta.StringGrid1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  gc : TGridCoord;
  s : string;
begin
  gc := THackDBGrid(DBGrid1).MouseCoord(X,Y);
  //if (gc.X > 0) AND (gc.Y > 0) then
  begin
    s := dbGrid1.Columns.Grid.SelectedField.FieldName ;
    with THackDBGrid(DBGrid1) do
    begin
      gc := THackDBGrid(StringGrid1).MouseCoord(X,Y);
      StringGrid1.MouseCoord(X,Y);
      if not( trim( s )='' ) then
      begin
        StringGrid1.Cells[gc.X,gc.Y] := s ;
        alimentaDados(s , label_nomeTabSelecionada.Caption) ;
      end;
    end;

  end;
end;

procedure TfrmConsulta.alimentaDados(sNomeColuna : String; sNomeTabela : String );
var
  q : buscarTabelas ;
  i : Integer ;
begin
  try
    i := 0 ;
    q   := buscarTabelas.Create(tpFirebird);
    q.conexaoFB.setFQry('SELECT ' + sNomeColuna + ' FROM ' + sNomeTabela) ;
    while not q.conexaoFB.getFQry.Eof  do
    begin
      cds.FieldDefs.Add(q.conexaoFB.getFQry.FieldByName(sNomeColuna).AsString, ftString, 50);
      q.conexaoFB.getFQry.Next;
    end;

    while not cds.Eof do
    BEGIN
      StringGrid1.Rows[1].Add(cds.FieldByName(sNomeColuna).AsString);
    END;
  finally
    q.Free;
  end;
end;

procedure TfrmConsulta.StringGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source is TDBGrid ;
end;

procedure TfrmConsulta.DBGrid1CellClick(Column: TColumn);
var cont : Integer ;
begin
  DBGrid1.BeginDrag(true);
end;

procedure TfrmConsulta.DBGrid1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

  Accept := Source is TDBGrid ;

end;

procedure TfrmConsulta.DBGrid5CellClick(Column: TColumn);
begin
  DBGrid1.DataSource  := objDBGrid.buscarTabelaEspecifica(DBGrid5.Columns.Items[DBGrid5.SelectedIndex].Field.AsString );
  label_nomeTabSelecionada.Caption      := DBGrid5.Columns.Items[DBGrid5.SelectedIndex].Field.AsString;
end;

procedure TfrmConsulta.dbGridMySQLCellClick(Column: TColumn);
begin
  dbGrid6.DataSource    := objDBGridMySQL.buscarTabelaEspecifica(dbGridMySQL.Columns.Items[0].Field.AsString ) ;
  StringGrid1.RowCount  := dbGrid6.DataSource.DataSet.RecordCount;
end;

procedure TfrmConsulta.configuraNomeColunaDBGrid;
begin
  dbGridMySQL.Columns[0].Title.Caption  := 'TABELAS';
  dbGrid6.Columns[0].Title.Caption      := 'DESCRICAO';
  //dbGrid6.Columns[0].Title.Caption      := 'REFERENCIAS';
end;

procedure TfrmConsulta.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  panel5.Color  := COLOR_BACKGROUND_MAIN;
  Panel5.Cursor := crDefault ;
end;

procedure TfrmConsulta.pnlLateralMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Panel5.Color := COLOR_BACKGROUND_MAIN;
  Panel8.Color := COLOR_BACKGROUND_MAIN;
end;

procedure TfrmConsulta.aplicaBorda;
begin
  DrawControl(DBGrid5);
  DrawControl(DBGrid1);
  DrawControl(panel9);
  DrawControl(DBGrid6);
  DrawControl(dbGridMySQL);
  DrawControl(Panel1);
  DrawControl(Panel2);
  DrawControl(Panel4);
  DrawControl(Panel6);
  DrawControl(pnlFull);
  DrawControl(pnlLateral);
  DrawControl(Panel5);
  DrawControl(Panel7);
  DrawControl(Panel3);
  DrawControl(Panel8);
  DrawControl(StringGrid1);
end;

procedure TfrmConsulta.apllyStyle;
begin
  panel1.color            := COLOR_BACKGROUND_FUNDO;
  Panel2.Color            := COLOR_TITULO_ICONE;
  pnlLateral.color        := COLOR_BACKGROUND_MAIN ;
  Panel4.Color            := COLOR_BACKGROUND_MAIN ;
  Panel6.Color            := COLOR_BACKGROUND_ITENS;
  pnlFull.Color           := COLOR_BACKGROUND_ITENS;
  Panel5.color            := COLOR_BACKGROUND_MAIN;//COLOR_TITULO_ICONE;
  Panel7.color            := COLOR_TITULO_ICONE;
  Panel3.color            := COLOR_BACKGROUND_MAIN;
  Panel7.font.Color       := COLOR_LINES;
  Panel2.font.Color       := COLOR_LINES;
  SpeedButton2.Font.Color := COLOR_LINES;
  Panel8.Color            := COLOR_BACKGROUND_MAIN;
  SpeedButton1.Font.Color := COLOR_LINES;
  label1.font.color       := COLOR_LINES;
  label2.font.color       := COLOR_LINES;
  label_nomeTabSelecionada.Font.Color := COLOR_LINES;
end;
procedure TfrmConsulta.criarObjetos;
begin
  cds             := TClientDataSet.Create(nil);
  objMY           := buscarTabelas.Create(tpMYSQL);
  objFB           := buscarTabelas.Create(tpFirebird);
  objDBGrid       := buscarTabelas.Create(tpFirebird);
  objDBGridMySQL  := buscarTabelas.Create(tpMYSQL);

end;

procedure TfrmConsulta.DrawControl(Control: TWinControl) ;
var
   R: TRect;
   Rgn: HRGN;
begin
    with Control do
    begin
      R := ClientRect;
      rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 15, 15) ;
      Perform(EM_GETRECT, 0, lParam(@r)) ;
      InflateRect(r, - 3, - 3) ;
      Perform(EM_SETRECTNP, 0, lParam(@r)) ;
      SetWindowRgn(Handle, rgn, True) ;
      Invalidate;
    end;
end;
end.
