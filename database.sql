-- ---------------------------------------------------------------- --
--               SCRIPT  PARA AULA INICIAL DE SQL                   --
-- ---------------------------------------------------------------- --

DROP DATABASE IF EXISTS loja_simples_aula01;

CREATE DATABASE loja_simples_aula01;

USE loja_simples_aula01;

CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50)
);

-- Tabela de Produtos
CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT
);

-- Tabela de Pedidos
CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);

-- ----------------------------------------------------------------

-- Inserindo Clientes
INSERT INTO Clientes (nome, cidade) VALUES
('Ana Lisboa', 'Sao Paulo'),
('Ana Resende', 'Rio de Janeiro'),
('Augusto Deolindo', 'Belo Horizonte'),
('Elaine Lopes', 'Sao Paulo'),
('Giovana Marques', 'Curitiba'),
('Gustavo Rodrigues', 'Sao Paulo'),
('Janine Furtado', 'Belo Horizonte'),
('Joao Resende', 'Salvador'),
('Joao Marques', 'Sao Paulo'),
('Kauan Obata', 'Curitiba'),
('Luan Santos', 'Rio de Janeiro'),
('Lucas Cruz', 'Sao Paulo'),
('Luis Dias', 'Belo Horizonte'),
('Luiz Araujo', 'Salvador'),
('Maria Cintia', 'Sao Paulo'),
('Nicole Muchon', 'Curitiba'),
('Raphael Siqueira', 'Rio de Janeiro'),
('Ryan Dias', 'Belo Horizonte');

-- Inserindo Produtos (LISTA EXPANDIDA)
INSERT INTO Produtos (nome, preco, estoque) VALUES
('Teclado Mecanico', 350.00, 50),
('Mouse Gamer', 180.50, 80),
('Monitor 24 polegadas', 950.00, 30),
('SSD 480GB', 299.90, 100),
('Webcam Full HD', 480.00, 45),
('Headset Gamer RGB', 250.00, 60),
('HD Externo 1TB', 380.00, 75),
('Mousepad Grande', 80.00, 150),
('Cadeira Gamer Confort', 1250.00, 20),
('Memoria RAM 8GB DDR4', 210.00, 90);

INSERT INTO Pedidos (cliente_id, produto_id, quantidade, data_pedido) VALUES
(1, 1, 1, '2025-09-01'), -- Ana Lisboa comprou um Teclado
(1, 2, 1, '2025-09-01'), -- Ana Lisboa comprou tambem um Mouse
(2, 3, 1, '2025-09-03'), -- Ana Resende comprou um Monitor
(3, 5, 1, '2025-09-05'), -- Augusto Deolindo comprou uma Webcam
(4, 4, 2, '2025-09-10'), -- Elaine Lopes comprou dois SSDs
(1, 4, 1, '2025-09-15'), -- Ana Lisboa comprou um SSD
(5, 2, 1, '2025-09-20'), -- Giovana Marques comprou um Mouse
(8, 6, 1, '2025-09-22'), -- Joao Resende comprou um Headset
(12, 10, 2, '2025-09-25'), -- Lucas Cruz comprou duas Memorias RAM
(15, 9, 1, '2025-09-28'), -- Maria Cintia comprou uma Cadeira Gamer
(1, 7, 1, '2025-10-01'), -- Ana Lisboa comprou um HD Externo
(6, 8, 3, '2025-10-02'), -- Gustavo Rodrigues comprou tres Mousepads
(2, 2, 1, '2025-10-03'), -- Ana Resende comprou outro Mouse
(11, 4, 1, '2025-10-04'), -- Luan Santos comprou um SSD
(18, 1, 1, '2025-10-05'); -- Ryan Dias comprou um Teclado Mecanico

-- > EXERCIUCIOS AULA BANCO DE DADOS II - 3 BIMESTRE < 

-- > EXERCÍCIOS AULA BANCO DE DADOS II - 3 BIMESTRE < 

-- Nível 1

SELECT * FROM Produtos; -- seleciona todos os produtos cadastrados

SELECT nome, cidade FROM Clientes; -- seleciona apenas nome e cidade da tabela clientes

SELECT * FROM Produtos
WHERE preco > 400; -- seleciona apenas aqueles produtos com preço maior que 400

SELECT * FROM Clientes ORDER BY nome ASC; -- ordena os clientes pela ordem alfabética do nome

SELECT * FROM Produtos ORDER BY estoque DESC; -- ordena os produtos em ordem decrescente na quantidade de estoque

SELECT * FROM Produtos
WHERE nome LIKE '%Gamer%'; -- lista todos os produtos com gamer no nome
-- > 'gamer%' = nome que começa com 'gamer', '%gamer' = nome que termina com 'gamer' e '%gamer%' = nome que tem 'gamer' em qualquer posição

SELECT DISTINCT cidade FROM Clientes; -- seleciona apenas as cidades únicas na tabela clientes


-- Nível 2

SELECT COUNT(*) FROM Pedidos; -- conta quantos pedidos teve e retorna um número inteiro

SELECT MAX(preco), MIN(preco) FROM Produtos; -- retorna os valores do produto mais caro e do mais barato

SELECT SUM(preco * estoque) FROM Produtos; -- valor total de todos os produtos em estoque

SELECT cidade, COUNT(*) FROM Clientes GROUP BY cidade; -- quantos clientes moram em cada cidade


-- Nível 3

SELECT Clientes.nome AS nome_cliente, Produtos.nome AS nome_produto
FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
INNER JOIN Produtos ON Pedidos.produto_id = Produtos.id; -- junta as tabelas para mostrar o nome do cliente e o produto que ele comprou

SELECT Clientes.nome AS nome_cliente, Produtos.nome AS nome_produto FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
INNER JOIN Produtos ON Pedidos.produto_id = Produtos.id
WHERE Clientes.nome = 'Ana Lisboa'; -- lista os produtos comprados apenas pela cliente ana lisboa

SELECT Clientes.nome AS nome_cliente, Produtos.nome AS nome_produto, Pedidos.data_pedido FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
INNER JOIN Produtos ON Pedidos.produto_id = Produtos.id
ORDER BY Pedidos.data_pedido DESC; -- mostra os pedidos ordenados pela data, do mais recente para o mais antigo


-- Nível 4

SELECT Clientes.nome, COUNT(Pedidos.id) AS contagem_pedidos FROM Pedidos
INNER JOIN Clientes ON Pedidos.cliente_id = Clientes.id
GROUP BY Clientes.nome
ORDER BY contagem_pedidos DESC
LIMIT 1; -- conta os pedidos de cada cliente e mostra apenas o cliente que comprou mais vezes

SELECT Pedidos.id AS id_pedido, SUM(Produtos.preco * Pedidos.quantidade) AS valor_total
FROM Pedidos
INNER JOIN Produtos ON Pedidos.produto_id = Produtos.id
GROUP BY Pedidos.id; -- calcula o valor total de cada pedido multiplicando o preco pela quantidade

SELECT Produtos.nome, SUM(Pedidos.quantidade) AS total_vendido
FROM Pedidos
INNER JOIN Produtos ON Pedidos.produto_id = Produtos.id
GROUP BY Produtos.nome
ORDER BY total_vendido DESC
LIMIT 1; -- soma as quantidades vendidas de cada produto e mostra apenas qual foi o mais vendido