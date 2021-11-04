CREATE DATABASE Marcuzinfood;
USE Marcuzinfood;



create table Endereco (



Id_Endereco int auto_increment,
Bairro varchar (30) ,
Logradouro varchar (30) ,
Complemento varchar (100),
CEP varchar (8) ,
Numero varchar (15),
primary key (Id_Endereco)
);



create table Cliente (

Id_Cliente int auto_increment,
Nome varchar (30) not null,
Data_Nascimento date not null,
Telefone varchar (13),
CPF varchar (11) unique,
Id_Fk_Endereco int,
primary key (Id_Cliente),
FOREIGN KEY (Id_Fk_Endereco) REFERENCES Endereco(Id_Endereco)
);

create Table Produto (
Id_Produto int auto_increment,
Nome varchar (40) not null,
Descricao varchar (100) not null,
Valor_Produto double not null,
Classificacao enum('Bebida', 'Salgado', 'Bebida Alcoolica' , 'Quentinha', 'Lanche', 'Doce', 'Porções'),
primary key (Id_Produto)
);



create table Pedido (

Id_Pedido int auto_increment,
Recebedor varchar (40) not null,
Data_Hora datetime not null,
Status_Pedido enum('Em Andamento', 'Enviando', 'Entregue', 'Cancelado'),
Id_Fk_Cliente int ,
primary key (Id_Pedido),
FOREIGN KEY (Id_Fk_Cliente) REFERENCES Cliente(Id_Cliente)
);

CREATE TABLE PEDIDO_PRODUTO (
Id_Pedido_Produto int primary key auto_increment,
Id_Fk_Produto int,
Id_Fk_Pedido int,
Quantidade_Pedido int,
FOREIGN KEY (Id_Fk_Produto) REFERENCES Produto(Id_Produto),
FOREIGN KEY (Id_Fk_Pedido) REFERENCES Pedido(Id_Pedido)
);



SELECT c.Id_Cliente, c.Nome, p.Id_Pedido, p.Recebedor, po.Nome AS Nome_Produto, po.Valor_Produto, pp.Quantidade_Produto AS Quantidade, po.Valor_Produto*pp.Quantidade_Pedido AS Valor_Total, p.Data_Hora, p.Status_Pedido FROM PEDIDO p
INNER JOIN CLIENTE c ON p.Id_Fk_Cliente = c.Id_Cliente
INNER JOIN PEDIDO_PRODUTO pp ON p.Id_Pedido = pp.Id_Fk_Pedido
INNER JOIN PRODUTO po ON po.Id_Produto = pp.Id_Fk_Produto
WHERE c.Id_Cliente = 1 GROUP BY p.Id_Pedido ASC;