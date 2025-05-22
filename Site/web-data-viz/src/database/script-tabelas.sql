-- Criação do banco de dados
CREATE DATABASE henriquepotter;
USE henriquepotter;

-- Tabela de varinhas
CREATE TABLE varinhas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    material VARCHAR(100),
    nome VARCHAR(100),
    poder_especial TEXT,
    nivel_corrupcao INT
);

-- Tabela de personagens
CREATE TABLE personagens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    tipo VARCHAR(50),
    montaria VARCHAR(100),
    fkVarinha INT,
    FOREIGN KEY (fkVarinha) REFERENCES varinhas(id)
);

-- Tabela de feitiços
CREATE TABLE feiticos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT,
    pontuacao_poder INT
);

-- Tabela de relação entre personagens e feitiços
CREATE TABLE personagem_feitico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fkPersonagem INT,
    fkFeitico INT,
    proficiencia VARCHAR(50),
    FOREIGN KEY (fkPersonagem) REFERENCES personagens(id),
    FOREIGN KEY (fkFeitico) REFERENCES feiticos(id)
);

-- Tabela de locais mágicos
CREATE TABLE locais_magicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    tipo VARCHAR(50),
    descricao TEXT
);

-- Tabela de eventos mágicos
CREATE TABLE eventos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    fkLocal INT,
    descricao TEXT,
    data_ocorrencia DATE,
    FOREIGN KEY (fkLocal) REFERENCES locais_magicos(id)
);

-- Tabela de artefatos mágicos
CREATE TABLE artefatos_magicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    efeito TEXT,
    perigoso BOOLEAN,
    em_posse_de INT,
    FOREIGN KEY (em_posse_de) REFERENCES personagens(id)
);

-- Tabela de inimigos políticos
CREATE TABLE inimigos_politicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    lider VARCHAR(100),
    objetivo TEXT,
    fkArtefato INT,
    FOREIGN KEY (fkArtefato) REFERENCES artefatos_magicos(id)
);

-- Tabela de batalhas mágicas
CREATE TABLE batalhas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fkEvento INT,
    fkPersonagem INT,
    fkInimigo INT,
    FOREIGN KEY (fkEvento) REFERENCES eventos(id),
    FOREIGN KEY (fkPersonagem) REFERENCES personagens(id),
    FOREIGN KEY (fkInimigo) REFERENCES inimigos_politicos(id)
);

-- Tabela de bibliotecas mágicas
CREATE TABLE bibliotecas_magicas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    fundado_por INT,
    quantidade_livros INT,
    tipo_magia VARCHAR(50),
    FOREIGN KEY (fundado_por) REFERENCES personagens(id)
);

-- Tabela de monstros burocráticos
CREATE TABLE monstros_burocraticos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    fraqueza VARCHAR(100),
    fkLocal INT,
    FOREIGN KEY (fkLocal) REFERENCES locais_magicos(id)
);

-- Tabela de contratos malditos
CREATE TABLE contratos_malditos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT,
    criado_por INT,
    nivel_amaldicoado INT,
    FOREIGN KEY (criado_por) REFERENCES inimigos_politicos(id)
);



