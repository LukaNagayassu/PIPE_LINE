-- Criação do banco de dados
CREATE DATABASE ProjetoPi;

-- Seleção do banco de dados
USE ProjetoPi;

-- Criação da tabela cadastro_empresas
CREATE TABLE cadastro_empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- ID único para cada empresa
    nome VARCHAR(255) NOT NULL,         -- Nome da empresa
    cnpj VARCHAR(18) NOT NULL,         -- CNPJ da empresa
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

-- Criação da tabela funcionarios
CREATE TABLE funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,    -- ID único para cada funcionário
    nome VARCHAR(255) NOT NULL,            -- Nome do funcionário
    cargo VARCHAR(100),                    -- Cargo do funcionário
    data_nascimento DATE,                  -- Data de nascimento do funcionário
    cpf VARCHAR(14) NOT NULL,              -- CPF do funcionário
    email VARCHAR(100),                    -- E-mail de contato
    telefone VARCHAR(15),                  -- Telefone de contato
    empresa_id INT,                        -- Relacionamento com a empresa
    representante_id INT,                  -- Representante associado ao funcionário (ou seja, o superior)
    data_admissao DATE,                    -- Data de admissão
    FOREIGN KEY (empresa_id) REFERENCES cadastro_empresas(id),   -- Chave estrangeira para a empresa
    FOREIGN KEY (representante_id) REFERENCES funcionarios(id)    -- Chave estrangeira para o representante
);

INSERT INTO funcionarios (nome, cargo, data_nascimento, cpf, email, telefone, empresa_id, representante_id, data_admissao) VALUES
('João Silva', 'Engenheiro de Dutos', '1985-07-15', '123.456.789-00', 'joao.silva@empresa.com', '(11) 98765-4321', 1, NULL, '2024-01-10'),
('Maria Oliveira', 'Técnica de Monitoramento', '1990-09-30', '234.567.890-11', 'maria.oliveira@empresa.com', '(21) 91234-5678', 2, 1, '2024-02-01'),
('Carlos Souza', 'Supervisor de Equipe', '1980-03-20', '345.678.901-22', 'carlos.souza@empresa.com', '(11) 92345-6789', 3, 2, '2024-02-20'),
('Ana Costa', 'Analista de Sistema', '1995-12-10', '456.789.012-33', 'ana.costa@empresa.com', '(21) 93456-7890', 4, 3, '2024-03-05'),
('Pedro Almeida', 'Técnico de Manutenção', '1987-06-25', '567.890.123-44', 'pedro.almeida@empresa.com', '(11) 94567-8901', 5, 4, '2024-03-15');


CREATE TABLE dutos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,        -- Nome do duto
    comprimento DECIMAL(10, 2),        -- Comprimento do duto em quilômetros
    diamentro DECIMAL(5, 2),           -- Diâmetro do duto
    material VARCHAR(100),             -- Material do duto (ex: aço, PVC, etc.)
    localizacao_inicio VARCHAR(255),   -- Local de início do duto
    localizacao_fim VARCHAR(255),      -- Local de término do duto
    data_instalacao DATE               -- Data de instalação do duto
);

INSERT INTO dutos (nome, comprimento, diamentro, material, localizacao_inicio, localizacao_fim, data_instalacao) VALUES
('Duto Petrobras SP-RJ', 300.50, 1.80, 'Aço carbono', 'São Paulo', 'Rio de Janeiro', '2020-06-01'),
('Duto Raízen SP-MG', 150.75, 1.60, 'Aço inoxidável', 'São Paulo', 'Minas Gerais', '2021-07-15'),
('Duto PRIO RJ-ES', 200.00, 1.90, 'Aço carbono', 'Rio de Janeiro', 'Espírito Santo', '2022-03-22'),
('Duto Shell BR Norte', 400.25, 2.10, 'Aço carbono', 'Amazonas', 'Pará', '2023-01-10'),
('Duto Eneva SP-BA', 500.00, 2.30, 'PVC', 'São Paulo', 'Bahia', '2022-12-05');


