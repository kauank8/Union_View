Create database ExercicioUnion
Go
use ExercicioUnion

Go
Create table Curso(
codigo int not null,
nome varchar(70) not null,
sigla varchar(10) not null
Primary Key(codigo)
)
Go
Create table Aluno(
ra char(7) not null,
nome varchar(250) not null,
codigo_curso int not null
Primary Key(ra)
Foreign Key(codigo_curso) References Curso(codigo)
)
Go
Create table Palestrante(
codigo int Identity,
nome varchar(250) not null,
empresa varchar(100) not null,
Primary Key(codigo)
)
Go
Create table Palestra(
codigo int identity,
titulo varchar(max) not null,
carga_horaria int null,
data datetime not null,
codigo_palestrante int not null, 
Primary key(codigo),
Foreign key(codigo_palestrante) References Palestrante(codigo)  
)
Go
Create Table Aluno_Inscritos(
ra_aluno char(7) not null,
codigo_palestra int not null,
Primary key(ra_aluno, codigo_palestra),
Foreign key(ra_aluno) References Aluno(ra),
Foreign key(codigo_palestra) References Palestra(codigo),
)
Go
Create table Nao_Alunos(
rg varchar(9) not null,
orgao_exp char(5) not null,
nome varchar(250) not null
Primary key(rg, orgao_exp)
)
Go
Create Table Nao_Alunos_Inscritos(
codigo_palestra int not null,
rg varchar(9) not null,
orgao_exp char(5) not null
Primary Key(codigo_palestra, rg, orgao_exp),
Foreign Key(codigo_palestra) References Palestra(codigo),
Foreign Key(rg, orgao_exp) References Nao_Alunos(rg,orgao_exp)
)


--Selects

Select a.nome as Nome_Pessoa, ai.ra_aluno as Num_Doc , p.titulo as Titulo_Palestra, pa.nome as Nome_Palestrante,
p.carga_horaria as Carga_Horario, p.data as Data
From Aluno a, Aluno_Inscritos ai, Palestra p, Palestrante pa
Where a.ra = ai.ra_aluno
and   p.codigo_palestrante = pa.codigo
and   p.codigo = ai.codigo_palestra
Union
Select na.nome as Nome_Pessoa, nai.rg + nai.orgao_exp as Num_Doc,  p.titulo as Titulo_Palestra, pa.nome as Nome_Palestrante,
p.carga_horaria as Carga_Horario, p.data as Data
From Nao_Alunos na, Nao_Alunos_Inscritos nai, Palestra p, Palestrante pa
Where na.orgao_exp =nai.orgao_exp
and   na.rg = nai.rg
and   p.codigo_palestrante = pa.codigo
and   p.codigo = nai.codigo_palestra


Create view v_listaPresenca
as
Select a.nome as Nome_Pessoa, ai.ra_aluno as Num_Doc , p.titulo as Titulo_Palestra, pa.nome as Nome_Palestrante,
p.carga_horaria as Carga_Horario, p.data as Data
From Aluno a, Aluno_Inscritos ai, Palestra p, Palestrante pa
Where a.ra = ai.ra_aluno
and   p.codigo_palestrante = pa.codigo
and   p.codigo = ai.codigo_palestra
Union
Select na.nome as Nome_Pessoa, nai.rg + nai.orgao_exp as Num_Doc,  p.titulo as Titulo_Palestra, pa.nome as Nome_Palestrante,
p.carga_horaria as Carga_Horario, p.data as Data
From Nao_Alunos na, Nao_Alunos_Inscritos nai, Palestra p, Palestrante pa
Where na.orgao_exp =nai.orgao_exp
and   na.rg = nai.rg
and   p.codigo_palestrante = pa.codigo
and   p.codigo = nai.codigo_palestra

-- Select view
Select * from v_listaPresenca
Order by Nome_Pessoa


