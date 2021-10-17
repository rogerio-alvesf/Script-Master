-- CRIAR TABELA
CREATE DATABASE Gasto;
-- USAR TABELA
USE Gasto;
-- CRIAR TABELA
CREATE TABLE Pessoa(
idPessoa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
data_de_nascimento DATE,
profissao VARCHAR(45),CHECK(profissao = 'Professor'OR profissao = 'Dentista'OR profissao = 'Mecanico'OR profissao ='Engenheiro')
);

CREATE TABLE Gasto(
idGasto INT PRIMARY KEY AUTO_INCREMENT,
data_gasto DATE,
valor DECIMAL(6,3),
descricao VARCHAR(45),
fkPessoa INT, FOREIGN KEY (fkPessoa) REFERENCES Pessoa (idPessoa) -- CRIANDO UMA FK (FOREING KEY) PELO CREATE TABLE
);
-- INSERINDO VALORES NA TABELA
INSERT INTO Pessoa (nome, data_de_nascimento, profissao) VALUES
('Rodrigo','1995-02-04','Professor'),
('Jefersson','1985-05-09','Dentista'),
('Wilherson','1980-09-07','Mecanico'),
('Felipe','2000-07-10','Engenheiro');

INSERT INTO Gasto (data_gasto, valor, descricao, fkpessoa) VALUES
('2000-05-13','13.000','Comprou um FIAT Uno Ano2000',1),
('2021-02-09','150.789','Casamento da Filha',2),
('2005-07-15','50.999','Reforma da casa',3),
('2018-08-07','35.500','Viagem com a Familia',4);

SELECT * FROM Pessoa;
SELECT * FROM Gasto;

-- EXIBIR UM CAMPO ESPECÍFICO DE UM NOME ESPECÍFICO DO ID DE OUTRA TABELA
SELECT (descricao) FROM Gasto JOIN Pessoa ON fkPessoa = idPessoa AND idPessoa = 1; 

-- JOIN NORMAL
SELECT * FROM Gasto JOIN Pessoa ON fkPessoa = idPessoa;

-- EXIBIR A DESCRIÇÃO DA TABLEA
DESC Gasto;

-- CONTADOR DOS REGISTROS COM DADOS
SELECT COUNT(*) FROM Pessoa;

-- CONTADOR DOS REGISTROS COM DADOS DE UMA COLUNA ESPECÍFICA
SELECT COUNT(descricao) from Gasto;

-- EXIBIR O VALOR DA SOMA DE ALGUM CAMPO
SELECT SUM(valor) from Gasto;

-- EXIBIR O VALOR DA SOMA DE ALGUM CAMPO COM UM NOME DE SUA PREFERENCIA
SELECT SUM(valor) AS 'Total de Gasto' FROM Gasto;

-- EXIBIR O VALOR DA MÉDIA DE ALGUM CAMPO
SELECT AVG(valor) AS 'Média de gasto' FROM Gasto;

-- EXIBIR O VALOR DA MÉDIA DE ALGUM CAMPO COM UMA DETERMINADA QUANTIDADE DE NÚMEROS APÓS A VIRGULA
SELECT TRUNCATE(AVG(valor),2) FROM Gasto;

-- EXIBIR O VALOR MINIMO DE ALGUM CAMPO
SELECT MIN(valor) AS 'Mínimo Gasto' FROM Gasto JOIN Pessoa ON fkPessoa = idPessoa;

-- EXIBIR O VALOR MÁXIMO DE ALGUM CAMPO
SELECT MAX(valor) AS "Mínimo Gasto" FROM Gasto JOIN Pessoa ON fkPessoa = idPessoa;

-- EXIBIR O VALOR MINIMO e MÁXIMO DE ALGUM CAMPO
SELECT MIN(valor) AS 'Mínimo Gasto', MAX(valor) AS 'Total de Gasto' FROM Gasto JOIN Pessoa ON fkPessoa = idPessoa;

-- MODIFICAR A COLUNA DE UMA TABELA DE FORMA QUE ELA NÃO PODE RECEBER UM VALOR NULL(NULO) E QUE EXIBE VALOR COM 6 BITS TOTAIS E 3 APÓS A VIRGULA E SE A PESSOA NÃO COLOCA NADA ELE MOSTRA ALGO
ALTER TABLE Gasto MODIFY COLUMN valor FLOAT(6,3) NOT NULL DEFAULT ('$$$$$$');

-- EXIBIR CAMPOS ESPECÍFICO DE UM NOME ESPECÍFICO DO ID DE OUTRA TABELA
SELECT p.nome, g.descricao, g.valor FROM Gasto AS g JOIN Pessoa AS p ON g.fkPessoa = p.idPessoa and p.profissao = 'Engenheiro';

-- INSERINDO MAIS DADOS NAS DUAS TABELAS PARA VALIDAR AS ALTERAÇÕES
INSERT INTO Pessoa (nome, data_de_nascimento, profissao) VALUES
('Jailton Pereira','1995-10-12','Professor');
INSERT INTO Gasto (data_gasto, valor, descricao, fkpessoa) VALUES
(20201227,49.000,'Faculdade do filho mais velho',5);

-- COMANDO PARA ATUALIZAR O DADO DE UMA TABELA PELO ID
UPDATE Gasto SET valor = 15.500  WHERE idGasto = 1;

-- COMANDO PARA ATUALIZAR O DADO DE UMA TABELA PELO NOME
UPDATE Gasto SET valor = 49.999 Where idGasto = (SELECT idPessoa FROM Pessoa WHERE nome = 'Wilherson');

-- AGRUPAR A SOMA DE VALORES PELA PROFISSAO
SELECT SUM(g.valor), p.profissao FROM Gasto AS g JOIN Pessoa AS p ON fkPessoa = idPessoa GROUP BY profissao;

-- INSERINDO MAIS DADOS
INSERT INTO Pessoa (nome, data_de_nascimento, profissao) VALUES
('Leandro Souza','1982-10-15','Engenheiro');
INSERT INTO Gasto (data_gasto, valor, descricao, fkPessoa) VALUES
('2011-05-25',null,'Compra de Bitcoin', 5);

-- COMANDO PARA EXCLUIR O DADO DE UMA TABELA PELO NOME
DELETE FROM Gasto WHERE idGasto = (SELECT idPessoa FROM Pessoa WHERE nome = 'Leandro Souza');
