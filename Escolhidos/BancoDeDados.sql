-- Criação do banco de dados
CREATE DATABASE ProjetoPi;

-- Seleção do banco de dados
USE ProjetoPi;

-- Criação da tabela cadastro_empresas
CREATE TABLE cadastro_empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- ID único para cada empresa
    nome VARCHAR(255) NOT NULL,         -- Nome da empresa
    cnpj CHAR(18) NOT NULL,         -- CNPJ da empresa
    endereco VARCHAR(255),              -- Endereço da empresa
    cidade VARCHAR(100),               -- Cidade da empresa
    estado VARCHAR(50),                -- Estado da empresa
    telefone VARCHAR(15),              -- Telefone de contato
    email VARCHAR(100),                -- E-mail de contato
    data_cadastro  date               -- Data de cadastro
);

-- Inserção de dados na tabela cadastro_empresas
INSERT INTO cadastro_empresas (nome, cnpj, endereco, cidade, estado, telefone, email, data_cadastro) VALUES
('Petrobras', '33.000.167/0001-01', 'Av. República do Chile, 65', 'Rio de Janeiro', 'RJ', '(21) 3224-4477', 'contato@petrobras.com.br', '2024-03-12'),
('Raízen', '12.345.678/0001-99', 'Av. Brigadeiro Faria Lima, 4100', 'São Paulo', 'SP', '(11) 3095-6555', 'atendimento@raizen.com.br', '2024-03-12'),
('PRIO', '45.987.654/0001-88', 'Rua do Passeio, 38', 'Rio de Janeiro', 'RJ', '(21) 3030-1234', 'sac@prio.com.br', '2024-03-12'),
('Eneva', '98.765.432/0001-22', 'Av. Rio Branco, 110', 'Rio de Janeiro', 'RJ', '(21) 2500-6789', 'contato@eneva.com.br', '2024-03-12'),
('Petronas Brasil', '87.654.321/0001-11', 'Rua Verbo Divino, 1400', 'São Paulo', 'SP', '(11) 5555-7777', 'info@petronas.com.br', '2024-03-12'),
('BP Energy', '77.888.999/0001-55', 'Alameda Santos, 200', 'São Paulo', 'SP', '(11) 4004-7070', 'clientes@bpenergy.com.br', '2024-03-12'),
('Shell Brasil', '11.222.333/0001-44', 'Praia do Flamengo, 200', 'Rio de Janeiro', 'RJ', '(21) 3804-9000', 'suporte@shell.com.br', '2024-03-12');

drop database ProjetoPi;
-- Criação da tabela Representantes
create table Representante(
id  		int auto_increment primary key,
nome 		VARCHAR(255) NOT NULL,
cpf 		char(14) Not null,
telefone 	VARCHAR(15)
);
-- inserir dados na table Representantes
INSERT INTO Representante (nome, cpf, telefone) VALUES
('João Silva', '123.456.789-00', '(11) 99999-8888'),
('Maria Oliveira', '987.654.321-00', '(21) 98888-7777'),
('Carlos Santos', '456.789.123-00', '(11) 95555-6666'),
('Ana Souza', '321.654.987-00', '(21) 94444-5555'),
('Pedro Lima', '654.987.321-00', '(11) 93333-4444');

-- Criação da tabela sensores
CREATE TABLE sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numeracao_arduino    int,
    localizacao_inicio INT,
    localizacao_fim INT);

INSERT INTO sensores (numeracao_arduino, localizacao_inicio, localizacao_fim) VALUES
(1001, 1, 2),
(1002, 2, 3),
(1003, 3, 4),
(1004, 4, 5),
(1005, 1, 5);

-- Criação da tabela dutos
CREATE TABLE dutos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,        -- Nome do duto
    comprimento DECIMAL(10, 2),        -- Comprimento do duto em quilômetros
    diametro DECIMAL(5, 2),            -- Diâmetro do duto
    material VARCHAR(100),             -- Material do duto
    data_instalacao DATE,              -- Data de instalação do duto
    Localizacao_inicio INT,
    Localizacao_fim INT
);


-- Inserção de dados na tabela dutos
INSERT INTO dutos (nome, comprimento, diametro, material, data_instalacao, Localizacao_inicio, Localizacao_fim) VALUES
('Duto Petrobras SP-RJ', 300.50, 1.80, 'Aço carbono', '2020-06-01', 1, 2),
('Duto Raízen SP-MG', 150.75, 1.60, 'Aço inoxidável', '2021-07-15', 2, 3),
('Duto PRIO RJ-ES', 200.00, 1.90, 'Aço carbono', '2022-03-22', 3, 4),
('Duto Shell BR Norte', 400.25, 2.10, 'Aço carbono', '2023-01-10', 4, 5);

 
