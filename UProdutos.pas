unit UProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls;

type
  TfrmCadastroProdutos = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    ds: TDataSource;
    btnInserir: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    ComboBox2: TComboBox;
    btnPesquisar: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Timer1: TTimer;
    procedure btnInserirClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dsDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    procedure AtualizarGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroProdutos: TfrmCadastroProdutos;

implementation

{$R *.dfm}

uses ufrmCadProdutos, UDMProdutos, ProdutosControler;

procedure TfrmCadastroProdutos.btnEditarClick(Sender: TObject);
Var
  frm : TfrmCadProdutos;
  p : TProduto;
begin
  frm := TfrmCadProdutos.Create(Nil);
  p := TProduto.Create;
  p.Codigo := dmProdutos.qryProdutos.FieldByName('CODIGO').AsInteger;
  p.CodCatSubCat := dmProdutos.qryProdutos.FieldByName('COD_CAT_SUB_CAT').AsInteger;
  p.Produto := dmProdutos.qryProdutos.FieldByName('PRODUTO').AsString;
  p.Descricao := dmProdutos.qryProdutos.FieldByName('DESCRICAO').AsString;
  p.CaracteristicasTecnicas := dmProdutos.qryProdutos.FieldByName('CARACTERISTICAS_TECNICAS').AsString;
  p.ValorUnitario := dmProdutos.qryProdutos.FieldByName('VALOR_UNITARIO').AsFloat;
  p.QuantidadeMinima := dmProdutos.qryProdutos.FieldByName('QUANTIDADE_MINIMA').AsInteger;
  frm.Produto := p;
  frm.ShowModal;

  if frm.ModalResult = mrOk then
  Begin
    dmProdutos.Salvar(frm.Produto);
  End;

  p.Free;
  frm.Produto := Nil;
  FreeAndNil(frm);

  atualizarGrid;
end;

procedure TfrmCadastroProdutos.btnExcluirClick(Sender: TObject);
Var
  p : TProduto;
  msg, cption : String;
begin
  p := TProduto.Create;
  p.Codigo := dmProdutos.qryProdutos.FieldByName('CODIGO').AsInteger;
  p.CodCatSubCat := dmProdutos.qryProdutos.FieldByName('COD_CAT_SUB_CAT').AsInteger;
  p.Produto := dmProdutos.qryProdutos.FieldByName('PRODUTO').AsString;
  p.Descricao := dmProdutos.qryProdutos.FieldByName('DESCRICAO').AsString;
  p.CaracteristicasTecnicas := dmProdutos.qryProdutos.FieldByName('CARACTERISTICAS_TECNICAS').AsString;
  p.ValorUnitario := dmProdutos.qryProdutos.FieldByName('VALOR_UNITARIO').AsFloat;
  p.QuantidadeMinima := dmProdutos.qryProdutos.FieldByName('QUANTIDADE_MINIMA').AsInteger;

  msg := 'Tem Certeza que pretende excluir o produto: ' + p.Produto + ' do Banco de Dados?';
  cption := 'CONFIRMAÇÃO PARA EXCLUSÃO';
  if Application.MessageBox(PWideChar(msg), PWideChar(cption), MB_ICONQUESTION + MB_YESNO) = mrYes then
  Begin
    dmProdutos.Excluir(p);
  End;

  p.Free;
  AtualizarGrid;
end;

procedure TfrmCadastroProdutos.btnInserirClick(Sender: TObject);
Var
  frm : TfrmCadProdutos;
  p : TProduto;
begin
  frm := TfrmCadProdutos.Create(Nil);
  p := TProduto.Create;
  frm.Produto := p;
  frm.ShowModal;

  if frm.ModalResult = mrOk then
  Begin
    dmProdutos.Salvar(frm.Produto);
  End;

  p.Free;
  frm.Produto := Nil;
  FreeAndNil(frm);

  AtualizarGrid;
end;

procedure TfrmCadastroProdutos.btnPesquisarClick(Sender: TObject);
Var
  sql : String;
  whr : String;
  order : String;
begin
  whr := ' ';
  sql :=
    'Select c.CATEGORIA, s.SUBCATEGORIA, P.* From TB_PRODUTOS p Inner Join ' +
    ' TB_SUB_CAT_PRODUTOS s On (p.COD_CAT_SUB_CAT = s.COD_CAT_SUB_CAT) Inner Join' +
    ' TB_CAT_PRODUTOS c on (s.COD_CATEGORIA = c.CODIGO) ';
  order := ' Order By CATEGORIA, SUBCATEGORIA, PRODUTO;';

  if (Combobox1.ItemIndex >= 0) and (Combobox2.ItemIndex >= 0) then
  Begin
    whr := 'Where p.COD_CAT_SUB_CAT = ' + IntToStr(dmProdutos.qrySubCategorias.FieldByName('COD_CAT_SUB_CAT').AsInteger);
  End
  else
  Begin
    if (Combobox1.ItemIndex >= 0) then
        whr := 'Where c.CODIGO = ' + IntToStr(dmProdutos.qryCategorias.FieldByName('CODIGO').AsInteger);
  End;

  sql := sql + whr + order;

  dmProdutos.qryProdutos.Close;
  dmProdutos.qryProdutos.SQL.Clear;
  dmProdutos.qryProdutos.SQL.Add(sql );
  dmProdutos.qryProdutos.Open;
end;

procedure TfrmCadastroProdutos.ComboBox1Change(Sender: TObject);
begin
  if dmProdutos.qryCategorias.Locate('CATEGORIA', Combobox1.Text, []) then
  Begin
    Combobox2.Clear;

    dmProdutos.qrySubCategorias.First;
    while Not(dmProdutos.qrySubCategorias.Eof) do
    Begin
      ComboBox2.Items.Add(dmProdutos.qrySubCategorias.Fields[2].AsString);
      dmProdutos.qrySubCategorias.Next;
    End;
  End;
end;

procedure TfrmCadastroProdutos.ComboBox2Change(Sender: TObject);
begin
  dmProdutos.qrySubCategorias.Locate('SUBCATEGORIA', Combobox2.Text, [])
end;

procedure TfrmCadastroProdutos.dsDataChange(Sender: TObject; Field: TField);
begin
  btnEditar.Enabled := ds.DataSet.RecNo > 0;
  btnExcluir.Enabled := ds.DataSet.RecNo > 0;
end;

procedure TfrmCadastroProdutos.FormActivate(Sender: TObject);
begin
  AtualizarGrid;
end;

procedure TfrmCadastroProdutos.AtualizarGrid;
begin
  if dmProdutos <> nil then
  begin
    dmProdutos.qryProdutos.Close;
    dmProdutos.qryProdutos.Open;
  end;
end;

procedure TfrmCadastroProdutos.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Combobox1.Items.Clear;
  dmProdutos.qryCategorias.First;
  while Not(dmProdutos.qryCategorias.Eof) do
  Begin
    Combobox1.Items.Add(dmProdutos.qryCategorias.Fields[1].AsString);
    dmProdutos.qryCategorias.Next;
  End;

  dmProdutos.qryCategorias.First;
end;

end.
