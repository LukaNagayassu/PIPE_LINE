create database Pipiline_consultancy;
use Pipiline_consultancy;

-- Dados da empresa
create table Empresas ( 
IdEmpresa int primary key,
Nome varchar(40),
CNPJ char(18),
estado varchar(40),
Sigla char(2),
senha varchar(40),
email varchar(40)
);

-- Dados dos funcionarios 
create table Funcionarios (
IdFuncionario int primary key,
Nome varchar(40),
CPF char(14),
Telefone char(11),
Salario varchar(15),
Funcao varchar(40)
);

-- Dados dos representantes das empresas
create table Representantes (
IdRepresentante int primary key,
Nome varchar(40),
email varchar(40),
telefone char(11),
Empresa varchar(40)
);

-- Coloquei auto_increment em todas as tabelas acima.
alter table Representantes modify IdRepresentante int  auto_increment;

alter table Funcionarios modify IdFuncionario int  auto_increment;

alter table Empresas modify IdEmpresa int  auto_increment;