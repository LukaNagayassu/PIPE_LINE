-- Tabela para armazenar as empresas que utilizam o sistema
CREATE TABLE empresas (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone CHAR(11) NOT NULL,
    senha VARCHAR(10) NOT NULL
);

-- Tabela para armazenar os representantes das empresas
CREATE TABLE representantes (
    id_representante INT PRIMARY KEY AUTO_INCREMENT,
    id_empresa INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone CHAR(11) NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) 
);

-- Tabela para armazenar os dutos monitorados
CREATE TABLE dutos (
    id_duto INT PRIMARY KEY AUTO_INCREMENT,
    id_empresa INT NOT NULL,
    localizacao VARCHAR(100) NOT NULL,
    comprimento DECIMAL(10,2) NOT NULL,
    diametro DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) 
);

-- Tabela para armazenar os sensores instalados nos dutos
CREATE TABLE sensores (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    id_duto INT NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    data_instalacao DATE NOT NULL,
    FOREIGN KEY (id_duto) REFERENCES dutos(id_duto) ON DELETE CASCADE
);

-- Tabela para armazenar os dados coletados pelos sensores
CREATE TABLE leituras (
    id_leitura INT PRIMARY KEY AUTO_INCREMENT,
    id_sensor INT NOT NULL,
    data_hora DATETIME,
    distancia DECIMAL(10,2) NOT NULL,
    velocidade DECIMAL(10,2) NOT NULL,
    altura DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_sensor) REFERENCES sensores(id_sensor) ON DELETE CASCADE
);
