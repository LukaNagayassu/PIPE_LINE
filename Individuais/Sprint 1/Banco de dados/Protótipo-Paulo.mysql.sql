-- Criar Database
create database Sprint_1;

-- Usar o banco de dados
use Sprint_1;

-- Criar tabela
create table Clientes (
    ID INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único para cada registro.
    Empresa VARCHAR(255) NOT NULL, -- Nome da empresa responsável pelo projeto.
    Projeto VARCHAR(255), -- Nome do projeto "Monitoramento de Dutos de Petróleo com Sensores Ultrassônicos".
    Objetivo TEXT, -- Descrição geral do objetivo empresarial do monitoramento.
    RiscosPotenciais TEXT, -- Principais riscos que o sistema pretende mitigar.
    ImpactoFinanceiro DECIMAL(15, 2), -- Estimativa de perdas financeiras que o monitoramento ajudará a evitar.
    ImpactoAmbiental TEXT, -- Descrição qualitativa ou quantitativa dos danos ambientais evitados.
    CustoMonitoramento DECIMAL(15, 2), -- Custo total estimado do projeto de monitoramento.
    MultaPotencial DECIMAL(15, 2), -- Valor estimado de multas que podem ser evitadas com o monitoramento.
    DataInicio DATE, -- Data de início do projeto.
    DataConclusao DATE, -- Data planejada para a conclusão do projeto.
    Status VARCHAR(50) -- Situação atual do projeto (ex.: "Em andamento", "Concluído").
);

-- Registros da tabela
INSERT INTO Clientes (
    Empresa, Projeto, Objetivo, RiscosPotenciais, ImpactoFinanceiro, 
    ImpactoAmbiental, CustoMonitoramento, MultaPotencial, DataInicio, 
    DataConclusao, Status
) 
VALUES
-- Dado 1
('PetroTransp Ltda.', 'Monitoramento de Vazamentos Onshore', 
 'Minimizar vazamentos em dutos terrestres e reduzir multas ambientais.', 
 'Vazamentos de óleo devido a falhas estruturais em dutos antigos.', 
 5000000.00, 'Contaminação de lençóis freáticos em áreas rurais.', 
 120000.00, 1500000.00, '2025-01-01', '2025-12-31', 'Em andamento'),

-- Dado 2
('EcoPipeline SA', 'Sistema Ultrassônico Offshore', 
 'Monitorar o transporte de petróleo em alto-mar e evitar acidentes ecológicos.', 
 'Derramamento de óleo em regiões de pesca.', 
 8000000.00, 'Dano irreparável à biodiversidade marinha.', 
 300000.00, 5000000.00, '2024-09-01', '2025-08-31', 'Concluído'),

-- Dado 3
('TransPetro BR', 'Projeto de Anomalias Críticas', 
 'Detectar e corrigir anomalias críticas em dutos subterrâneos.', 
 'Explosões causadas por acúmulo de pressão.', 
 12000000.00, 'Destruição de áreas urbanas e impacto social.', 
 500000.00, 7500000.00, '2025-03-01', '2025-12-31', 'Planejado');

-- Vizualizar tabela

select * from Clientes