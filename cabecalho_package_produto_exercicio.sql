create or replace PACKAGE PRODUTO_EXERCICIO_PAC is
-- Fun��o onde cd_produto e retornamos a categoria do mesmo, vinda de uma tabela de Produtos e Categorias
FUNCTION RETORNA_CATEGORIA
(p_COD IN produto_exercicio.cod%type)
RETURN produto_exercicio.categoria%type;

-- Fun��o que retorna o imposto percentual do produto, de acordo com sua categoria
FUNCTION RETORNA_IMPOSTO 
(p_COD_PRODUTO produto_venda_exercicio.cod_produto%type)
RETURN produto_venda_exercicio.percentual_imposto%type;

-- Inclui dados de vendas recebendo determinados par�metros e colocando no INSERT
PROCEDURE INCLUINDO_DADOS_VENDA 
(
p_ID produto_venda_exercicio.id%type,
p_COD_PRODUTO produto_venda_exercicio.cod_produto%type,
p_DATA produto_venda_exercicio.data%type,
p_QUANTIDADE produto_venda_exercicio.quantidade%type,
p_PRECO produto_venda_exercicio.preco%type
);

-- inclui o produto de acordo com os dados vindos do par�metro, neste caso a categoria est� definida
PROCEDURE INCLUINDO_PRODUTO 
(p_COD produto_exercicio.cod%type
, p_DESCRICAO produto_exercicio.descricao%type
, p_CATEGORIA produto_exercicio.categoria%type);


-- incluir o produto de acordo com os dados vindos do par�metro, neste caso a categoria ser� indefinida
PROCEDURE INCLUINDO_PRODUTO 
(p_COD produto_exercicio.cod%type
, p_DESCRICAO produto_exercicio.descricao%type);



c_suco_fruta NUMBER(10) := 10;
c_agua NUMBER(10) := 20;
c_mate NUMBER(10) := 15;

-- constantes padronizadas,para adpta��o dentro de nosso corpo de c�digos: 
--Ou seja, a mudan�a de limites podem ser dentro do pr�prio cabe�alho do pacote,
-- compilando um primeiro, e depois passando para o pr�ximo.


end;