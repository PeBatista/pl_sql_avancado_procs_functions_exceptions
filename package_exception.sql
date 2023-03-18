create or replace PACKAGE EXCEPTION_PAC
-- Pacotes de Exce��es padronizadas
is
e_null exception;
pragma exception_init(e_null,-1400);--N�O PODER INCLUI NULO, for�ando a sensibilidade
e_fk exception; --PROBLEMA DE CHAVE ESTRANGEIRA
pragma exception_init(e_fk, -2291); 
-- Por exemplo quando colocamos um n�mero nulo no indentificador, vai dar um erro de ORA-01400
-- n�o temos est� listada dentro dos docs ORACLE, ent�o: criar uma variavel de exce��o, referenciando a ORA-01400, 
-- sensiblizando ela para estar, passando na pragma exception_int(e_idnulo, -1400)
end;