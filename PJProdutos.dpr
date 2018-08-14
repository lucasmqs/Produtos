program PJProdutos;

uses
  Vcl.Forms,
  UProdutos in 'UProdutos.pas' {frmCadastroProdutos},
  UDMProdutos in 'UDMProdutos.pas' {dmProdutos: TDataModule},
  ProdutosControler in 'ProdutosControler.pas',
  ufrmCadProdutos in 'ufrmCadProdutos.pas' {frmCadProdutos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastroProdutos, frmCadastroProdutos);
  Application.CreateForm(TdmProdutos, dmProdutos);
  Application.Run;
end.
