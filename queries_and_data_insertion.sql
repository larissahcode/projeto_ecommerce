-- inserção de dados e queries
use ecommerce;

show tables;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, telephone, email, CPF, Address) 
	   values('Maria','M','Silva', '61998466632', 'mariam@gmail.com', 19818722209, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     ('Matheus','O','Pimentel', '62987634657', 'matheuso@gmail.com',98765432125,'rua alemeda 289, Centro - Cidade das flores'),
			 ('Ricardo','F','Silva', '61947678282', 'ricardof@gmail.com',4567891363,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 ('Julia','S','França', '61986477278', 'julias@gmail.com',78912345663,'rua lareijras 861, Centro - Cidade das flores'),
			 ('Roberta','G','Assis', '61987634829', 'robertag@gmail.com',9874563164,'avenidade koller 19, Centro - Cidade das flores'),
			 ('Isabela','M','Cruz', '61999837473', 'isabelam@gmail.com',65478912354,'rua alemeda das flores 28, Centro - Cidade das flores');


-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (Pname, category) values
							  ('Fone de ouvido', 'Eletrônico'),
                              ('Barbie Elsa', 'Brinquedos'),
                              ('Body Carters', 'Vestimenta'),
                              ('Microfone Vedo - Youtuber', 'Eletrônico'),
                              ('Sofá retrátil', 'Móveis'),
                              ('Farinha de arroz','Alimentos'),
                              ('Fire Stick Amazon','Eletrônico');

select * from clients;
select * from product;
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash

delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, ordersStatus, ordesDescription, sendValeu, paymentCash) values 
							 (1, default,'compra via aplicativo',null,1),
                             (2,default,'compra via aplicativo',50,0),
                             (3,'Confirmado',null,null,1),
                             (4,default,'compra via web site',150,0);

-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,1,1,null),
                         (3,2,1,null);

-- storageLocation,quantity
insert into productStorage (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, telephone) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (AbstName, RazaoSocial, CNPJ, CPF, telephone, Address, email) values 
						(null,'Tech eletronics',  123456789456321, null, 219946287,'Rio de Janeiro', 'techeletronic@gmail.com'),
					    (null,'Botique Durgas',null,123456783, 19567895, 'Rio de Janeiro','botiquedurgas@gmail.com'),
						(null,'Kids World',456789123654485,null, 1198657484, 'São Paulo', 'kidsworld@gmail.com');

select * from seller;
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPSeller, idProduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);

select * from productSeller;

select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select Fname,Lname, idOrders, ordersStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ',Lname) as Client, idOrders as Request, ordersStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, ordersStatus, ordesDescription, sendValeu, paymentCash) values 
							 (2, default,'compra via aplicativo',null,1);
                             
select count(*) from clients c, orders o 
			where c.idClient = idOrderClient;

select * from orders;

-- recuperação de pedido com produto associado
select * from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
                inner join productOrder p on p.idPOorder = o.idOrders
		group by idClient; 
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient
		group by idClient; 