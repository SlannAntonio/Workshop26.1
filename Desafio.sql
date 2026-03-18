 CREATE SCHEMA Desafio 

/*Tabelas*/
CREATE TABLE jogadores(
  JogBid INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  DataNasc DATE NOT NULL,
  NomECompleto VARCHAR(80) NOT NULL,
  Posicao VARCHAR(20) NOT NULL
);

CREATE TABLE Clubes(
  Idclube INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  DataFund DATE NOT NULL,
  NomeClube VARCHAR(20) NOT NULL,
  Estadio VARCHAR(20) NULL
);


/* Linhas de cada tbela*/
INSERT INTO jogadores (JogBid, DataNasc, NomECompleto, Posicao) VALUES
(1, '1990-05-12', 'Alisson Becker', 'Goleiro'),
(2, '1994-05-14', 'Marquinhos', 'Zagueiro'),
(3, '1984-09-22', 'Thiago Silva', 'Zagueiro'),
(4, '1992-02-23', 'Casemiro', 'Volante'),
(5, '1997-10-03', 'Bruno Guimarães', 'Meia'),
(6, '1992-02-05', 'Neymar Júnior', 'Meia Atacante'),
(7, '2000-07-12', 'Vinícius Júnior', 'Atacante'),
(8, '2001-01-09', 'Rodrygo Silva', 'Atacante'),
(9, '1997-03-03', 'Richarlison de Andrade', 'Centroavante'),
(10, '1991-10-02', 'Roberto Firmino', 'Centroavante');


INSERT INTO Clubes (Idclube, DataFund, NomeClube, Estadio) VALUES
(1, '1912-04-14', 'Santos FC', 'Vila Belmiro'),
(2, '1910-09-01', 'Corinthians', 'Neo Química Arena'),
(3, '1895-11-17', 'Flamengo', ''),
(4, '1914-08-26', 'Palmeiras', 'Allianz Parque'),
(5, '1930-01-25', 'São Paulo FC', 'Morumbi'),
(6, '1898-08-21', 'Vasco da Gama', 'São Januário'),
(7, '1908-03-25', 'Atlético Mineiro', 'Arena MRV'),
(8, '1909-04-04', 'Internacional', 'Beira-Rio'),
(9, '1903-09-15', 'Grêmio', 'Arena do Grêmio'),
(10, '1904-08-12', 'Botafogo', 'Nilton Santos')


/*DML*/ 
ALTER TABLE jogadores ADD COLUMN Idclube INTEGER;

UPDATE Jogadores
SET IdClube = 1
WHERE JogBid = 6;
*/


/*DQL*/ 
SELECT * FROM Jogadores
Where Posicao = 'Volante';
*/

/* Agregadas*/ 
SELECT MIN(DataFund)
FROM Clubes;

SELECT DataFund, 
COUNT (*) FROM Clubes GROUP BY DataFund;

SELECT MAX(DataNasc)
FROM Jogadores;


/*Agrupadas*/ 
SELECT Posicao, 
Count(*) AS Quantidade
FROM Jogadores GROUP BY Posicao HAVING COUNT(*) > 1;

SELECT Estadio,
 COUNT(*) AS Total
FROM Clubes GROUP BY Estadio;


/*join*/
SELECT jogadores.NomECompleto, Clubes.NomeClube
FROM jogadores
INNER JOIN Clubes ON jogadores.Idclube = Clubes.Idclube;
