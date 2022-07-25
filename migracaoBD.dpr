program migracaoBD;

uses
  Vcl.Forms,
  uMenu in 'uMenu.pas' {frmMenu},
  uTabelas in 'uTabelas.pas' {frmConsulta},
  uClasseConexao in 'uClasseConexao.pas' {$R *.res},
  uClasseBuscarTabelasBD in 'uClasseBuscarTabelasBD.pas',
  migracaoBd.View.Style.Colors in 'Pages\Style\Colors\migracaoBd.View.Style.Colors.pas',
  migracaoBD.Pages.Messages in 'Pages\View\migracaoBD.Pages.Messages.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := true ;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.
