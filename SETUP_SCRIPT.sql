CREATE TABLE cargo
 (cod INTEGER NOT NULL,
  nome VARCHAR(20) NOT NULL,
  CONSTRAINT PK_cargo PRIMARY KEY (cod)
 )
go

CREATE TABLE func
 (cod INTEGER NOT NULL,
  nome VARCHAR(30) NOT NULL,
  dataadm DATETIME NULL,
  salario DEC(12,2) NULL,
  codcargo INTEGER NOT NULL,
  CONSTRAINT PK_func PRIMARY KEY(cod),
  CONSTRAINT FK1_func FOREIGN KEY(codcargo)
    REFERENCES cargo(cod)
 )
go

CREATE TABLE proj
 (cod INTEGER NOT NULL,
  sigla VARCHAR(10) NOT NULL,
  dataini DATETIME NOT NULL,
  CONSTRAINT PK_proj PRIMARY KEY (cod)
 )
go

CREATE TABLE func_proj
 (codproj INTEGER NOT NULL,
  codfunc INTEGER NOT NULL,
  dataaloc DATETIME NULL,
  CONSTRAINT PK_func_proj PRIMARY KEY(codproj, codfunc),
  CONSTRAINT FK1_func_proj FOREIGN KEY(codproj) REFERENCES proj(cod),
  CONSTRAINT FK2_func_proj FOREIGN KEY(codfunc) REFERENCES func(cod)
 )
go

-- Cargos
INSERT INTO cargo VALUES(1, 'Programador')
INSERT INTO cargo VALUES(2, 'Analista de Sistemas')
INSERT INTO cargo VALUES(3, 'Coordenador')
INSERT INTO cargo VALUES(4, 'Adm de Dados')
go

-- Funcionarios
INSERT INTO func VALUES(1, 'José dos Santos', '01/13/2003', 2000.00, 1)
INSERT INTO func VALUES(2, 'José da Silva', '01/13/2003', 1500.00, 1)
INSERT INTO func VALUES(3, 'José de Souza', '01/13/2004', 1800.00, 2)
INSERT INTO func VALUES(4, 'Antonia dos Santos', '02/13/2003', 2000.00, 1)
INSERT INTO func VALUES(5, 'Antonia da Silva', '02/13/2003', 1500.00, 1)
INSERT INTO func VALUES(6, 'Antonia de Souza', '02/13/2004', 1500.00, 2)
INSERT INTO func VALUES(7, 'Maria Joana', '03/13/2003', 2000.00, 4)
INSERT INTO func VALUES(8, 'Maria Antonia', '03/13/2003', 1800.00, 3)
INSERT INTO func VALUES(9, 'Maria Fernanda', '03/13/2004', 1500.00, 2)
INSERT INTO func VALUES (10,'JAJA de Arg', '2018/10/18', 1090,3)
INSERT INTO func VALUES (11,'Hue do Br', '2019/02/22', 3000,1)
go

--PROJ
INSERT INTO proj VALUES(1, 'ALFA1', '01/13/2003');
INSERT INTO proj VALUES(2, 'ALFA2', '05/13/2003');
INSERT INTO proj VALUES(3, 'BETA1', '08/13/2003');
INSERT INTO proj VALUES(4, 'BETA2', '01/13/2004');
INSERT INTO proj VALUES(5, 'GAMA1', '04/13/2004');
INSERT INTO proj VALUES(6, 'GAMA2', '06/13/2004');
go

-- FUNC_PROJ
INSERT INTO func_proj VALUES(1, 1, '01/13/2003');
INSERT INTO func_proj VALUES(1, 2, '01/13/2003');
INSERT INTO func_proj VALUES(1, 3, '01/13/2003');
INSERT INTO func_proj VALUES(1, 4, '01/13/2003');
INSERT INTO func_proj VALUES(1, 5, '01/13/2003');
INSERT INTO func_proj VALUES(1, 6, '01/13/2004');
INSERT INTO func_proj VALUES(1, 7, '01/13/2004');
INSERT INTO func_proj VALUES(1, 8, '01/13/2004');
INSERT INTO func_proj VALUES(1, 9, '01/13/2004');
INSERT INTO func_proj VALUES(2, 1, '01/13/2003');
INSERT INTO func_proj VALUES(2, 2, '01/13/2003');
INSERT INTO func_proj VALUES(2, 4, '01/13/2003');
INSERT INTO func_proj VALUES(2, 5, '01/13/2003');
INSERT INTO func_proj VALUES(2, 6, '01/13/2004');
INSERT INTO func_proj VALUES(2, 7, '01/13/2004');
INSERT INTO func_proj VALUES(2, 8, '01/13/2004');
INSERT INTO func_proj VALUES(2, 9, '01/13/2004');
INSERT INTO func_proj VALUES(3, 1, '01/13/2003');
INSERT INTO func_proj VALUES(3, 2, '01/13/2003');
INSERT INTO func_proj VALUES(3, 3, '01/13/2003');
INSERT INTO func_proj VALUES(3, 6, '01/13/2004');
INSERT INTO func_proj VALUES(3, 7, '01/13/2004');
INSERT INTO func_proj VALUES(3, 8, '01/13/2004');
INSERT INTO func_proj VALUES(3, 9, '01/13/2004');
INSERT INTO func_proj VALUES(4, 1, '01/13/2003');
INSERT INTO func_proj VALUES(4, 2, '01/13/2003');
INSERT INTO func_proj VALUES(4, 6, '01/13/2004');
INSERT INTO func_proj VALUES(4, 7, '01/13/2004');
INSERT INTO func_proj VALUES(4, 8, '01/13/2004');
INSERT INTO func_proj VALUES(4, 9, '01/13/2004');
INSERT INTO func_proj VALUES(5, 1, '01/13/2003');
INSERT INTO func_proj VALUES(5, 2, '01/13/2003');
INSERT INTO func_proj VALUES(5, 3, '01/13/2003');
INSERT INTO func_proj VALUES(5, 4, '01/13/2003');
INSERT INTO func_proj VALUES(5, 5, '01/13/2003');
INSERT INTO func_proj VALUES(5, 9, '01/13/2004');
INSERT INTO func_proj VALUES(6, 2, '01/13/2003');
INSERT INTO func_proj VALUES(6, 5, '01/13/2003');
INSERT INTO func_proj VALUES(6, 7, '01/13/2004');
INSERT INTO func_proj VALUES(6, 8, '01/13/2004');
GO


UPDATE cargo SET nome='Coord de Projeto' WHERE cod=3
UPDATE func SET dataadm = '2004-10-16' where cod=2;
GO

DELETE FROM func_proj WHERE codfunc=8 AND codproj=6
GO

-- Exercicios
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

-- segundo maior salario
SELECT  max(salario) from func where func.salario NOT IN (SELECT MAX(salario) from func);
-- empregado com o segundo maior salario
SELECT * FROM func WHERE salario=(SELECT  max(salario) from func where func.salario NOT IN (SELECT MAX(salario) from func));

-- First name of the employees
select substring(nome, 1, charindex(' ',nome)) from func