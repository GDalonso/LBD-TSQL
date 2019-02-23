-- Exercises
-- todos os cargos da empresa.
SELECT NOME FROM cargo

-- o cargo (em maiúsculo) do funcionário Jóse dos Santos.
SELECT UPPER(NOME) FROM CARGO WHERE COD=(SELECT CODCARGO FROM FUNC WHERE NOME = 'José dos Santos')

--  nome (em minúsculo) e o salário dos programadores.
SELECT LOWER(NOME), SALARIO FROM func

-- os funcionários admitidos no mês de outubro do ano passado.

SELECT *
FROM cargo JOIN func ON (cargo.cod = func.codcargo) 
WHERE MONTH(func.dataadm) = '10' AND YEAR(dataadm) = (SELECT YEAR(getdate())-1);

-- todos os salários diferentes.
SELECT Distinct(salario) FROM func

-- todos os projetos da empresa ordenados pela data de início em ordem decrescente.
SELECT * FROM proj ORDER BY dataini DESC;

-- quantos funcionários existem na empresa.
SELECT COUNT(nome) FROM func;

-- o total de funcionários por cargo.
SELECT COUNT(func.nome) as TotalFuncs, cargo.nome FROM func JOIN cargo ON (func.codcargo = cargo.cod) GROUP BY cargo.nome;

-- a média de funcionários alocados por projeto.
-- TODO ARRUMAR
SELECT count(codproj)/(SELECT count(sigla) from proj) from func_proj

-- quanto se gasta mensalmente com salários de programador.
SELECT SUM(salario) from func where codcargo=1
SELECT SUM(func.salario) from func JOIN cargo ON (func.codcargo = cargo.cod) where cargo.nome='Programador';

-- quanto se gasta anualmente com salários de analistas de sistemas.
SELECT SUM(func.salario)*12 from func JOIN cargo ON (func.codcargo = cargo.cod) where cargo.nome='Analista de Sistemas';

-- o funcionário mais antigo e o funcionário mais recente.
-- mais novo
SELECT TOP 1 * from func ORDER BY dataadm DESC
SELECT * from func where dataadm=(SELECT MAX(dataadm) FROM func) 

-- mais antigo

SELECT TOP 1 * from func ORDER BY dataadm ASC 
SELECT * FROM func WHERE dataadm=(SELECT MIN(dataadm) FROM func)

-- O mais novo e o mais antigo
SELECT * from func 
where func.dataadm = (SELECT MAX(dataadm) from func)
OR func.dataadm = (SELECT MIN(dataadm) from func);

-- o nome e a descrição do cargo dos funcionários alocados no projeto ALFA1.
SELECT func.nome, cargo.nome FROM func 
JOIN cargo on (func.codcargo=cargo.cod) 
JOIN func_proj on (func.cod=func_proj.codfunc) 
JOIN proj ON (func_proj.codproj=proj.cod) 
WHERE proj.sigla = 'ALFA1';

-- Mesma query, mais difícil de ler
SELECT func.nome, cargo.nome FROM func 
JOIN cargo on (func.codcargo=cargo.cod) 
WHERE func.cod in 
(SELECT func.cod from func 
JOIN func_proj on (func.cod=func_proj.codfunc) 
JOIN proj ON (func_proj.codproj=proj.cod) 
WHERE proj.sigla =  'ALFA1');

-- quantos funcionários foram contratados em 2003.
SELECT COUNT(cod) FROM func where 2003 in (SELECT YEAR(dataadm) FROM func)

-- quantos programadores foram contratados no ano atual.

SELECT count(func.cod) 
FROM cargo JOIN func ON (cargo.cod = func.codcargo) 
WHERE cargo.nome = 'Programador'
AND YEAR(func.dataadm) = (
    SELECT YEAR(func.dataadm) 
    FROM func 
    WHERE YEAR(dataadm) = (SELECT YEAR(getdate())));

-- o(s) projeto(s) com maior gasto mensal em salários.
SELECT SUM(func.salario) as salariosperproject, proj.sigla  from func JOIN func_proj ON (func.cod = func_proj.codfunc) JOIN proj ON (func_proj.codproj=proj.cod) GROUP BY proj.sigla ORDER BY SUM(func.salario) DESC;

SELECT TOP 1 SUM(func.salario) as salariosperproject, proj.sigla  
FROM func 
JOIN func_proj ON (func.cod = func_proj.codfunc) 
JOIN proj ON (func_proj.codproj=proj.cod) 
GROUP BY proj.sigla 
ORDER BY SUM(func.salario) DESC;

-- o(s) projeto(s) com o menor número de funcionários alocados.
SELECT COUNT(func_proj.codfunc), proj.sigla from func_proj JOIN proj ON (func_proj.codproj = proj.cod) GROUP BY proj.sigla ORDER BY COUNT(func_proj.codfunc) DESC;

SELECT TOP 1 COUNT(func_proj.codfunc), proj.sigla 
FROM func_proj 
JOIN proj ON (func_proj.codproj = proj.cod) 
GROUP BY proj.sigla 
ORDER BY COUNT(func_proj.codfunc) DESC;

-- o(s) projeto(s) com mais analistas de sistemas do que programadores.
-- TODO arrumar
SELECT proj.sigla from proj 
join func_proj ON (proj.cod = func_proj.codproj)
join func on (func_proj.codfunc=func.cod)
join cargo on (func.codcargo = cargo.cod)
where
(SELECT count(func.cod) from func join cargo on (func.codcargo=cargo.cod) where cargo.nome = 'Analista de Sistemas') > 
(SELECT count(func.cod) from func join cargo on (func.codcargo=cargo.cod) where cargo.nome = 'Programador')
group by proj.sigla


SELECT * from func;
SELECT * FROM proj;
SELECT * FROM func_proj;
SELECT * FROM cargo;

-- Outras queries
-- segundo maior salario
SELECT  max(salario) from func where func.salario NOT IN (SELECT MAX(salario) from func);
-- empregado com o segundo maior salario
SELECT * FROM func WHERE salario=(SELECT  max(salario) from func where func.salario NOT IN (SELECT MAX(salario) from func));

-- Primeiro nome dos empregados
select substring(nome, 1, charindex(' ',nome)) from func