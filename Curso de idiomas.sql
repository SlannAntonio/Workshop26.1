CREATE TABLE Aluno (
    Id_aluno INT PRIMARY KEY,
    Nome CHAR(100),
    Data_nasc DATE,
    E_mail VARCHAR(100),
    CPF VARCHAR(14)
);

CREATE TABLE Professor (
    Id_professor INT PRIMARY KEY,
    Nome CHAR(100),
    CPF VARCHAR(14),
    E_Mail VARCHAR(100),
    Telefone VARCHAR(20)
);

CREATE TABLE Turma (
    Id_turma INT PRIMARY KEY,
    Periodo VARCHAR(50),
    Turno CHAR(20),
    Id_aluno INT,
    Id_professor INT,
    FOREIGN KEY (Id_aluno) REFERENCES Aluno(Id_aluno),
    FOREIGN KEY (Id_professor) REFERENCES Professor(Id_professor)
);

CREATE TABLE Curso (
    Id_curso INT PRIMARY KEY,
    Idioma CHAR(50),
    Nivel CHAR(50),
    Id_turma INT,
    FOREIGN KEY (Id_turma) REFERENCES Turma(Id_turma)
);

CREATE TABLE Matricula (
    Id_matricula INT PRIMARY KEY,
    Data_mat DATE,
    Status CHAR(20),
    Id_aluno INT,
    FOREIGN KEY (Id_aluno) REFERENCES Aluno(Id_aluno)
);

CREATE TABLE Pagamento (
    Id_pagamento INT PRIMARY KEY,
    Data_pgto DATE,
    Desconto DECIMAL(10,2),
    Data_venc DATE,
    Valor DECIMAL(10,2),
    Status CHAR(20),
    Id_matricula INT,
    FOREIGN KEY (Id_matricula) REFERENCES Matricula(Id_matricula)
);