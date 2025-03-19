-- Criação do banco de dados
CREATE DATABASE Pipeline ;
-- Seleção do banco de dados
USE Pipeline;

-- Criação da tabela cadastro_empresas
CREATE TABLE cadastro_empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome 	VARCHAR(255) NOT NULL,
    cnpj 	CHAR(18) NOT NULL,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro DATE
);

INSERT INTO cadastro_empresas (nome, cnpj, endereco, cidade, estado, telefone, email, data_cadastro) VALUES
('Petrobras', '33.000.167/0001-01', 'Av. República do Chile, 65', 'Rio de Janeiro', 'RJ', '(21) 3224-4477', 'contato@petrobras.com.br', '2024-03-12'),
('Raízen', '12.345.678/0001-99', 'Av. Brigadeiro Faria Lima, 4100', 'São Paulo', 'SP', '(11) 3095-6555', 'atendimento@raizen.com.br', '2024-03-12'),
('PRIO', '45.987.654/0001-88', 'Rua do Passeio, 38', 'Rio de Janeiro', 'RJ', '(21) 3030-1234', 'sac@prio.com.br', '2024-03-12'),
('Eneva', '98.765.432/0001-22', 'Av. Rio Branco, 110', 'Rio de Janeiro', 'RJ', '(21) 2500-6789', 'contato@eneva.com.br', '2024-03-12'),
('Petronas Brasil', '87.654.321/0001-11', 'Rua Verbo Divino, 1400', 'São Paulo', 'SP', '(11) 5555-7777', 'info@petronas.com.br', '2024-03-12'),
('BP Energy', '77.888.999/0001-55', 'Alameda Santos, 200', 'São Paulo', 'SP', '(11) 4004-7070', 'clientes@bpenergy.com.br', '2024-03-12'),
('Shell Brasil', '11.222.333/0001-44', 'Praia do Flamengo, 200', 'Rio de Janeiro', 'RJ', '(21) 3804-9000', 'suporte@shell.com.br', '2024-03-12');

-- select * from cadastro_empresas where estado like '%SP%';


CREATE TABLE Representante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf CHAR(14) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    empresa VARCHAR(255)
);

INSERT INTO Representante (nome, cpf, telefone, email, empresa) VALUES 
('João Silva', '123.456.789-00', '(21) 99999-8888', 'joao@email.com', 'Petrobras'),
('Maria Oliveira', '987.654.321-00', '(11) 98888-7777', 'maria@email.com', 'Raízen'),
('Carlos Santos', '456.789.123-00', '(21) 95555-6666', 'carlos@email.com', 'PRIO'),
('Ana Souza', '321.654.987-00', '(21) 94444-5555', 'ana@email.com', 'Eneva'),
('Pedro Lima', '654.987.321-00', '(11) 93333-4444', 'pedro@email.com', 'Petronas Brasil'),
('Lucas Mendes', '852.741.963-00', '(11) 92222-3333', 'lucas@email.com', 'BP Energy'),
('Fernanda Rocha', '369.258.147-00', '(21) 91111-2222', 'fernanda@email.com', 'Shell Brasil');

-- select * from representante where empresa = 'Petrobras';

-- Criacao da tabela dutos
CREATE TABLE dutos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    comprimento DECIMAL(10, 2),
    diametro DECIMAL(5, 2),
    material VARCHAR(100),
    data_instalacao DATE,
    localizacao_inicio INT,
    localizacao_fim INT,
    sensores INT
);

INSERT INTO dutos (nome, comprimento, diametro, material, data_instalacao, localizacao_inicio, localizacao_fim, sensores) VALUES
    ('Duto Petrobras SP-RJ', 300.50, 1.80, 'Aço carbono', '2020-06-01', 1, 2, 10),
    ('Duto Raízen SP-MG', 150.75, 1.60, 'Aço inoxidável', '2021-07-15', 2, 3, 8),
    ('Duto PRIO RJ-ES', 200.00, 1.90, 'Aço carbono', '2022-03-22', 3, 4, 12),
    ('Duto Shell BR Norte', 400.25, 2.10, 'Aço carbono', '2023-01-10', 4, 5, 15);

-- select nome, comprimento, material from dutos where material = 'Aço carbono';

-- select * from dutos where data_instalacao > '2021-01-01'; 

-- update dutos
-- set Localizacao_inicio = 5
-- where id = 2;

-- select * from dutos;

-- insert into cadastro_empresas(nome, cnpj, endereco, cidade, estado, telefone, email, data_cadastro)Values
-- ('Sptech', 123456789123456789, 'Rua Haddock Lob', 'São Paulo', 'SP', 1198762345, 'sptech@gmail.com', '2025-01-01');

