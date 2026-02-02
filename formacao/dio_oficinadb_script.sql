CREATE TABLE CLIENTE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cpf_cnpj VARCHAR(18) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(255),
    endereco VARCHAR(255)
);

CREATE TABLE VEICULO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    ano INT,
    cor VARCHAR(50),
    chassi VARCHAR(17),
    FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id)
);

CREATE TABLE MECANICO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(100),
    cpf VARCHAR(14) UNIQUE NOT NULL,
    comissao_percentual DECIMAL(5,2)
);

CREATE TABLE SERVICO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    preco_base DECIMAL(10,2) NOT NULL,
    tempo_estimado_minutos INT
);

CREATE TABLE PECA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    codigo_fabricante VARCHAR(100) UNIQUE NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    estoque_atual INT DEFAULT 0
);

CREATE TABLE ORDEM_SERVICO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    veiculo_id INT NOT NULL,
    mecanico_id INT,
    data_abertura DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME,
    valor_total DECIMAL(10,2),
    status VARCHAR(50) NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id),
    FOREIGN KEY (veiculo_id) REFERENCES VEICULO(id),
    FOREIGN KEY (mecanico_id) REFERENCES MECANICO(id)
);

CREATE TABLE ITEM_SERVICO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    os_id INT NOT NULL,
    servico_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (os_id) REFERENCES ORDEM_SERVICO(id),
    FOREIGN KEY (servico_id) REFERENCES SERVICO(id)
);

CREATE TABLE ITEM_PECA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    os_id INT NOT NULL,
    peca_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (os_id) REFERENCES ORDEM_SERVICO(id),
    FOREIGN KEY (peca_id) REFERENCES PECA(id)
);
