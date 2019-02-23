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


-- Updates
UPDATE cargo SET nome='Coord de Projeto' WHERE cod=3
UPDATE func SET dataadm = '2004-10-16' where cod=2;
GO

-- Deletes
DELETE FROM func_proj WHERE codfunc=8 AND codproj=6
GO