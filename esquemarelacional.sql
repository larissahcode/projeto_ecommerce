-- Criação do banco de Dados para o cenário E-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- Criar tabela Cliente
create table clients(
		idClient int auto_increment primary key,
        Fname varchar (10),
        Minit char (3),
        Lname varchar (20),
        telephone varchar (11),
		email varchar (45),
        CPF char(11) not null,
        Address varchar (100),
        constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;

-- desc clients;

-- Criar tabela Produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar (50),
        category enum ('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Moveis') not null,
        productDescription varchar (45),
        productValue float default 0
);

alter table product auto_increment=1;

-- Criar tabela pagamentos
create table payments(
    idClient int,
    idpayment int,
    typePayment enum('Boleto', 'Cartão', 'Dois Cartões'),
    limitAvaliable float,
    primary key(idClient, idpayment)
);

-- Criar tabela Pedido
create table orders(
    idOrders int auto_increment primary key,
    idOrderClient int,
    ordersStatus enum('Cancelado', 'Confirmado', 'Em Processamento') default 'Em processamento',
    ordesDescription varchar (255),
    sendValeu float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
                           on update cascade
);

alter table orders auto_increment=1;

-- desc orders;

-- Criar tabela Estoque
create table productStorage(
    idProdStorage int auto_increment primary key,
    storagelocation varchar (45),
    quantity int default 0
);

alter table productStorage auto_increment=1;

-- Criar tabela Fornecedor
create table supplier(
    idsupplier int auto_increment primary key,
    SocialName varchar (45) not null,
    CNPJ char (15) not null,
    telephone varchar (11) not null,
    Address varchar (30),
    email varchar (45),
    constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment=1;

-- desc supplier;

-- Criar tabela Vendedor
create table seller(
    idSeller int auto_increment primary key,
    AbstName varchar (45),
	RazaoSocial varchar (45) not null,
    CNPJ char (15) ,
	CPF char (11) ,
    telephone varchar (11) not null,
    Address varchar (30),
    email varchar (45),
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment=1;

-- Criar tabela Produtos por vendedor - Terceiros
create table productSeller(
    idPSeller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPSeller, idProduct),
    constraint fk_product_seller foreign key (idPSeller) references seller (idSeller),
    constraint fk_product_product foreign key (idProduct) references product (idProduct)
    );
    
-- desc productSeller;
    
-- Criar tabela relação de Produtos e Pedidos
create table productOrder(
    idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum ('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
	constraint fk_productorder_seller foreign key (idPOproduct) references product (idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders (idOrders)
);

-- desc productOrder;

-- Criar tabela relação de produto e estoque
create table storageLocation(
    idLproduct int,
    idLstorage int,
    location varchar (255) not null,
    primary key (idLproduct, idLstorage),
	constraint fk_producted_seller foreign key (idLproduct) references product (idproduct),
    constraint fk_producted_product foreign key (idLstorage) references productStorage (idProdStorage)
);
-- desc storageLocation;

create table productSupplier(
    idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
	constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier (idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product (idProduct)
);

-- desc productSupplier;
-- show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';
