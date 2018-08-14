unit UDMProdutos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, ProdutosControler;

type
  TDAOBase = Class
  private
    FConnection: TFDConnection;
    FQuery: TFDQuery;
    FControler : TObject;
    procedure SetConnection(const Value: TFDConnection);
    procedure SetQuery(const Value: TFDQuery);
  protected
    FSQL : String;
    Function Executar(sql : String) : Boolean;
    Function ToSQL(val : Integer) : String; Overload;
    Function ToSQL(val : Real) : String; Overload;
    Function ToSQL(val : string) : String; Overload;

    Function Inserir : Boolean; Virtual;
    Function Atualizar : Boolean; Virtual;
    Function Excluir : Boolean; Virtual;
    Function Listar : Boolean; Virtual;
  public
    Constructor Create; Overload;
    Property Connection : TFDConnection read FConnection write SetConnection;
    Property Query : TFDQuery read FQuery write SetQuery;
  End;

  TDAOProdutos = Class(TDAOBase)
  private
  public
    Constructor Create(o : TProduto);
    Function Inserir : Boolean; Override;
    Function Atualizar : Boolean; Override;
    Function Excluir : Boolean; Override;
    Function Listar : Boolean; Override;
  End;

  TdmProdutos = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryCategorias: TFDQuery;
    DataSource1: TDataSource;
    qrySubCategorias: TFDQuery;
    qryProdutos: TFDQuery;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function Salvar(p: TProduto) : Boolean;
    Function Excluir(p: TProduto) : Boolean;
  end;

var
  dmProdutos: TdmProdutos;

implementation

Uses Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDAOBase }

function TDAOBase.Atualizar: Boolean;
begin
  Result := Executar(Self.FSQL);
end;

constructor TDAOBase.Create;
begin

end;

function TDAOBase.Excluir: Boolean;
begin
  Result := Executar(Self.FSQL);
end;

function TDAOBase.Executar(sql: String): Boolean;
Var
  qry : TFDQuery;
begin
  Result := False;
  if Self.FQuery <> Nil then
     qry := Self.FQuery
  else
  Begin
    qry := TFDQuery.Create(Nil);
    qry.Connection := Self.FConnection;
    qry.Tag := -1;
  End;

  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add(sql);
  qry.ExecSQL;

  if qry.Tag = -1 then
  Begin
    qry.Close;
    qry.Connection := Nil;
    qry.Free;
  End;
  Result := True;
end;

function TDAOBase.Listar: Boolean;
begin
  Result := Executar(Self.FSQL);
end;

function TDAOBase.Inserir: Boolean;
begin
  Result := Executar(Self.FSQL);
end;

procedure TDAOBase.SetConnection(const Value: TFDConnection);
begin
  FConnection := Value;
end;

procedure TDAOBase.SetQuery(const Value: TFDQuery);
begin
  FQuery := Value;
end;

function TDAOBase.ToSQL(val: Integer): String;
begin
  Result := IntToStr(val);
end;

function TDAOBase.ToSQL(val: Real): String;
Var
  aux : String;
begin
  aux := FloatToStr(val);
  Result := StringReplace(aux, ',', '.', [rfReplaceAll]);
end;

function TDAOBase.ToSQL(val: string): String;
begin
  Result := #39 + val + #39;
end;

{ TDAOProdutos }

function TDAOProdutos.Atualizar: Boolean;
Var
  p : TProduto;
begin
  Result := False;
  if Self.FControler <> Nil then
  Begin
    p := TProduto(Self.FControler);
    if p.Codigo > 0 then
    Begin
      Self.FSQL := 'Update TB_Produtos Set ' +
                   ' COD_CAT_SUB_CAT = ' + ToSQL(P.CodCatSubCat) + ', ' +
                   ' PRODUTO = ' + ToSQL(P.Produto) + ', ' +
                   ' DESCRICAO = ' + ToSQL(P.Descricao) + ', ' +
                   ' CARACTERISTICAS_TECNICAS = ' + ToSQL(P.CaracteristicasTecnicas) + ', ' +
                   ' VALOR_UNITARIO = ' + ToSQL(P.ValorUnitario) + ', ' +
                   ' QUANTIDADE_MINIMA = ' + ToSQL(P.QuantidadeMinima) +
                   ' Where CODIGO = ' + ToSQL(p.Codigo);

      Result := Inherited Atualizar;
    End;
  End;
end;

constructor TDAOProdutos.Create(o: TProduto);
begin
  Self.FControler := o;
end;

function TDAOProdutos.Excluir: Boolean;
Var
  p : TProduto;
begin
  Result := False;
  if Self.FControler <> Nil then
  Begin
    p := TProduto(Self.FControler);
    if p.Codigo > 0 then
    Begin
      Self.FSQL := 'Delete From TB_Produtos ' +
                   ' Where CODIGO = ' + ToSQL(p.Codigo);

      Result := Inherited Excluir;
    End;
  End;
end;

function TDAOProdutos.Listar: Boolean;
begin

end;

function TDAOProdutos.Inserir: Boolean;
Var
  p : TProduto;
begin
  Result := False;
  if Self.FControler <> Nil then
  Begin
    p := TProduto(Self.FControler);
    Self.FSQL := 'Insert Into TB_Produtos(COD_CAT_SUB_CAT, PRODUTO, DESCRICAO, ' +
                 'CARACTERISTICAS_TECNICAS, VALOR_UNITARIO, QUANTIDADE_MINIMA) ' +
                 'Values(' + ToSQL(p.CodCatSubCat) + ', ' + ToSQL(p.Produto) + ', ' +
                 ToSQL(p.Descricao) + ', ' + ToSQL(p.CaracteristicasTecnicas) + ', ' +
                 ToSQL(p.ValorUnitario) + ', ' + ToSQL(p.QuantidadeMinima) + ');';

    Result := Inherited Inserir;
  End;
end;

{ TdmProdutos }

procedure TdmProdutos.DataModuleCreate(Sender: TObject);
begin
  qryCategorias.Open;
  qryProdutos.Open;
end;

procedure TdmProdutos.DataSource1DataChange(Sender: TObject; Field: TField);
Var
  sql : String;
begin
  sql := 'Select * From Tb_Sub_Cat_Produtos Where COD_CATEGORIA = ' + IntToStr(qryCategorias.Fields[0].AsInteger);
  qrySubCategorias.Close;
  qrySubCategorias.SQL.Clear;
  qrySubCategorias.SQL.Add(sql);
  qrySubCategorias.Open;
end;

function TdmProdutos.Excluir(p: TProduto): Boolean;
Var
  dao : TDAOProdutos;
begin
  Result := False;
  if (p <> Nil) And (p.Codigo > 0) Then
  Begin
    dao := TDAOProdutos.Create(p);
    dao.Connection := Self.FDConnection1;
    Result := dao.Excluir;
    dao.Free;
  End;
end;

function TdmProdutos.Salvar(p: TProduto): Boolean;
Var
  dao : TDAOProdutos;
begin
  Result := False;
  if (p <> Nil) then
  Begin
    dao := TDAOProdutos.Create(p);
    dao.Connection := Self.FDConnection1;
    if P.Codigo > 0 then
       Result := dao.Atualizar
    else
       Result := dao.Inserir;
    dao.Free;
  End;
end;

end.
