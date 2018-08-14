unit ufrmCadProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, ProdutosControler;

type
  TfrmCadProdutos = class(TForm)
    cbxCategoria: TComboBox;
    cbxSubCategoria: TComboBox;
    edtProduto: TEdit;
    edtDescricao: TEdit;
    edtCaracteristicasTecnicas: TEdit;
    edtQtdMinima: TEdit;
    edtVlrUnitario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    btnOk: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure cbxCategoriaChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxSubCategoriaChange(Sender: TObject);
  private
    FProduto: TProduto;
    procedure SetProduto(const Value: TProduto);
    procedure ListarSubCategorias;
    { Private declarations }
  public
    { Public declarations }
    Property Produto : TProduto read FProduto write SetProduto;
  end;

var
  frmCadProdutos: TfrmCadProdutos;

implementation

{$R *.dfm}

uses UDMProdutos;

procedure TfrmCadProdutos.btnCancelarClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
  Self.CloseModal;
end;

procedure TfrmCadProdutos.btnOkClick(Sender: TObject);
Var
  qtd : Integer;
  vll : Single;
begin
  if Trim(edtProduto.Text) = '' then
  Begin
    Application.MessageBox(PWideChar('Informe o Nome do Produto'), PWideChar('CAMPO OBRIGATÓRIO:'), MB_ICONWARNING + MB_OK);
    edtProduto.SetFocus;
    exit;
  End;

  if TryStrToInt(edtQtdMinima.Text, qtd) = False then
  Begin
    Application.MessageBox(PWideChar('Digite um valor Inteiro maior que zero'), PWideChar('VALOR INVÁLIDO'), MB_ICONWARNING + MB_OK);
    edtQtdMinima.SetFocus;
    exit;
  End;

  if TryStrToFloat(edtVlrUnitario.Text, vll) = False then
  Begin
    Application.MessageBox(PWideChar('Digite um valor Numérico Válido'), PWideChar('VALOR INVÁLIDO'), MB_ICONWARNING + MB_OK);
    edtVlrUnitario.SetFocus;
    exit;
  End;

  FProduto.CodCatSubCat := dmProdutos.qrySubCategorias.Fields[3].AsInteger;
  FProduto.Produto := edtProduto.Text;
  FProduto.Descricao := edtDescricao.Text;
  FProduto.CaracteristicasTecnicas := edtCaracteristicasTecnicas.Text;
  FProduto.ValorUnitario := vll;
  FProduto.QuantidadeMinima := qtd;
  Self.ModalResult := mrOk;
  Self.CloseModal;
end;

procedure TfrmCadProdutos.cbxCategoriaChange(Sender: TObject);
begin
  ListarSubCategorias;
  btnOk.Enabled := (cbxCategoria.ItemIndex >= 0) and (cbxSubCategoria.ItemIndex >= 0);
end;

procedure TfrmCadProdutos.cbxSubCategoriaChange(Sender: TObject);
begin
  if dmProdutos.qrySubCategorias.Locate('SUBCATEGORIA', cbxSubCategoria.Text, []) Then
     btnOk.Enabled := (cbxCategoria.ItemIndex >= 0) and (cbxSubCategoria.ItemIndex >= 0)
  else
     btnOk.Enabled := False;
end;

procedure TfrmCadProdutos.FormCreate(Sender: TObject);
begin
  cbxCategoria.Items.Clear;
  dmProdutos.qryCategorias.First;
  while Not(dmProdutos.qryCategorias.Eof) do
  Begin
    cbxCategoria.Items.Add(dmProdutos.qryCategorias.Fields[1].AsString);
    dmProdutos.qryCategorias.Next;
  End;

  dmProdutos.qryCategorias.First;
end;

procedure TfrmCadProdutos.SetProduto(const Value: TProduto);
begin
  FProduto := Value;
  if FProduto <> Nil then
  Begin
    If (dmProdutos.qryCategorias.Locate('CODIGO', FProduto.CodCatSubCat div 1000, [])) Then
    Begin
      cbxCategoria.ItemIndex := cbxCategoria.Items.IndexOf(dmProdutos.qryCategorias.Fields[1].AsString);
      ListarSubCategorias;
      If (dmProdutos.qrySubCategorias.Locate('COD_CAT_SUB_CAT', FProduto.CodCatSubCat, [])) Then
          cbxSubCategoria.ItemIndex := cbxSubCategoria.Items.IndexOf(dmProdutos.qrySubCategorias.Fields[2].AsString);
    End;
    Self.edtProduto.Text := FProduto.Produto;
    Self.edtDescricao.Text := FProduto.Descricao;
    Self.edtCaracteristicasTecnicas.Text := FProduto.CaracteristicasTecnicas;
    Self.edtVlrUnitario.Text := FloatToStr(FProduto.ValorUnitario);
    Self.edtQtdMinima.Text := IntToStr(FProduto.QuantidadeMinima);

    btnOk.Enabled := (cbxCategoria.ItemIndex >= 0) and (cbxSubCategoria.ItemIndex >= 0)
  End;
end;

procedure TfrmCadProdutos.ListarSubCategorias;
begin
  if dmProdutos.qryCategorias.Locate('CATEGORIA', cbxCategoria.Text, []) then
  begin
    cbxSubCategoria.Clear;
    dmProdutos.qrySubCategorias.First;
    while not (dmProdutos.qrySubCategorias.Eof) do
    begin
      cbxSubCategoria.Items.Add(dmProdutos.qrySubCategorias.Fields[2].AsString);
      dmProdutos.qrySubCategorias.Next;
    end;
  end;
end;

end.
