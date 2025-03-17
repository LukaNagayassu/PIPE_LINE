create database Sprint1;
use Sprint1;
create table Funcionários(
id int auto_increment primary key,
nome varchar(30) not null,
Função varchar(30) not null,
Turno varchar (15)
);

	insert into Funcionários (nome,Função,Turno)
    values ('Carlos Silva', 'Analista de Sistemas', 'manhã'),
		('Maria Oliveira', 'Gerente de Projetos', 'tarde'),
		('João Souza', 'TI', 'noite'),
        ('Ana Costa', 'Coordenadora de Marketing', 'manhã'),
		('Ricardo Pereira', 'Suporte Técnico', 'tarde'),
		('Fernanda Lima', 'Assistente Administrativo', 'noite'),
		('Roberto Martins', 'Desenvolvedor Frontend', 'manhã'),
		('Patrícia Gomes', 'Analista de Qualidade', 'tarde');
        
     alter table Funcionários add check (turno in ('manhã','tarde','noite'))
     ;
        select* from Funcionários;
        
        select* from Funcionários where turno = 'manhã';

		select* from Funcionários where função = "TI";

		select função, nome from Funcionários;

-- ----------------------------------
use Sprint1;
        create table Empresas (
        id int auto_increment primary key,
        nome varchar(30),
        porte varchar(10),
        interesse varchar (20)
        );
        
        insert into Empresas (nome, porte, interesse) 
	values
    ('Petrobras', 'grande', 'interessado'),
    ('Petrobras Distribuidora', 'grande', 'interessado'),
    ('Raízen', 'grande', 'indiferente'),
    ('PetroReconcavo', 'médio', 'baixo'),
    ('Queiroz Galvão', 'médio', 'interessado'),
    ('Odebrecht Óleo e Gás', 'grande', 'indiferente'),
    ('ENI Brasil', 'médio', 'baixo');
        
        
	alter table Empresas add check (porte in('pequeno','médio','grande'));
    
    alter table Empresas add check (interesse in('baixo','indiferente','interessado'));
    
        select* from Empresas;
        
		select nome, interesse from Empresas;
        
        select* from Empresas where interesse = 'interessado';
        
-- -----------------------------------------------------------------        

create table agendamento (
id int auto_increment,
dia date,
cliente varchar(40),
acordo varchar (80),
primary key chave(id))
;

insert into agendamento (dia, cliente, acordo)
values ('2025-04-01', 'PetroTech Solutions', 'Monitoramento de Duto Norte - Inspeção Mensal'),
('2025-04-05', 'EnergyTrans Logística', 'Manutenção Preventiva Duto Sul - Análise de Vazamentos'),
('2025-04-08', 'OilFlow Technologies', 'Monitoramento Duto Leste - Análise de fluxo'),
('2025-04-12', 'DutoGuard Engenharia', 'Inspeção e Monitoramento Duto Oeste - Testes de Pressão'),
('2025-04-15', 'BlueOil Consultoria', 'Avaliação de Integridade Duto Central - Sistema de Alarme'),
('2025-04-20', 'SafePipe Monitoring', 'Inspeção Visual e Acústica Duto Norte - Verificação de Ruídos'),
('2025-04-22', 'Petróleo Plus', 'Monitoramento de Vazamentos Duto Sul - Sistemas de alarma');


select* from agendamento;

select* from agendamento where dia between "2025-04-10" and "2025-04-17";

select cliente, acordo from agendamento;

drop database Sprint1;