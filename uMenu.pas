unit uMenu;
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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  FireDac.DAPt,
  uClasseConexao,
  IniFiles,
  Vcl.Grids,
  Vcl.DBGrids,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDac.Phys.FB,
  migracaoBd.View.Style.Colors,
  Vcl.Buttons,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList;

type
  TfrmMenu = class(TForm)
    Panel1      : TPanel;
    pnlFull     : TPanel;
    pnlLateral  : TPanel;
    Panel8      : TPanel;
    Panel5      : TPanel;
    Label2      : TLabel;
    Label3      : TLabel;
    Label6      : TLabel;
    Label7      : TLabel;
    Label8      : TLabel;
    edtServidor : TEdit;
    edtUsuario  : TEdit;
    edtSenha    : TEdit;
    edtPorta    : TEdit;
    edtNomeBanco: TEdit;
    Panel7      : TPanel;
    Panel2      : TPanel;
    Panel4      : TPanel;
    Label1      : TLabel;
    lb_usuario  : TLabel;
    lb_senha    : TLabel;
    Label4      : TLabel;
    Label5      : TLabel;
    edt_Servidor: TEdit;
    edt_usuario : TEdit;
    edt_senha   : TEdit;
    edt_porta   : TEdit;
    edt_nomeBanco: TEdit;
    Panel6      : TPanel;
    Panel9      : TPanel;
    Button2: TButton;
    Button3: TButton;
    Panel10: TPanel;
    cbSaida: TComboBox;
    cbEntrada: TComboBox;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbSaidaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    procedure salvarConfigMY;
    procedure salvarConfigFB;
    procedure buscarConfigFB;
    procedure buscarConfigMY;
    procedure ApplyStyle;
    procedure criarObjetos(dir: string);
    procedure lerConfiguracoesBD;
//    procedure Arredondarcantos(componente: TWinControl; Y: String);
    procedure DrawControl(Control: TWinControl);
    procedure SpeedButton3Click(Sender: TObject);
    procedure aplicaBorda;
//    procedure Button2Click(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMenu       : TfrmMenu;
  conexaoFB     : TConexao ;
  conexaoMY     : TConexao ;
  GravaIni      : TIniFile;
  bConexaoBDFB  : boolean ;
  bConexaoBDMY  : boolean ;

implementation
{$R *.dfm}

uses
  uClasseBuscarTabelasBD,
  uTabelas,
  migracaoBd.Pages.Messages;

var
  dir: string;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  dir := GetCurrentDir;
  criarObjetos(dir);
  aplicaBorda;
  ApplyStyle;

end;

procedure TfrmMenu.FormDestroy(Sender: TObject);
begin
  conexaoFB.free;
  conexaoMY.free;
  GravaIni.Free;
end;

procedure TfrmMenu.FormActivate(Sender: TObject);
begin
  lerConfiguracoesBD;
end;

procedure TfrmMenu.Button2Click(Sender: TObject);
begin
  if cbSaida.ItemIndex = 0 then //FIREBIRD
  begin
    conexaoFB.ConfigurarConexao(edt_nomeBanco.Text,edt_senha.Text,edt_usuario.Text,edt_porta.Text,edt_Servidor.Text);
    if conexaoFB.ConfigurarConexao(edt_nomeBanco.Text,edt_senha.Text,edt_usuario.Text,edt_porta.Text,edt_Servidor.Text) then
    begin
      Panel9.Caption    := MSG_BDCONECTADO ;
      panel9.Font.Color := COLOR_TEXT_TRUE;
      bConexaoBDFB      := true;
    end
    else
    BEGIN
      Panel9.Caption    := MSG_BDNAOCONECTADO ;
      panel9.Font.Color := COLOR_TEXT_FALSE;
      bConexaoBDFB      := false ;
    END;
    if edt_nomeBanco.Text <> '' then
      salvarConfigFB;
  end
  else
    ShowMessage(MSG_BDNAOSELECIONADO);
end;

procedure TfrmMenu.Button3Click(Sender: TObject);
begin
if cbEntrada.ItemIndex = 0 then //CONEXAO DO MYSQL
begin
  conexaoMY.ConfigurarConexao(edtnomeBanco.Text,edtsenha.Text,edtusuario.Text,edtporta.Text,edtServidor.Text);
  if conexaoMY.ConfigurarConexao(edtnomeBanco.Text,edtsenha.Text,edtusuario.Text,edtporta.Text,edtServidor.Text) then
  begin

    bConexaoBDMY      := true ;
    Panel2.Caption    := MSG_BDCONECTADO;
    Panel2.Font.Color := COLOR_TEXT_TRUE ;

  end
  else
  begin

    bConexaoBDMY      := false ;
    Panel2.Caption    := MSG_BDNAOCONECTADO;
    Panel2.Font.Color := COLOR_TEXT_FALSE ;

  end;
  if edtNomeBanco.Text <> '' then
    salvarConfigMY();
end
else
  ShowMessage(MSG_BDNAOSELECIONADO);
end ;

procedure TfrmMenu.salvarConfigFB;
begin
  GravaIni.WriteString('PARAMETROSFB','Database',edt_nomeBanco.Text);
  GravaIni.WriteString('PARAMETROSFB','DriverID','FB');
  GravaIni.WriteString('PARAMETROSFB','CharacterSet','utf8');
  GravaIni.WriteString('PARAMETROSFB','Password',edt_senha.Text);
  GravaIni.WriteString('PARAMETROSFB','User_Name',edt_usuario.Text);
  GravaIni.WriteString('PARAMETROSFB','Port',edt_porta.Text);
  GravaIni.WriteString('PARAMETROSFB','Server',edt_Servidor.Text);
  GravaIni.WriteString('PARAMETROSFB','LoginPrompt','false');
end;
procedure TfrmMenu.salvarConfigMY;
begin
  GravaIni.WriteString('PARAMETROSMY','Database',edtNomeBanco.Text);
  GravaIni.WriteString('PARAMETROSMY','DriverID','MySQL');
  GravaIni.WriteString('PARAMETROSMY','CharacterSet','utf8');
  GravaIni.WriteString('PARAMETROSMY','Password',edtSenha.Text);
  GravaIni.WriteString('PARAMETROSMY','User_Name',edtUsuario.Text);
  GravaIni.WriteString('PARAMETROSMY','Port',edtPorta.Text);
  GravaIni.WriteString('PARAMETROSMY','Server',edtServidor.Text);
  GravaIni.WriteString('PARAMETROSMY','LoginPrompt','false');
end;

procedure TfrmMenu.SpeedButton1Click(Sender: TObject);
begin
  Application.Terminate ;
end;

procedure TfrmMenu.SpeedButton2Click(Sender: TObject);
begin
  if bConexaoBDFB and bConexaoBDMY then
  begin

    TfrmConsulta.criarForm();

  end
  else
    Application.MessageBox(MSG_BDERROCONEXAO,'ERRO',MB_ICONERROR);
end;

procedure TfrmMenu.SpeedButton3Click(Sender: TObject);
begin
if cbEntrada.ItemIndex = 0 then //CONEXAO DO MYSQL
begin
  conexaoMY.ConfigurarConexao(edtnomeBanco.Text,edtsenha.Text,edtusuario.Text,edtporta.Text,edtServidor.Text);
  if conexaoMY.ConfigurarConexao(edtnomeBanco.Text,edtsenha.Text,edtusuario.Text,edtporta.Text,edtServidor.Text) then
  begin

    bConexaoBDMY      := true ;
    Panel2.Caption    := MSG_BDCONECTADO;
    Panel2.Font.Color := COLOR_TEXT_TRUE ;

  end
  else
  begin

    bConexaoBDMY      := false ;
    Panel2.Caption    := MSG_BDNAOCONECTADO;
    Panel2.Font.Color := COLOR_TEXT_FALSE ;

  end;
  salvarConfigMY();
end
else
  ShowMessage(MSG_BDNAOSELECIONADO);
end ;

procedure TfrmMenu.aplicaBorda;
begin

  DrawControl(Panel2);
  DrawControl(Panel10);
  DrawControl(Panel3);
  DrawControl(Panel4);
  DrawControl(Panel4);
  DrawControl(Panel6);
  DrawControl(Panel9);
  DrawControl(Button2);
  DrawControl(button3);
  DrawControl(pnlLateral);
  DrawControl(cbSaida);
  DrawControl(edt_Servidor);
  DrawControl(edt_usuario);
  DrawControl(edt_senha);
  DrawControl(edt_porta);
  DrawControl(edt_nomeBanco);
  DrawControl(cbEntrada);
  DrawControl(Panel7);
  DrawControl(edtServidor);
  DrawControl(edtUsuario);
  DrawControl(edtSenha);
  DrawControl(edtPorta);
  DrawControl(edtNomeBanco);
  DrawControl(panel5);
  DrawControl(frmMenu);

end;

procedure TfrmMenu.buscarConfigFB;
begin
  edt_Servidor.Text   := GravaIni.ReadString('PARAMETROSFB','Server','');
  edt_usuario.Text    := GravaIni.ReadString('PARAMETROSFB','User_Name','');
  edt_senha.Text      := GravaIni.ReadString('PARAMETROSFB','Password','');
  edt_porta.Text      := GravaIni.ReadString('PARAMETROSFB','Port','');
  edt_nomeBanco.Text  := GravaIni.ReadString('PARAMETROSFB','Database','');
end;

procedure TfrmMenu.buscarConfigMY;
begin
  edtServidor.Text  := GravaIni.ReadString('PARAMETROSMY','Server','');
  edtusuario.Text   := GravaIni.ReadString('PARAMETROSMY','User_Name','');
  edtsenha.Text     := GravaIni.ReadString('PARAMETROSMY','Password','');
  edtporta.Text     := GravaIni.ReadString('PARAMETROSMY','Port','');
  edtnomeBanco.Text := GravaIni.ReadString('PARAMETROSMY','Database','');
end;

procedure TfrmMenu.ApplyStyle;
begin
  Panel1.Color      := COLOR_BACKGROUND_MAIN ;
  pnlLateral.Color  := COLOR_BACKGROUND_LATERAL;
  Panel8.Color      := COLOR_BACKGROUND_MAIN ;
  Panel2.Font.Color := COLOR_TEXT_FALSE ;
  Panel2.color      := COLOR_BACKGROUND_LATERAL ;
  Panel9.Font.Color := COLOR_TEXT_FALSE ;
  Panel9.Color      := COLOR_BACKGROUND_LATERAL;
  Panel10.Font.Color:= COLOR_TEXT_FALSE ;
  Panel10.Color     := BUTTON_COLOR;
  Panel3.Color      := BUTTON_COLOR ;
  Panel3.Font.Color := COLOR_TEXT_FALSE ;
  //cbSaida.font.color:= clWhite ;
  //cbSaida.color     := clBlack ;

end;

procedure TfrmMenu.BitBtn1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := GetCurrentDir;//(dir);
  OpenDialog1.Execute();
  if OpenDialog1.FileName <> '' then
    edt_NomeBanco.Text := OpenDialog1.FileName;
end;

procedure TfrmMenu.BitBtn2Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := GetCurrentDir;//(dir);
  OpenDialog1.Execute();
  if OpenDialog1.FileName <> '' then
    edtnomeBanco.Text := OpenDialog1.FileName;
end;

procedure TfrmMenu.cbSaidaDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
{Desenhar os rectangulos com as cores no ComboBox}
with Control as TComboBox,Canvas do
begin
cbSaida.Color := clWhite;
FillRect(Rect);
InflateRect(Rect,-2,-2);
Brush.Color := StrToInt(Items[Index]);
FillRect(Rect);
end;
end;

procedure TfrmMenu.criarObjetos(dir: string);
begin
  conexaoFB := TConexao.Create(tpFirebird);
  conexaoMY := TConexao.Create(tpMYSQL);
  GravaIni := TIniFile.Create(dir + '\config.ini');
end;

procedure TfrmMenu.lerConfiguracoesBD;
begin
  buscarConfigFB;
  buscarConfigMY;
end;

procedure TfrmMenu.DrawControl(Control: TWinControl) ;
var
   R: TRect;
   Rgn: HRGN;
begin
    with Control do  begin
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
