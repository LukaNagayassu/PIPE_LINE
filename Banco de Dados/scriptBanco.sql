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
    codigo_ativacao varchar(50),
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
    diametro INT,                  
    fkEstacao INT,
    FOREIGN KEY (fkEstacao) REFERENCES Estacao(idEstacao)
);

-- Criação da tabela Sensor
CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
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
    fkDadoSensor INT,
    FOREIGN KEY (fkDadoSensor) REFERENCES DadosSensor(idDado),
    CONSTRAINT chk_tipoAlerta CHECK (tipoAlerta IN ('Baixo nível de petróleo', 'Alto nível de petróleo')),
    CONSTRAINT chk_statusAlerta CHECK (statusAlerta IN ('Resolvido', 'Não resolvido'))
);

-- Inserção de registros na tabela Endereco
INSERT INTO Endereco (cep, numero, complemento) VALUES 
('12345-678', 100, 'Próximo ao porto'),
('87654-321', 200, 'Ao lado da refinaria');

-- Inserção de registros na tabela Empresa
INSERT INTO Empresa (email, cnpj, nomeFantasia, razaoSocial, telefone, codigo_ativacao, fkEndereco) VALUES 
('contato@petrobras.com', '12345678000195', 'Petrobras', 'Petrobras S.A.', '11999990000', 'A1B2C3', 1),
('contato@exxon.com', '98765432000150', 'ExxonMobil', 'ExxonMobil Corporation', '21988887777', '1A2B3C', 2);

-- Inserção de registros na tabela Funcionario
INSERT INTO Funcionario (nome, telefone, email, senha, cargo, fkEmpresa) VALUES 
('Carlos Silva', '11987654321', 'carlos@petrobras.com', 'senha123', 'Analista', 1),
('Mariana Souza', '21987651234', 'mariana@exxon.com', 'senha456', 'Gestor', 2);

-- Inserção de registros na tabela Estacao
INSERT INTO Estacao (nome, tipoEstacao, statusEstacao, fkEndereco, fkEmpresa) VALUES 
('Estação Norte', 'Bombeamento', 'Ativa', 1, 1),
('Estação Sul', 'Monitoramento', 'Ativa', 2, 2);

-- Inserção de registros na tabela Duto
INSERT INTO Duto (diametro, fkEstacao) VALUES 
(120, 1),
(80, 2),
(100, 1),
(90, 2),
(140, 1);

-- Inserção de registros na tabela Sensor
INSERT INTO Sensor (inicioDuto, fkDuto) VALUES 
(1, 1),
(0, 1),
(1, 2),
(0, 2),
(1, 3),
(0, 3),
(1, 4),
(0, 4),
(1, 5),
(0, 5);

DELIMITER $$

CREATE PROCEDURE InserirDadosSimulados()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE sensorId INT;
    DECLARE dutoId INT;
    DECLARE diametro INT;
    DECLARE horaAtual INT;
    DECLARE distanciaGerada FLOAT;
    DECLARE dadoId INT;

    -- Cursor para percorrer os sensores com seus respectivos dutos
    DECLARE sensor_cursor CURSOR FOR
        SELECT s.idSensor, d.idDuto, d.diametro
        FROM Sensor s
        JOIN Duto d ON s.fkDuto = d.idDuto;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN sensor_cursor;

    read_loop: LOOP
        FETCH sensor_cursor INTO sensorId, dutoId, diametro;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET horaAtual = 0;
        WHILE horaAtual < 24 DO
            -- Gerar distância entre 15% e 95% da altura
            SET distanciaGerada = ROUND(RAND() * ((0.95 - 0.15) * diametro) + (0.15 * diametro), 2);

            -- Inserir dado na tabela DadosSensor
            INSERT INTO DadosSensor (dtRegistro, distancia, fkSensor)
            VALUES (CONCAT(CURDATE(), ' ', LPAD(horaAtual, 2, '0'), ':00:00'), distanciaGerada, sensorId);

            SET dadoId = LAST_INSERT_ID();

            -- Verificar e inserir alerta se necessário
            IF distanciaGerada < (0.20 * diametro) THEN
                INSERT INTO Alerta (tipoAlerta, fkDadoSensor)
                VALUES ('Baixo nível de petróleo', dadoId);
            ELSEIF distanciaGerada > (0.90 * diametro) THEN
                INSERT INTO Alerta (tipoAlerta, fkDadoSensor)
                VALUES ('Alto nível de petróleo', dadoId);
            END IF;

            SET horaAtual = horaAtual + 1;
        END WHILE;
    END LOOP;

    CLOSE sensor_cursor;
END $$

DELIMITER ;

CALL InserirDadosSimulados();

select * from Sensor;

select * from DadosSensor;

select * from Alerta;

SELECT 
    a.idAlerta,
    a.tipoAlerta,
    a.statusAlerta,
    d.idDado,
    d.dtRegistro,
    d.distancia,
    d.fkSensor,
    s.fkDuto,
    duto.diametro
FROM Alerta a
JOIN DadosSensor d ON a.fkDadoSensor = d.idDado
JOIN Sensor s ON d.fkSensor = s.idSensor
JOIN Duto duto ON s.fkDuto = duto.idDuto;




