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
    tamanho ENUM ('P', 'M', 'G') NOT NULL,
    preco DECIMAL(8,2) NOT NULL,
    id_pasteis INT NOT NULL,
    CONSTRAINT fk_tamanho_pasteis_pasteis FOREIGN KEY (id_pasteis) REFERENCES pasteis(id_pasteis)
);

-- Relacionamento entre pastéis e recheios
CREATE TABLE pastel_recheios(
	id_pasteis INT NOT NULL,
    id_recheios INT NOT NULL,
    CONSTRAINT fk_pastel_recheios_recheios FOREIGN KEY (id_recheios) REFERENCES recheios(id_recheios),
    CONSTRAINT fk_pastel_recheios_pasteis FOREIGN KEY (id_pasteis) REFERENCES pasteis(id_pasteis),
    PRIMARY KEY (id_recheios, id_pasteis)
);

-- View de relacionamento de tabelas do pastel e recheios	
CREATE VIEW pastel_recheio_view AS
SELECT 
    p.descricao AS Pastel,
    r.descricao AS Recheio
FROM 
    pastel_recheios pr
JOIN 
    pasteis p ON pr.id_pasteis = p.id_pasteis
JOIN 
    recheios r ON pr.id_recheios = r.id_recheios;

SELECT * FROM pastel_recheio_view;

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
('Tomate com Orégano'),
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
(4, 13),
(4, 2),
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

INSERT INTO tamanho_pasteis(tamanho, preco, id_pasteis) VALUES
('P', 05.00, 1),
('M', 07.00, 1),
('G', 10.00, 1),
('P', 7.00, 2),
('M', 9.00, 2),
('G', 12.00, 2),
('P', 05.00, 3),
('M', 07.00, 3),
('G', 10.00, 3),
('P', 07.00, 4),
('M', 10.00, 4),
('G', 12.00, 4),
('P', 9.00, 5),
('M', 12.00, 5),
('G', 15.00, 5),
('P', 9.00, 6),
('M', 12.00, 6),
('G', 15.00, 6),
('P', 9.00, 7),
('M', 12.00, 7),
('G', 15.00, 7),
('P', 9.00, 8),
('M', 12.00, 8),
('G', 15.00, 8),
('P', 9.00, 9),
('M', 12.00, 9),
('G', 15.00, 9),
('P', 5.00, 10),
('M', 7.00, 10),
('G', 10.00, 10),
('P', 9.00, 11),
('M', 12.00, 11),
('G', 15.00, 11),
('P', 7.00, 12),
('M', 9.00, 12),
('G', 12.00, 12),
('P', 7.00, 13),
('M', 9.00, 13),
('G', 12.00, 13),
('P', 5.00, 14),
('M', 7.00, 14),
('G', 10.00, 14),
('P', 9.00, 15),
('M', 12.00, 15),
('G', 15.00, 15);

SELECT * FROM tamanho_pasteis;

INSERT INTO itens_pedido (id_produtos, id_pedido, id_tamanho_pastel, quantidade) VALUES
(1, 1, 27, 2),
(3, 2, 33, 3),
(2, 3, 22, 1),
(5, 4, 20, 1);

INSERT INTO itens_pedido (id_produtos, id_pedido, id_tamanho_pastel, quantidade) VALUES
(7, 5, 17, 2),
(4, 6, 3, 4);



SELECT * FROM itens_pedido;

INSERT INTO pedidos (id_clientes, data_pedido, forma_pagamento) VALUES
(1, '2023-05-31', 'Dinheiro'),
(2, '2023-05-29', 'Débito'),
(3, '2023-05-11', 'Crédito'),
(4, '2024-03-29', 'Pix'),
(5, '2024-02-01', 'Dinheiro'),
(6, '2024-02-10', 'Dinheiro'),
(7, '2024-01-22', 'Crédito'),
(8, '2024-05-04', 'Pix'),
(9, '2023-12-31', 'Débito'),
(10, '2024-01-01', 'Dinheiro');


SELECT * FROM pedidos;

-- 1. Liste os nomes de todos os pastéis veganos vendidos para pessoas com mais de 18 anos.
SELECT DISTINCT 
    p.descricao AS Pastel_Vegano,
    c.nome_completo AS Nome_Cliente,
    c.data_nascimento AS Data_Nascimento
FROM 
    pasteis p
JOIN 
    tamanho_pasteis tp ON p.id_pasteis = tp.id_pasteis
JOIN 
    itens_pedido ip ON tp.id_tamanho_pasteis = ip.id_tamanho_pastel
JOIN 
    pedidos pe ON ip.id_pedido = pe.id_pedidos
JOIN 
    clientes c ON pe.id_clientes = c.id_clientes
WHERE 
    p.categoria = 'Vegano'
    AND TIMESTAMPDIFF(YEAR, c.data_nascimento, CURDATE()) > 18;

-- 3. Liste todos os pastéis que possuem bacon e/ou queijo em seu recheio.    
SELECT 
    p.descricao AS Pastel,
    GROUP_CONCAT(r.descricao ORDER BY r.descricao SEPARATOR ', ') AS Recheios
FROM 
    pasteis p
JOIN 
    pastel_recheios pr ON p.id_pasteis = pr.id_pasteis
JOIN 
    recheios r ON pr.id_recheios = r.id_recheios
WHERE 
    r.descricao IN ('Bacon', 'Queijo')
GROUP BY 
    p.descricao;

-- 10. VIEW 1, lista todas as vendas feitas no débito. 

CREATE VIEW vendas_debito AS
SELECT id_clientes, data_pedido, forma_pagamento
FROM pedidos
WHERE forma_pagamento = 'Débito';

SELECT * FROM vendas_debito;

-- 10. VIEW 2, lista todos os pasteis veganos.

CREATE VIEW pasteis_veganos AS
SELECT id_pasteis, descricao, categoria
FROM pasteis
WHERE categoria = 'Vegano';

SELECT * FROM pasteis_veganos;

-- 10. VIEW 3, lista todos os clientes nascidos após 1999.

CREATE VIEW clientes_nasc_depois_2000 AS
SELECT nome_completo, nome_social, cpf, telefone, data_nascimento, email, bairro, cidade, estado
FROM clientes
WHERE data_nascimento > '1999-12-31';

SELECT * FROM clientes_nasc_depois_2000;





