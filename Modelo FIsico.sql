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

SELECT * FROM clientes;

-- Tabela de Pastéis
CREATE TABLE pasteis(
	id_pasteis INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    categoria ENUM('Normal', 'Vegano', 'Vegetariano', 'Sem lactose') NOT NULL
);

SELECT * FROM pasteis;

-- Tabela de Recheios
CREATE TABLE recheios(
	id_recheios INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL
);

SELECT * FROM recheios;

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
	id_pasteis INT NOT NULL,
    id_recheios INT NOT NULL,
    CONSTRAINT fk_pastel_recheios_recheios FOREIGN KEY (id_recheios) REFERENCES recheios(id_recheios),
    CONSTRAINT fk_pastel_recheios_pasteis FOREIGN KEY (id_pasteis) REFERENCES pasteis(id_pasteis),
    PRIMARY KEY (id_recheios, id_pasteis)
);

SELECT 
    p.descricao AS Pastel,
    r.descricao AS Recheio
FROM 
    pastel_recheios pr
JOIN 
    pasteis p ON pr.id_pasteis = p.id_pasteis
JOIN 
    recheios r ON pr.id_recheios = r.id_recheios;

SELECT * FROM pastel_recheios;

-- Tabela de Produtos(Bebida e sobremesa)
CREATE TABLE produtos(
	id_produtos INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    categoria ENUM('Bebida', 'Sobremesa') NOT NULL,
    preco DECIMAL(8,2) NOT NULL
);

SELECT * FROM produtos;

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


-- Inserindo nomes de pasteis
INSERT INTO pasteis (descricao, categoria) VALUES
('Tradicional da Casa', 'Normal'),
('Dupla Perfeita', 'Normal'),
('Clássico Caipira', 'Normal'),
('Italianíssimo', 'Normal'),
('Palmito Real', 'Vegetariano'),
('Delícia Vegetariana', 'Vegano'),
('Espinafre Crocante', 'Vegano'),
('Tofu Delícia', 'Vegano'),
('Choco Irresistível', 'Vegetariano'),
('Calabresa Sensacional', 'Normal'),
('Casamento Tropical', 'Normal'),
('Casamento Perfeito', 'Normal'),
('Clássico Supremo', 'Normal'),
('Queijo Mania', 'Vegetariano'),
('Delícia Cremosa de Palmito', 'Vegetariano');

-- Inserindo recheios dos pasteis
INSERT INTO recheios (descricao) VALUES
('Carne'),
('Queijo'),
('Frango'),
('Pizza'),
('Palmito'),
('Soja'),
('Espinafre'),
('Tofu'),
('Chocolate'),
('Camarão'),
('Bacon'),
('Calabresa');

INSERT INTO recheios(descricao) VALUES
('Presunto');

INSERT INTO recheios(descricao) VALUES
('Requeijão');

-- Inserindo dados dos clientes
INSERT INTO clientes(nome_completo, nome_social, cpf, telefone, data_nascimento, email, bairro, cidade, estado) VALUES
('David da Silva Oliveira', 'David', '089.765.324-36', '(75) 99263-3400', '2003-05-04', 'davidsilva123@gmail.com', 'Pampalona', 'Feira de Santana', 'BA'),
('Ana Paula dos Santos', NULL, '123.456.789-01', '(75) 91234-5678', '1990-11-22', 'ana.santos@gmail.com', 'Centro', 'Feira de Santana', 'BA'),
('Carlos Alberto Souza', 'Carlos', '234.567.890-12', '(75) 98765-4321', '1985-03-15', 'carlos.souza@hotmail.com', 'Tomba', 'Feira de Santana', 'BA'),
('Mariana Lima Ferreira', 'Mariana', '345.678.901-23', '(75) 99876-5432', '2008-08-30', 'mariana.ferreira@gmail.com', 'Sobradinho', 'Feira de Santana', 'BA'),
('Roberto Mendes Oliveira', NULL, '456.789.012-34', '(75) 98765-1234', '1999-06-14', 'roberto.mendes@gmail.com', 'Sim', 'Feira de Santana', 'BA'),
('Juliana Araujo Silva', 'Juliana', '567.890.123-45', '(75) 91234-0987', '2002-12-05', 'juliana.silva@gmail.com', 'Caseb', 'Feira de Santana', 'BA'),
('Fernando Pereira Santos', NULL, '678.901.234-56', '(75) 92345-6789', '2007-07-25', 'fernando.pereira@gmail.com', 'Mangabeira', 'Feira de Santana', 'BA'),
('Camila Rocha', NULL, '789.012.345-67', '(75) 93456-7890', '2004-04-18', 'camila.rocha@hotmail.com', 'Cidade Nova', 'Feira de Santana', 'BA'),
('Lucas Martins', 'Lucas', '890.123.456-78', '(75) 94567-8901', '2009-02-28', 'lucas.martins@gmail.com', 'Brasília', 'Feira de Santana', 'BA'),
('Isabela Gomes', NULL, '901.234.567-89', '(75) 95678-9012', '1995-10-10', 'isabela.gomes@gmail.com', 'Conceição', 'Feira de Santana', 'BA');


-- Inserindo dados dos produtos(bebidas, sobremesas)
INSERT INTO produtos(descricao, categoria, preco) VALUES
('Suco de Laranja', 'Bebida', 5.00),
('Suco de Maracuja', 'Bebida', 5.00),
('Suco de Abacaxi', 'Bebida', 6.00),
('Coca cola', 'Bebida', 7.00),
('Pepsi', 'Bebida', 6.00),
('Fanta', 'Bebida', 5.00),
('Bolo de Chocolate', 'Sobremesa', 8.00),
('Milk-Shake', 'Sobremesa', 10.00), 
('Pudim', 'Sobremesa', 8.00);

INSERT INTO pastel_recheios(id_pasteis, id_recheios) VALUES
(1, 1);

INSERT INTO pastel_recheios(id_pasteis, id_recheios) VALUES
(2, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 12),
(11, 10),
(11, 11),
(12, 11),
(12, 2),
(13, 13),
(13, 2),
(14, 2),
(15, 5),
(15, 14);






