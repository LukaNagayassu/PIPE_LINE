create database Sprint1;
use Sprint1;
create table Funcionários(
id int auto_increment primary key,
nome varchar(30) not null,
Função varchar(20) not null,
Turno varchar (15)
);
-- fazer o turno aceitar somente manhã,tarde,noite

	insert into Funcionários (nome,Função,Turno)
    values ('Carlos Silva', 'Analista de Sistemas', 'manhã'),
		('Maria Oliveira', 'Gerente de Projetos', 'tarde'),
		('João Souza', 'Desenvolvedor', 'noite'),
        ('Ana Costa', 'Coordenadora de Marketing', 'manhã'),
		('Ricardo Pereira', 'Suporte Técnico', 'tarde'),
		('Fernanda Lima', 'Assistente Administrativo', 'noite'),
		('Roberto Martins', 'Desenvolvedor Frontend', 'manhã'),
		('Patrícia Gomes', 'Analista de Qualidade', 'tarde');
        
     alter table Funcionários add check (turno in (manhã,tarde,noite)
     ;
        select* from Funcionários;
        
        select* from funcionários;

select* from funcionários where escala = "segunda";

select* from funcionários where função = "TI";

select função, nome from funcionários;

-- ----------------------------------
        create table Empresas (
        id int auto_increment primary key,
        nome varchar(30),
        porte varchar(10),
        interesse varchar (10)
        );
        -- fazer o porte aceitar: pequeno, médio e grande
        -- fazer o interesse aceitar baixo, indiferente e interessado
        
        insert into Empresas (nome, porte, interesse) 
	values
    ('Petrobras', 'grande', 'interessado'),
    ('Petrobras Distribuidora', 'grande', 'interessado'),
    ('Raízen', 'grande', 'indiferente'),
    ('PetroReconcavo', 'médio', 'baixo'),
    ('Queiroz Galvão', 'médio', 'interessado'),
    ('Odebrecht Óleo e Gás', 'grande', 'indiferente'),
    ('ENI Brasil', 'médio', 'baixo');
        
        select* from Empresas;


create table agendamento (
id int auto_increment,
dia date,
cliente varchar(20),
acordo varchar (60),
primary key chave(id))
;

insert into agendamento (dia, cliente, acordo)

select* from agendamento;

select* from agendamento where dia between "1" and "17";

select cliente, acordo from agendamento;

