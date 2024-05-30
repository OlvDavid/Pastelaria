CREATE DATABASE pastelaria;

USE pastelaria;

-- Tabela de Clientes
CREATE TABLE clientes(
	id_clientes INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_completo VARCHAR(45) NOT NULL,
    nome_social VARCHAR(45),
    cpf VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL
);

-- Tabela de Pastéis
CREATE TABLE pasteis(
	id_pasteis INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    categoria ENUM('Normal', 'Vegano', 'Vegetariano', 'Sem lactose') NOT NULL
);

-- Tabela de Recheios
CREATE TABLE recheios(
	id_recheios INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL
);

-- Tabela de tamanho dos Pastéis
CREATE TABLE tamanho_pasteis(
	id_tamanho_pasteis INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tamanho CHAR(5) NOT NULL UNIQUE,
    preco DECIMAL(8,2) NOT NULL,
    id_pasteis INT NOT NULL,
    CONSTRAINT fk_tamanho_pasteis_pasteis FOREIGN KEY (id_pasteis) REFERENCES pasteis(id_pasteis),
    CONSTRAINT chk_tamanho CHECK (tamanho IN ('P', 'M', 'G'))
);

-- Relacionamento entre pastéis e recheios
CREATE TABLE pastel_recheios(
	id_recheios INT NOT NULL,
    id_pasteis INT NOT NULL,
    CONSTRAINT fk_pastel_recheios_recheios FOREIGN KEY (id_recheios) REFERENCES recheios(id_recheios),
    CONSTRAINT fk_pastel_recheios_pasteis FOREIGN KEY (id_pasteis) REFERENCES pasteis(id_pasteis),
    PRIMARY KEY (id_recheios, id_pasteis)
);

-- Tabela de Produtos(Bebida e sobremesa)
CREATE TABLE produtos(
	id_produtos INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    categoria ENUM('Bebida', 'Sobremesa') NOT NULL,
    preco DECIMAL(8,2) NOT NULL
);

-- Tabela de Itens do pedido
CREATE TABLE itens_pedido(
	id_itens_pedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_produtos INT NOT NULL,
    id_pedido INT NOT NULL,
    id_tamanho_pastel INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT fk_itens_pedido_produtos FOREIGN KEY (id_produtos) REFERENCES produtos(id_produtos),
    CONSTRAINT fk_itens_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedidos),
    CONSTRAINT fk_itens_pedido_tamanho_pastel FOREIGN KEY (id_tamanho_pastel) REFERENCES tamanho_pasteis(id_tamanho_pasteis)
);

-- Tabela de Pedidos
CREATE TABLE pedidos(
	id_pedidos INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_clientes INT NOT NULL,
    data_pedido DATE NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes)
);
    



	


