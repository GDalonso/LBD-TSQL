-- CREATE DATABASE extabelaspedido01

CREATE TABLE CLIENTE
(idcliente INTEGER NOT NULL IDENTITY PRIMARY KEY,
nomecliente VARCHAR(40) NOT NULL,
CNPJCPF_Cliente INT NOT NULL
)

CREATE TABLE ENDERECO(
    seqendereco INTEGER NOT NULL IDENTITY PRIMARY KEY,
    endercliente VARCHAR(50) NOT NULL,
    bairrocliente VARCHAR(50) NOT NULL,
    cepcliente INT NOT NULL,
    cidadecliente VARCHAR(50) NOT NULL,
    ufcliente VARCHAR(2) NOT NULL,

-- CHAVE ESTRANGEIRA
    idcliente integer, 

  CONSTRAINT FK1_idcliente FOREIGN KEY(idcliente) REFERENCES CLIENTE(idcliente)
)
GO

CREATE TABLE VENDEDOR(
    codvendedor INTEGER NOT NULL IDENTITY PRIMARY KEY,
    nomevendedor VARCHAR(30)
)
GO

CREATE TABLE PEDIDO
 (idpedido INTEGER NOT NULL IDENTITY PRIMARY KEY,
  datapedido DATE NOT NULL,
  vl_totalpedido FLOAT NOT NULL,
  vl_liquidopedido FLOAT NOT NULL,

--   CHAVES ESTRANGEIRAS
  idcliente INTEGER,
  seqendereco INTEGER,
  codvendedor INTEGER,

  CONSTRAINT FK1_idclientee FOREIGN KEY(idcliente) REFERENCES CLIENTE(idcliente),
  CONSTRAINT FK2_seqendereco FOREIGN KEY(seqendereco) REFERENCES ENDERECO(seqendereco),
  CONSTRAINT FK3_codvendedor FOREIGN KEY(codvendedor) REFERENCES VENDEDOR(codvendedor),
 )
GO


CREATE TABLE ITEM(
    coditem INTEGER NOT NULL IDENTITY PRIMARY KEY,
    descitem VARCHAR(50) NOT NULL,
    vl_unitarioitem FLOAT NOT NULL, 
    unidademedidaitem VARCHAR(10),

)
GO

CREATE TABLE ITEM_PEDIDO(    
    qtditem INTEGER NOT NULL,
    vl_totalitem FLOAT NOT NULL,
    perc_desconto_item FLOAT NOT NULL,

-- CHAVES ESATRANGEIRAS
    idepedido INTEGER,
    coditem INTEGER,

    CONSTRAINT FK1_idpedido FOREIGN KEY(idepedido) REFERENCES PEDIDO(idpedido),
    CONSTRAINT FK2_coditem FOREIGN KEY(coditem) REFERENCES ITEM(coditem),
)
GO