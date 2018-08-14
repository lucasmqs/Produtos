-- Banco de dados MySQL
-- Versão 5.5 32 bits
-- Porta Configurada atualmente no componete de conexão 3308
-- alterar porta antes de compilar o projeto
-- Obrigado
Create Database tmp_db;

Create Table TB_CAT_PRODUTOS
(
    CODIGO Integer Not Null Auto_Increment,
    CATEGORIA Varchar(50) Not Null,
    CONSTRAINT Pk_cat_produtos Primary Key(CODIGO),
    CONSTRAINT un_categoria Unique(CATEGORIA),
    CONSTRAINT ch_cod_cat_prod check(CODIGO > 99 and CODIGO < 1000)
);

Alter Table TB_CAT_PRODUTOS Auto_Increment = 100;

Create Table TB_SUB_CAT_PRODUTOS
(
    COD_CATEGORIA Integer Not Null,
    COD_ITEM Integer,
    SUBCATEGORIA Varchar(50) Not Null,
    COD_CAT_SUB_CAT Integer,
    CONSTRAINT Pk_sb_cat_produtos Primary Key(COD_CATEGORIA, COD_ITEM),
    CONSTRAINT fk_cat_sub_cat Foreign Key(COD_CATEGORIA) References TB_CAT_PRODUTOS(CODIGO),
    CONSTRAINT un_cod_cat_sb_cat Unique(COD_CAT_SUB_CAT)
);

Delimiter $$

Create Trigger TG_BI_TB_SB_CAT_PROD  Before INSERT
On TB_SUB_CAT_PRODUTOS
For Each Row
BEGIN
   Declare cod Integer;
   If (New.COD_CATEGORIA Is NOT NULL) Then
      If (New.COD_ITEM IS NULL) OR (New.Cod_Item = 0) Then
         Select Count(*) From TB_SUB_CAT_PRODUTOS Where (COD_CATEGORIA = New.COD_CATEGORIA) Into cod;
         
         If (cod = 0) Then
            Set New.COD_ITEM = 1;
         else
            Select Max(COD_ITEM) From TB_SUB_CAT_PRODUTOS Where (COD_CATEGORIA = New.COD_CATEGORIA) Into cod;
            Set New.COD_ITEM = cod + 1;
         end If;
      End If;

      If (new.COD_ITEM = 0) Then
         Set New.COD_ITEM = 1;

      end if;
      
      Set New.COD_CAT_SUB_CAT = 1000 * New.COD_CATEGORIA + New.COD_ITEM;
   End If;
END; $$

Create Trigger TG_BU_TB_SB_CAT_PROD  Before UPDATE
On TB_SUB_CAT_PRODUTOS
For Each Row
BEGIN
   Declare cod Integer;
   If (New.COD_CATEGORIA Is NOT NULL) Then
      If (New.COD_ITEM IS NULL) OR (New.Cod_Item = 0) Then
         Select Count(*) From TB_SUB_CAT_PRODUTOS Where (COD_CATEGORIA = New.COD_CATEGORIA) Into cod;
         
         If (cod = 0) Then
            Set New.COD_ITEM = 1;
         else
            Select Max(COD_ITEM) From TB_SUB_CAT_PRODUTOS Where (COD_CATEGORIA = New.COD_CATEGORIA) Into cod;
            Set New.COD_ITEM = cod + 1;
         end If;
      End If;

      If (new.COD_ITEM = 0) Then
         Set New.COD_ITEM = 1;

      end if;
      
      Set New.COD_CAT_SUB_CAT = 1000 * New.COD_CATEGORIA + New.COD_ITEM;
   End If;
END; $$


Delimiter ;

Create Table TB_PRODUTOS
(
    CODIGO Integer NOT Null Auto_Increment,
    COD_CAT_SUB_CAT Integer NOT Null,
    PRODUTO Varchar(80) NOT Null,
    DESCRICAO Varchar(120),
    CARACTERISTICAS_TECNICAS Varchar(600),
    VALOR_UNITARIO Decimal(12,3) Not Null,
    QUANTIDADE_MINIMA Integer Not Null Default 10,
    CONSTRAINT pk_produtos Primary Key(CODIGO),
    CONSTRAINT fk_cat_prod_sub_cat Foreign Key(COD_CAT_SUB_CAT) References TB_SUB_CAT_PRODUTOS(COD_CAT_SUB_CAT)
)

