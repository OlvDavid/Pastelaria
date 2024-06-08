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
CREATE TABLE acompanhamentos(
	id_acompanhamento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    categoria ENUM('Bebida', 'Sobremesa') NOT NULL,
    preco DECIMAL(8,2) NOT NULL
);

SELECT * FROM acompanhamentos;
-- Tabela de Pedidos
CREATE TABLE pedidos(
	id_pedidos INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_clientes INT NOT NULL,
    numero_pedido INT NOT NULL,
    data_pedido DATE NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes)
);


-- Tabela de Itens do pedido
CREATE TABLE itens_pedido(
	id_itens_pedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_acompanhamento INT NOT NULL,
    id_pedido INT NOT NULL,
    id_tamanho_pastel INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT fk_itens_pedido_produtos FOREIGN KEY (id_acompanhamento) REFERENCES acompanhamentos(id_acompanhamento),
    CONSTRAINT fk_itens_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedidos),
    CONSTRAINT fk_itens_pedido_tamanho_pastel FOREIGN KEY (id_tamanho_pastel) REFERENCES tamanho_pasteis(id_tamanho_pasteis)
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
('Calabresa'),
('Presunto'),
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
('Isabela Gomes', NULL, '901.234.567-89', '(75) 95678-9012', '1995-10-10', 'isabela.gomes@gmail.com', 'Conceição', 'Feira de Santana', 'BA'),
('Fábio Souza', NULL, '234.567.890-99', '(75) 98987-6543', '1997-08-12', 'fabio.souza@gmail.com', 'Brasília', 'Feira de Santana', 'BA'),
('Larissa Oliveira', NULL, '345.678.901-88', '(75) 97865-4321', '1980-10-25', 'larissa.oliveira@hotmail.com', 'Centro', 'Feira de Santana', 'BA'),
('Paulo Silva', NULL, '456.789.012-77', '(75) 96789-0123', '1973-03-19', 'paulo.silva@gmail.com', 'Pampalona', 'Feira de Santana', 'BA'),
('Renata Santos', NULL, '567.890.123-66', '(75) 95678-9812', '1998-11-07', 'renata.santos@yahoo.com.br', 'Cidade Nova', 'Feira de Santana', 'BA'),
('Marcelo Lima', NULL, '678.901.234-55', '(75) 94367-8901', '1985-06-30', 'marcelo.lima@gmail.com', 'Tomba', 'Feira de Santana', 'BA'),
('Tatiane Pereira', NULL, '789.012.345-44', '(75) 93486-7890', '1990-12-15', 'tatiane.pereira@hotmail.com', 'Cidade Nova', 'Feira de Santana', 'BA'),
('Roberto Oliveira', NULL, '890.123.456-33', '(75) 92345-6786', '1979-05-28', 'roberto.oliveira@yahoo.com.br', 'Sobradinho', 'Feira de Santana', 'BA'),
('Carla Souza', NULL, '901.234.567-22', '(75) 91234-5673', '1988-09-03', 'carla.souza@gmail.com', 'Cidade Nova', 'Feira de Santana', 'BA'),
('Luciano Santos', NULL, '012.345.678-11', '(75) 90123-4567', '1977-04-14', 'luciano.santos@hotmail.com', 'Cidade Nova', 'Feira de Santana', 'BA'),
('Vanessa Lima', NULL, '123.456.789-00', '(75) 99012-3456', '1995-01-20', 'vanessa.lima@yahoo.com.br', 'Cidade Nova', 'Feira de Santana', 'BA');


INSERT INTO clientes(nome_completo, nome_social, cpf, telefone, data_nascimento, email, bairro, cidade, estado) VALUES
('lucas da Silva Oliveira', 'David', '089.765.324-36', '(75) 99263-3400', '2003-05-04', 'lucasda123@gmail.com', 'Pampalona', 'Feira de Santana', 'BA');



-- Inserindo dados dos produtos(bebidas, sobremesas)
INSERT INTO acompanhamentos(descricao, categoria, preco) VALUES
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
(1, 1),
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

INSERT INTO itens_pedido (id_acompanhamento, id_pedido, id_tamanho_pastel, quantidade) VALUES
(1, 1, 27, 2),
(3, 2, 33, 3),
(2, 3, 22, 1),
(5, 4, 20, 1),
(7, 5, 17, 2),
(4, 6, 3, 4),
(3, 7, 19, 5),
(6, 8, 45, 3),
(8, 9, 43, 8);

INSERT INTO itens_pedido (id_acompanhamento, id_pedido, id_tamanho_pastel, quantidade) VALUES
(8, 11, 45, 2);

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

INSERT INTO pedidos (id_clientes, data_pedido, forma_pagamento) VALUES
(11, '2024-06-06', 'Dinheiro');




SELECT * FROM pedidos;

-- ----------------------------------------SEÇÃO DE VIEWS---------------------------------

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
    
-- 2.Liste os clientes com maior número de pedidos realizados em 1 ano agrupados por mês
CREATE OR REPLACE VIEW view_maior_numero_pedidos_por_cliente AS
SELECT
    ano,
    mes,
    cliente,
    total_pedidos
FROM (
    SELECT
        YEAR(data_pedido) AS ano,
        MONTH(data_pedido) AS mes,
        c.nome_completo AS cliente,
        COUNT(*) AS total_pedidos,
        RANK() OVER (PARTITION BY YEAR(data_pedido), MONTH(data_pedido) ORDER BY COUNT(*) DESC) AS ranking
    FROM
        pedidos p
    JOIN
        clientes c ON p.id_clientes = c.id_clientes
    GROUP BY
        YEAR(data_pedido),
        MONTH(data_pedido),
        c.nome_completo
) AS pedidos_ranking
WHERE
    ranking = 1;
    
SELECT * FROM view_maior_numero_pedidos_por_cliente;

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
    
-- 4 Mostre o valor de venda total de todos os pastéis cadastrados no sistema.
SELECT CONCAT(SUM(preco * tamanho), ' Reais') AS valor_total_venda
FROM tamanho_pasteis;

-- 5 Liste todos os pedidos onde há pelo menos um pastel e uma bebida.
CREATE OR REPLACE VIEW view_pedidos_pastel_bebida AS 
SELECT 
    p.id_pedidos AS pedido_id, 
    p.data_pedido, 
    c.nome_completo AS cliente_nome, 
    MIN(ip.id_itens_pedido) AS item_pedido_id, 
    ac.descricao AS produto_nome, 
    ac.categoria AS categoria_acompanhamento, 
    pst.descricao AS descricao_pastel, -- Substituído pelo nome do pastel 
    tp.tamanho AS tamanho_pastel 
FROM 
    pedidos p 
JOIN 
    clientes c ON p.id_clientes = c.id_clientes 
JOIN 
    itens_pedido ip ON p.id_pedidos = ip.id_pedido 
JOIN 
    acompanhamentos ac ON ip.id_acompanhamento = ac.id_acompanhamento 
LEFT JOIN 
    tamanho_pasteis tp ON ip.id_tamanho_pastel = tp.id_tamanho_pasteis 
LEFT JOIN 
    pasteis pst ON tp.id_pasteis = pst.id_pasteis -- Junção com a tabela de pasteis 
WHERE 
    p.id_pedidos IN (
        SELECT p1.id_pedidos 
        FROM pedidos p1
        JOIN itens_pedido ip1 ON p1.id_pedidos = ip1.id_pedido 
        JOIN acompanhamentos ac1 ON ip1.id_acompanhamento = ac1.id_acompanhamento 
        WHERE ac1.categoria = 'Bebida'
    )
    AND p.id_pedidos IN (
        SELECT p2.id_pedidos 
        FROM pedidos p2
        JOIN itens_pedido ip2 ON p2.id_pedidos = ip2.id_pedido 
        JOIN tamanho_pasteis tp2 ON ip2.id_tamanho_pastel = tp2.id_tamanho_pasteis
    )
GROUP BY 
    p.id_pedidos, p.data_pedido, c.nome_completo, ac.descricao, ac.categoria, pst.descricao, tp.tamanho;

SELECT * FROM view_pedidos_pastel_bebida;


-- 6. Liste quais são os pastéis mais vendidos, incluindo a quantidade de vendas em ordem decrescente.
CREATE OR REPLACE VIEW view_pasteis_mais_vendidos AS
SELECT
    p.id_pasteis AS id_pastel,
    p.descricao AS descricao_pastel,
    COUNT(ip.id_itens_pedido) AS total_vendas,
    RANK() OVER (ORDER BY COUNT(ip.id_itens_pedido) DESC) AS ranking
FROM
    pasteis p
JOIN
    tamanho_pasteis tp ON p.id_pasteis = tp.id_pasteis
JOIN
    itens_pedido ip ON tp.id_tamanho_pasteis = ip.id_tamanho_pastel
GROUP BY
    p.id_pasteis,
    p.descricao;
    
SELECT * FROM view_pasteis_mais_vendidos;

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

CREATE VIEW clientes_bairro AS
SELECT nome_completo, nome_social, cpf, telefone, data_nascimento, email, bairro, cidade, estado
FROM clientes
WHERE  bairro = 'Cidade Nova';

SELECT * FROM clientes_bairro;

-- 10. VIEW 5, lista os pedidos mais recentes nos ultimos 30 dias
CREATE VIEW pedidos_mais_recentes AS
SELECT 
    p.id_pedidos, 
    c.nome_completo, 
    p.data_pedido, 
    p.forma_pagamento
FROM 
    pedidos p
JOIN 
    clientes c ON p.id_clientes = c.id_clientes
WHERE 
    p.data_pedido >= CURDATE() - INTERVAL 30 DAY;

SELECT * FROM pedidos_mais_recentes;

-- 10. VIEW 6, lista os clientes com mais de 2 pedidos.

CREATE VIEW clientes_com_mais_pedidos AS
SELECT 
    c.id_clientes, 
    c.nome_completo, 
    COUNT(p.id_pedidos) AS total_pedidos
FROM 
    clientes c
JOIN 
    pedidos p ON c.id_clientes = p.id_clientes
GROUP BY 
    c.id_clientes
HAVING 
    COUNT(p.id_pedidos) > 2;

SELECT * FROM clientes_com_mais_pedidos;

-- 10. VIEW 7, lista os pasteis mais vendidos no mes.
CREATE VIEW pasteis_mais_vendidos_no_mes AS
SELECT 
    p.descricao AS Pastel, 
    COUNT(ip.id_itens_pedido) AS total_vendas
FROM 
    pasteis p
JOIN 
    tamanho_pasteis tp ON p.id_pasteis = tp.id_pasteis
JOIN 
    itens_pedido ip ON tp.id_tamanho_pasteis = ip.id_tamanho_pastel
JOIN 
    pedidos pe ON ip.id_pedido = pe.id_pedidos
WHERE 
    MONTH(pe.data_pedido) = MONTH(CURDATE())
    AND YEAR(pe.data_pedido) = YEAR(CURDATE())
GROUP BY 
    p.descricao
ORDER BY 
    total_vendas DESC;

SELECT * FROM pasteis_mais_vendidos_no_mes;

-- 10. VIEW 8, lista os bairros que mais compram.

CREATE VIEW bairros_que_mais_compra AS
SELECT 
    c.bairro, 
    c.nome_completo, 
    COUNT(p.id_pedidos) AS total_pedidos
FROM 
    pedidos p
JOIN 
    clientes c ON p.id_clientes = c.id_clientes
GROUP BY 
    c.bairro, 
    c.nome_completo
ORDER BY 
    c.bairro, 
    total_pedidos DESC;

SELECT * FROM bairros_que_mais_compra;

-- 10. VIEW 9, lista o total de vendas mensais agrupadas por categoria de produto.

CREATE VIEW vendas_mensais_por_categoria AS
SELECT 
    MONTH(p.data_pedido) AS mes, 
    YEAR(p.data_pedido) AS ano, 
    ac.categoria AS categoria_produto, 
    SUM(ip.quantidade * tp.preco) AS total_vendas
FROM 
    pedidos p
JOIN 
    itens_pedido ip ON p.id_pedidos = ip.id_pedido
JOIN 
    acompanhamentos ac ON ip.id_acompanhamento = ac.id_acompanhamento
JOIN 
    tamanho_pasteis tp ON ip.id_tamanho_pastel = tp.id_tamanho_pasteis
GROUP BY 
    YEAR(p.data_pedido), 
    MONTH(p.data_pedido), 
    ac.categoria;

SELECT * FROM vendas_mensais_por_categoria;

-- 10. VIEW 10, lista os clientes que fizeram pedidos com valor total superior a 100 reais.
CREATE VIEW clientes_pedidos_valor_superior_30 AS
SELECT 
    c.id_clientes, 
    c.nome_completo, 
    p.id_pedidos, 
    fn_calcula_total_pedido(p.id_pedidos) AS total_pedido
FROM 
    clientes c
JOIN 
    pedidos p ON c.id_clientes = p.id_clientes
HAVING 
    total_pedido > 30;
    
SELECT * FROM clientes_pedidos_valor_superior_30;


-- ----------------------------SEÇÃO DE GATILHOS-----------------------
-- 9, GATILHO 1, gerar numero atribui um numero aleatorio ao pedido
DELIMITER //

CREATE TRIGGER before_insert_pedido
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    SET NEW.numero_pedido = numero_aleatorio();
END;
//

DELIMITER ;

-- 9, GATILHO 2, verificar se o CPF já está cadastrado
DELIMITER //

CREATE TRIGGER verifica_cpf_unico
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM clientes WHERE cpf = NEW.cpf) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CPF já cadastrado';
    END IF;
END;
//

DELIMITER ;

-- 9, GATILHO 3, garante que o pedido não seja feito numa data futura
DELIMITER //

CREATE TRIGGER verifica_data_pedido
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    IF NEW.data_pedido > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data do pedido não pode ser no futuro';
    END IF;
END;
//

DELIMITER ;

INSERT INTO pedidos (id_clientes, data_pedido, forma_pagamento) VALUES
(12, '2024-06-09', 'dinheiro');

-- 9, GATILHO 4, Gatilho para verificar forma de pagamento

DELIMITER //
CREATE TRIGGER validar_forma_pagamento
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    DECLARE forma_valida INT;
    
    SELECT COUNT(*) INTO forma_valida
    FROM (
        SELECT 'Dinheiro' AS forma
        UNION SELECT 'Débito'
        UNION SELECT 'Crédito'
        UNION SELECT 'Pix'
    ) AS formas_aceitas
    WHERE forma = NEW.forma_pagamento;
    
    IF forma_valida = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Forma de pagamento não aceita.';
    END IF;
END;
//

DELIMITER ;

-- 9, GATILHO 5, validar email
DELIMITER //
CREATE TRIGGER verifica_pedidos_cliente
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    DECLARE contador INT;
    SELECT COUNT(*) INTO contador
    FROM pedidos
    WHERE id_clientes = OLD.id_clientes;
    IF contador > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir cliente com pedidos associados';
    END IF;
END;
//

DELIMITER ;

DELETE FROM clientes
WHERE id_clientes = 11;




-- ----------------------------SEÇÃO DE FUNÇÕES------------------------
-- 8. FUNÇÂO 1, calcular idade do cliente.
CREATE FUNCTION fn_idade (data_nascimento DATE)
RETURNS INT 
DETERMINISTIC
RETURN FLOOR(DATEDIFF(NOW(), data_nascimento)/365.25);

SELECT *, fn_idade(data_nascimento) idade
FROM clientes;

-- 8. FUNÇÃO 2, calcula valor total do pedido.
DELIMITER //

CREATE FUNCTION fn_calcula_total_pedido (p_id_pedido INT) 
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT SUM(ip.quantidade * COALESCE(t.preco, a.preco))
    INTO v_total
    FROM itens_pedido ip
    LEFT JOIN tamanho_pasteis t ON ip.id_tamanho_pastel = t.id_tamanho_pasteis
    LEFT JOIN acompanhamentos a ON ip.id_acompanhamento = a.id_acompanhamento
    WHERE ip.id_pedido = p_id_pedido;

    RETURN v_total;
END;

//

DELIMITER ;

SELECT fn_calcula_total_pedido(8) AS total;

-- 8, FUNÇÃO 3, gerar um numero aleatorio, sera usado no gatilho de numero do pedido
DELIMITER //

CREATE FUNCTION numero_aleatorio() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE random_number INT;
    SET random_number = FLOOR(RAND() * 100) + 1; -- Gera um número aleatório entre 1 e 100
    RETURN random_number;
END //

DELIMITER ;

SELECT numero_aleatorio();

-- ---------------------------SEÇÃO DE PROCEDURES----------------------

-- 7, PROCEDURE 1, mudar valor do acompanhamento
DELIMITER //

CREATE PROCEDURE atualizar_preco_acompanhamento(
    IN descricao_acompanhamento VARCHAR(50),
    IN novo_preco DECIMAL(8,2)
)
BEGIN
    UPDATE acompanhamentos
    SET preco = novo_preco
    WHERE descricao = descricao_acompanhamento AND id_acompanhamento > 0;
END //

DELIMITER ;

CALL atualizar_preco_acompanhamento('Suco de Laranja', 7.00);

-- 7,PROCEDURE 2, mudar o nome do clientes
DELIMITER //

CREATE PROCEDURE atualizar_nome_cliente(
    IN id_cliente INT,
    IN novo_nome VARCHAR(45)
)
BEGIN
    UPDATE clientes
    SET nome_completo = novo_nome
    WHERE id_clientes = id_cliente;
END //

DELIMITER ;

CALL atualizar_nome_cliente(1, 'Luis da Silva Carvaho');

DELIMITER //

-- 7,PROCEDURE 3, buscar cliente por bairro
CREATE PROCEDURE listar_clientes_por_bairro(
    IN nome_bairro VARCHAR(50)
)
BEGIN
    SELECT * FROM clientes WHERE bairro = nome_bairro;
END //

DELIMITER ;

CALL listar_clientes_por_bairro('Centro');







