create or replace PACKAGE EXCEPTION_PAC
-- Pacotes de Exceções padronizadas
is
e_null exception;
pragma exception_init(e_null,-1400);--NÃO PODER INCLUI NULO, forçando a sensibilidade
e_fk exception; --PROBLEMA DE CHAVE ESTRANGEIRA
pragma exception_init(e_fk, -2291); 
-- Por exemplo quando colocamos um número nulo no indentificador, vai dar um erro de ORA-01400
-- não temos está listada dentro dos docs ORACLE, então: criar uma variavel de exceção, referenciando a ORA-01400, 
-- sensiblizando ela para estar, passando na pragma exception_int(e_idnulo, -1400)
end;