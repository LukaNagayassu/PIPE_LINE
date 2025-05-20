-- Apagando banco de dados Pipeline, caso o mesmo exista
DROP DATABASE IF EXISTS Pipeline;

-- Criação do banco de dados
CREATE DATABASE Pipeline;

-- Seleção do banco de dados
USE Pipeline;

-- Criação da tabela Endereco
CREATE TABLE Endereco (
    idEnd INT PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(9),
    numero INT,
    complemento VARCHAR(30)
);

-- Criação da tabela Empresa
CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50),
    cnpj CHAR(14),
    nomeFantasia VARCHAR(50),
    razaoSocial VARCHAR(50),
    telefone VARCHAR(20),
    fkEndereco INT,
    FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEnd)
);

-- Criação da tabela Funcionario
CREATE TABLE Funcionario (
    idFunc INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    telefone VARCHAR(20),
    email VARCHAR(40),
    senha VARCHAR(30),
    cargo VARCHAR(20),
    fkEmpresa INT,
    CONSTRAINT chk_cargo CHECK (cargo IN ('Suporte', 'Analista', 'Gestor')),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

-- Criação da tabela Estacao
CREATE TABLE Estacao (
    idEstacao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    tipoEstacao VARCHAR(14),
    statusEstacao VARCHAR(10) DEFAULT 'Ativa',
    fkEndereco INT,
    fkEmpresa INT,
    CONSTRAINT chk_tipo CHECK (tipoEstacao IN ('Bombeamento', 'Monitoramento', 'Transferencia')),
    CONSTRAINT chk_status CHECK (statusEstacao IN ('Ativa', 'Inativa', 'Manutenção')),
    FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEnd),
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

-- Criação da tabela Duto
CREATE TABLE Duto (
    idDuto INT PRIMARY KEY AUTO_INCREMENT,
    comprimento DECIMAL(10, 2),            
    diametro DECIMAL(5, 2),            
    material VARCHAR(50),       
    fkEstacao INT,
    FOREIGN KEY (fkEstacao) REFERENCES Estacao(idEstacao)
);

-- Criação da tabela Sensor
CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(20) DEFAULT 'Ultrassônico',
    modelo VARCHAR(20) DEFAULT 'HC-SR04',
    inicioDuto TINYINT,
    fkDuto INT,
    FOREIGN KEY (fkDuto) REFERENCES Duto(idDuto)
);

-- Criação da tabela DadosSensor
CREATE TABLE DadosSensor (
    idDado INT PRIMARY KEY AUTO_INCREMENT,
    dtRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    distancia FLOAT,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);

-- Criação da tabela Alerta
CREATE TABLE Alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    tipoAlerta VARCHAR(30),
    statusAlerta VARCHAR(20) DEFAULT 'Não resolvido',
    dtHoraAlerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor),
    CONSTRAINT chk_tipoAlerta CHECK (tipoAlerta IN ('Baixo nível de petróleo', 'Alto nível de petróleo')),
    CONSTRAINT chk_statusAlerta CHECK (statusAlerta IN ('Resolvido', 'Não resolvido'))
);

-- Inserção de registros na tabela Endereco
INSERT INTO Endereco (cep, numero, complemento) VALUES 
('12345-678', 100, 'Próximo ao porto'),
('87654-321', 200, 'Ao lado da refinaria');

-- Inserção de registros na tabela Empresa
INSERT INTO Empresa (email, cnpj, nomeFantasia, razaoSocial, telefone, fkEndereco) VALUES 
('contato@petrobras.com', '12345678000195', 'Petrobras', 'Petrobras S.A.', '11999990000', 1),
('contato@exxon.com', '98765432000150', 'ExxonMobil', 'ExxonMobil Corporation', '21988887777', 2);

-- Inserção de registros na tabela Funcionario
INSERT INTO Funcionario (nome, telefone, email, senha, cargo, fkEmpresa) VALUES 
('Carlos Silva', '11987654321', 'carlos@petrobras.com', 'senha123', 'Engenheiro', 1),
('Mariana Souza', '21987651234', 'mariana@exxon.com', 'senha456', 'Técnico', 2);

-- Inserção de registros na tabela Estacao
INSERT INTO Estacao (nome, tipoEstacao, statusEstacao, fkEndereco, fkEmpresa) VALUES 
('Estação Norte', 'Bombeamento', 'Ativa', 1, 1),
('Estação Sul', 'Monitoramento', 'Ativa', 2, 2);

-- Inserção de registros na tabela Duto
INSERT INTO Duto (comprimento, diametro, material, fkEstacao) VALUES 
(500.50, 1.20, 'Aço Inoxidável', 1),
(300.75, 0.80, 'PVC Reforçado', 2);

-- Inserção de registros na tabela Sensor
INSERT INTO Sensor (tipo, modelo, inicioDuto, fkDuto) VALUES 
('Ultrassônico', 'HC-SR04', 1, 1),
('Ultrassônico', 'HC-SR04', 0, 2); 

-- Inserção de registros na tabela DadosSensor
INSERT INTO DadosSensor (distancia, fkSensor) VALUES 
(120.5, 1),
(80.3, 2);

-- Inserção de registros na tabela Alerta
INSERT INTO Alerta (tipoAlerta, statusAlerta, fkSensor) VALUES 
('Baixo nível de petróleo', 'Não resolvido', 1),
('Alto nível de petróleo', 'Resolvido', 2);

