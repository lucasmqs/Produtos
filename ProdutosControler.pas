unit ProdutosControler;

interface

uses
  System.SysUtils, System.Classes;

type
  TProduto = Class
  private
    FProduto: String;
    FCaracteristicasTecnicas: String;
    FDescricao: String;
    FCodigo: Integer;
    FValorUnitario: Real;
    FQuantidadeMinima: Integer;
    FCodCatSubCat: Integer;
    procedure SetCaracteristicasTecnicas(const Value: String);
    procedure SetCodCatSubCat(const Value: Integer);
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetProduto(const Value: String);
    procedure SetQuantidadeMinima(const Value: Integer);
    procedure SetValorUnitario(const Value: Real);
  protected
  public
    Constructor Create; Overload;
    Constructor Create(cod_val, cod_catsbcat : Integer; prod_val, desc_val, cararcteristicas : String;
      vlr_unitario : real; qtd_min : Integer); Overload;
    Property Codigo : Integer read FCodigo write SetCodigo;
    Property CodCatSubCat : Integer read FCodCatSubCat write SetCodCatSubCat;
    Property Produto : String read FProduto write SetProduto;
    Property Descricao : String read FDescricao write SetDescricao;
    Property CaracteristicasTecnicas : String read FCaracteristicasTecnicas write SetCaracteristicasTecnicas;
    Property ValorUnitario : Real read FValorUnitario write SetValorUnitario;
    Property QuantidadeMinima : Integer read FQuantidadeMinima write SetQuantidadeMinima;
  End;


implementation


{ TProduto }

constructor TProduto.Create;
begin

end;

constructor TProduto.Create(cod_val, cod_catsbcat: Integer; prod_val, desc_val,
  cararcteristicas: String; vlr_unitario: real; qtd_min: Integer);
begin
  Self.Codigo := cod_val;
  Self.CodCatSubCat := cod_catsbcat;
  Self.Produto := prod_val;
  Self.Descricao := desc_val;
  Self.CaracteristicasTecnicas := cararcteristicas;
  Self.ValorUnitario := vlr_unitario;
  Self.QuantidadeMinima := qtd_min;
end;

procedure TProduto.SetCaracteristicasTecnicas(const Value: String);
begin
  FCaracteristicasTecnicas := Value;
end;

procedure TProduto.SetCodCatSubCat(const Value: Integer);
begin
  FCodCatSubCat := Value;
end;

procedure TProduto.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProduto.SetProduto(const Value: String);
begin
  FProduto := Value;
end;

procedure TProduto.SetQuantidadeMinima(const Value: Integer);
begin
  FQuantidadeMinima := Value;
end;

procedure TProduto.SetValorUnitario(const Value: Real);
begin
  FValorUnitario := Value;
end;

end.
