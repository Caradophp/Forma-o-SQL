create database if not exists ecommerce;

use ecommerce;

create table cliente (
	idCliente int auto_increment primary key,
	Pnome varchar(10),
	Minit char(3),
	Unome varchar(20),
	CPF char(11) not null,
	endereco varchar(45),
	data_nascimento date not null,
	constraint unique_cpf_cliente unique (CPF)
);

create table produto (
	idProduto int auto_increment primary key,
	Pnome varchar(10),
	classificado_criancas bool default false,
	categorias enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
	avaliacao float default 0,
	dimencao varchar(10),
	constraint check_avaliacao check (avaliacao <= 5)
);

create table pedido (
	idPedido int auto_increment primary key,
	idPedidoCliente int,
	pedidoStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
	pedidoDescricao varchar(255),
	frete float default 10,
	pagamento enum('Débito', 'Crédito', 'Dinheiro', 'Pix', 'Boleto'),
	constraint fk_pedido_cliente foreign key (idPedidoCliente) references cliente (idCliente)
);

create table estoque (
	idProdutoEstoque int auto_increment primary key,
	local varchar (45),
	quantidade int
);

create table fornecedor (
	idFornecedor int auto_increment primary key,
	razao_social varchar(255) not null,
	CNPJ char(15) not null,
	contato char(11) default 0,
	constraint unique_fornecedor unique(CNPJ)
);

create table vendedor (
	idVendedor int auto_increment primary key,
	razao_social varchar(255) not null,
	nome_fantasia varchar(255),
	CNPJ char(15),
	CPF char(9),
	localizacao varchar(255),
	contato char(11) not null,
	constraint unique_cnpj_vendedor unique (CNPJ),
	constraint unique_cpf_vendedor unique(CPF)
);

create table produtoVendedor (
	idVendedor int,
	idProduto int,
	quantidade int default 1,
	primary key (idVendedor, idProduto),
	constraint fk_vendedor_produtoVendedor foreign key (idVendedor) references vendedor (idVendedor),
	constraint fk_produto_produtoVendedor foreign key (idProduto) references produto (idProduto)
);

create table produtoPedido (
	idPedido int,
	idProduto int,
	quantidade int default 1,
	status enum('Disponível', 'Sem estoque') default 'Disponível',
	primary key (idPedido, idProduto),
	constraint fk_pedido_produtoPedido foreign key (idPedido) references pedido (idPedido),
	constraint fk_produto_produtoPedido foreign key (idProduto) references produto (idProduto)
);

create table localizacaoArmazem (
	idArmazem int,
	idProduto int,
	localizacao varchar(255) not null,
	primary key (idArmazem, idProduto),
	constraint fk_estoque_localizacaoArmazem foreign key (idArmazem) references estoque (idProdutoEstoque),
	constraint fk_produto_localizacaoArmazem foreign key (idProduto) references produto (idProduto)
);


show tables;
