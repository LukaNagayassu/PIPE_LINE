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
    distanciaMax INT,
    distanciaMin INT,                  
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
    CONSTRAINT chk_tipoAlerta CHECK (tipoAlerta IN ('Entupimento', 'Vazamento')),
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
('Mariana Souza', '21987651234', 'mariana@exxon.com', 'senha456', 'Gestor', 2),
('Gustavo Gomes', '21987651236', 'gustavo@suporte.com', 'senha123', 'Suporte', null);

-- Inserção de registros na tabela Estacao
INSERT INTO Estacao (nome, tipoEstacao, statusEstacao, fkEndereco, fkEmpresa) VALUES 
('Estação Norte', 'Bombeamento', 'Ativa', 1, 1),
('Estação Sul', 'Monitoramento', 'Ativa', 2, 2);

INSERT INTO Duto (diametro, distanciaMax, distanciaMin, fkEstacao) VALUES 
(120, 110, 21, 1),
(80, 73, 14, 2),
(100, 92, 18, 1),
(90, 82, 16, 2),
(140, 128, 25, 1),
(150, 138, 27, 1),
(85, 78, 15, 2),
(105, 96, 18, 1),
(95, 87, 17, 2),
(135, 124, 24, 1);


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
(0, 5),
(1, 6),
(0, 6),
(1, 7),
(0, 7),
(1, 8),
(0, 8),
(1, 9),
(0, 9),
(1, 10),
(0, 10);

DELIMITER $$

CREATE PROCEDURE InserirDadosSimulados()
BEGIN
    -- Variáveis de controle
    DECLARE done INT DEFAULT FALSE;
    DECLARE sensorId INT;
    DECLARE dutoId INT;
    DECLARE diametro INT;
    DECLARE horaAtual INT;
    DECLARE diaAtual INT;
    DECLARE distanciaGerada FLOAT;
    DECLARE dadoId INT;

    -- Pega o dia e hora atuais
    DECLARE diaHoje INT DEFAULT DAY(CURDATE());
    DECLARE horaAgora INT DEFAULT HOUR(NOW());

    -- Cursor que seleciona todos os sensores com seus dutos e diâmetros
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

        SET diaAtual = 1;
        WHILE diaAtual <= diaHoje DO
            SET horaAtual = 0;
            WHILE horaAtual < IF(diaAtual = diaHoje, horaAgora + 1, 24) DO

                -- Gera distância entre 10% e 90% do diâmetro
                SET distanciaGerada = ROUND(RAND() * ((0.90 - 0.1) * diametro) + (0.1 * diametro), 2);

                INSERT INTO DadosSensor (dtRegistro, distancia, fkSensor)
                VALUES (
                    TIMESTAMP(CONCAT(YEAR(CURDATE()), '-', MONTH(CURDATE()), '-', LPAD(diaAtual, 2, '0'), ' ', LPAD(horaAtual, 2, '0'), ':00:00')),
                    distanciaGerada,
                    sensorId
                );

                SET dadoId = LAST_INSERT_ID();

                -- Geração de alertas com novos limites
                IF distanciaGerada < (0.10 * diametro) THEN
                    INSERT INTO Alerta (tipoAlerta, fkDadoSensor)
                    VALUES ('Entupimento', dadoId);
                ELSEIF distanciaGerada > (0.90 * diametro) THEN
                    INSERT INTO Alerta (tipoAlerta, fkDadoSensor)
                    VALUES ('Vazamento', dadoId);
                END IF;

                SET horaAtual = horaAtual + 1;
            END WHILE;
            SET diaAtual = diaAtual + 1;
        END WHILE;
    END LOOP;

    CLOSE sensor_cursor;
END $$

DELIMITER ;

CALL InserirDadosSimulados();

DELIMITER $$

CREATE TRIGGER tr_gerar_alerta
AFTER INSERT ON DadosSensor
FOR EACH ROW
BEGIN
    DECLARE diametroDuto INT;

    -- Recupera o diâmetro do duto associado ao sensor
    SELECT d.diametro INTO diametroDuto
    FROM Sensor s
    JOIN Duto d ON s.fkDuto = d.idDuto
    WHERE s.idSensor = NEW.fkSensor;

    -- Verifica se a distância é menor que 10% do diâmetro (entupimento)
    IF NEW.distancia < (0.10 * diametroDuto) THEN
        INSERT INTO Alerta (tipoAlerta, fkDadoSensor)
        VALUES ('Entupimento', NEW.idDado);

    -- Verifica se a distância é maior que 90% do diâmetro (vazamento)
    ELSEIF NEW.distancia > (0.90 * diametroDuto) THEN
        INSERT INTO Alerta (tipoAlerta, fkDadoSensor)
        VALUES ('Vazamento', NEW.idDado);
    END IF;
END$$

DELIMITER ;

