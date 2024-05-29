CREATE DATABASE pastelaria;

USE pastelaria;

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

CREATE TABLE pasteis(
	id_pasteis INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE recheios(
	id_recheios INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE tamanho_pasteis(
	id_tamanho_pasteis INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tamanho CHAR(5) NOT NULL UNIQUE,
    preco DECIMAL(8,2) NOT NULL,
    id_pasteis INT NOT NULL,
    CONSTRAINT fk_tamanho_pasteis_pasteis FOREIGN KEY (id_pasteis) REFERENCES pasteis(id_pasteis)
);

CREATE TABLE pastel_recheios(
	id_recheios INT NOT NULL,
    id_pasteis INT NOT NULL,
    CONSTRAINT fk_pastel_recheios_recheios FOREIGN KEY (id_recheios) REFERENCES recheios(id_recheios),
    CONSTRAINT fk_pastel_recheios_pasteis FOREIGN KEY (id_pasteis) REFERENCES pasteis(id_pasteis)
);

CREATE TABLE tipo_bebidas(
	id_tipo_bebidas INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE bebidas(
	id_bebidas INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    id_tipo_bebidas INT NOT NULL,
    preco DECIMAL(8,2) NOT NULL,
    CONSTRAINT fk_bebidas_tipos_bebidas FOREIGN KEY (id_tipo_bebidas) REFERENCES tipo_bebidas(id_tipo_bebidas)
);

CREATE TABLE sobremesas(
	id_sobremesa INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    preco DECIMAL (8,2) NOT NULL
);

CREATE TABLE forma_pagamento(
	id_forma_pagamento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE pedidos(
	id_pedidos INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    id_sobremesa INT NOT NULL,
    id_bebida INT NOT NULL,
    id_pastel INT NOT NULL,
    data_pedido DATE NOT NULL,
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id_clientes),
    CONSTRAINT fk_pedidos_forma_pagamento FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id_forma_pagamento),
    CONSTRAINT fk_pedidos_sobremesas FOREIGN KEY (id_sobremesa) REFERENCES sobremesas(id_sobremesa),
    CONSTRAINT fk_pedidos_bebidas FOREIGN KEY (id_bebida) REFERENCES bebidas(id_bebidas),
    CONSTRAINT fk_pedidos_pasteis FOREIGN KEY (id_pastel) REFERENCES pasteis(id_pasteis)
);




	


