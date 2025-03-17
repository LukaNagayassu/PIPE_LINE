CREATE DATABASE Site;

USE Site;

CREATE TABLE login_empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,  
    nome VARCHAR(150) NOT NULL,         
    cnpj CHAR(18) NOT NULL,
    cep char(8),
    endereco VARCHAR(150),
    cidade VARCHAR(100),      
    estado VARCHAR(50),               
    telefone CHAR(14),              
    email VARCHAR(100),               
    data_cadastro  date            
);

INSERT INTO login_empresas (nome, cnpj, cep, endereco, cidade, estado, telefone, email, data_cadastro) VALUES
('PetroTech LTDA', '12.345.678/0001-90', '01001000', 'Av. Paulista, 1000', 'São Paulo', 'SP', '(11) 91234-5678', 'contato@petrotech.com', '2024-03-01'),
('EcoDutos SA', '98.765.432/0001-21', '20040030', 'Rua das Indústrias, 500', 'Rio de Janeiro', 'RJ', '(21) 92345-6789', 'suporte@ecodutos.com', '2023-11-15'),
('OilSecure Ltda', '56.789.012/0001-34', '30120040', 'Av. Petróleo, 200', 'Belo Horizonte', 'MG', '(31) 93456-7890', 'contato@oilsecure.com', '2025-01-10');


CREATE TABLE dutos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo VARCHAR(150) NOT NULL,        -- Tipo do duto
    comprimento DECIMAL(10, 2),        -- Comprimento do duto em quilômetros
    diamentro DECIMAL(10, 2),           -- Diâmetro do duto
    data_instalacao   DATE               -- Data de instalação do duto
);

INSERT INTO dutos (nome_tipo, comprimento, diamentro, data_instalacao) VALUES
('Duto de Petróleo', 120.50, 0.80, '2019-06-15'),
('Duto de Gás Natural', 250.75, 1.20, '2021-09-10'),
('Duto de Transporte Químico', 95.30, 0.60, '2020-12-05');


CREATE TABLE sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numeracao_arduino    int,
    localizacao_inicio INT,
    localizacao_fim INT
);

INSERT INTO sensores (numeracao_arduino, localizacao_inicio, localizacao_fim) VALUES
(101, 0, 50),
(102, 51, 100),
(103, 101, 150);