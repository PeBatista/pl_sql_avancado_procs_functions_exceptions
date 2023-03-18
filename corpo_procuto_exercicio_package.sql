create or replace PACKAGE BODY PRODUTO_EXERCICIO_PAC
IS

FUNCTION RETORNA_CATEGORIA
(p_COD IN produto_exercicio.cod%type)
RETURN produto_exercicio.categoria%type
IS
   v_CATEGORIA produto_exercicio.categoria%type;
BEGIN
    SELECT CATEGORIA INTO v_CATEGORIA FROM PRODUTO_EXERCICIO WHERE COD = p_COD;
    RETURN v_CATEGORIA;
END;

FUNCTION RETORNA_IMPOSTO 
(p_COD_PRODUTO produto_venda_exercicio.cod_produto%type)
RETURN produto_venda_exercicio.percentual_imposto%type
IS
   v_CATEGORIA produto_exercicio.categoria%type;
   v_IMPOSTO produto_venda_exercicio.percentual_imposto%type;
BEGIN
    v_CATEGORIA := retorna_categoria(p_COD_PRODUTO);
    IF TRIM(v_CATEGORIA) = 'Sucos de Frutas' THEN
        v_IMPOSTO := c_suco_fruta;
    ELSIF TRIM(v_CATEGORIA) = 'Águas' THEN
        v_IMPOSTO := c_agua;
    ELSIF TRIM(v_CATEGORIA) = 'Mate' THEN
        v_IMPOSTO := c_mate;
    END IF;
    RETURN v_IMPOSTO;
END;

PROCEDURE INCLUINDO_PRODUTO 
(p_COD produto_exercicio.cod%type
, p_DESCRICAO produto_exercicio.descricao%type
, p_CATEGORIA produto_exercicio.categoria%type)
IS
BEGIN
   INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA) VALUES (p_COD, REPLACE(p_DESCRICAO,'-','>')
   , p_CATEGORIA);
   COMMIT;
exception
    WHEN exception_pac.e_null then
    raise_application_error(-20034, 'NÃO PODE COLOCAR O CÓDIGO PK COMO NULO');
END;

PROCEDURE INCLUINDO_DADOS_VENDA 
(
p_ID produto_venda_exercicio.id%type,
p_COD_PRODUTO produto_venda_exercicio.cod_produto%type,
p_DATA produto_venda_exercicio.data%type,
p_QUANTIDADE produto_venda_exercicio.quantidade%type,
p_PRECO produto_venda_exercicio.preco%type
)
IS
   v_VALOR produto_venda_exercicio.valor_total%type;
   v_PERCENTUAL produto_venda_exercicio.percentual_imposto%type;
BEGIN
   v_PERCENTUAL := retorna_imposto(p_COD_PRODUTO);
   v_VALOR := p_QUANTIDADE * p_PRECO;
   INSERT INTO PRODUTO_VENDA_EXERCICIO 
   (id, cod_produto, data, quantidade, preco, valor_total, percentual_imposto) 
   VALUES 
   (p_ID, p_COD_PRODUTO, p_DATA, p_QUANTIDADE, p_PRECO, v_VALOR, v_PERCENTUAL);
    COMMIT;
exception
    when exception_pac.e_null then
    raise_application_error(-20021, 'NÃO PODE COLOCAR O CÓDIGO COMO NULO');
END;


PROCEDURE INCLUINDO_PRODUTO 
(p_COD produto_exercicio.cod%type
, p_DESCRICAO produto_exercicio.descricao%type)
IS
BEGIN
   INSERT INTO PRODUTO_EXERCICIO (COD, DESCRICAO, CATEGORIA) VALUES (p_COD, REPLACE(p_DESCRICAO,'-','>')
   , 'Categoria não definida');
   COMMIT;
exception
    when exception_pac.e_null then
    raise_application_error(-20010, 'NÃO PODE COLOCAR O CÓDIGO COMO NULO');

END;


-- temos um pacote de exceções padronizados, veja na outra parte de códigos, dentro do exception_pac
-- temos dois pacotes agora, pacote de Procedures e funções para acesso de outros usuários e o pacote PACKAGE EXCEPTION_PAC, 
-- não precisa de comandos, apenas de declarações de sensibilidade de erros.
END;