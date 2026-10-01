CREATE TABLE if not exists pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  id_cupom INT NULL,
  status ENUM('pendente','pago','cancelado','expirado') NOT NULL DEFAULT 'pendente',
  subtotal DECIMAL(10,2) NOT NULL DEFAULT 0,
  desconto DECIMAL(10,2) NOT NULL DEFAULT 0,
  taxa_conveniencia DECIMAL(10,2) NOT NULL DEFAULT 0,
  total DECIMAL(10,2) NOT NULL DEFAULT 0,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expira_em DATETIME NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_cupom) REFERENCES cupom(id_cupom)
);

CREATE TABLE if not exists ingresso (
  id_ingresso INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_sessao INT NOT NULL,
  id_assento INT NOT NULL,
  id_tipo_ingresso INT NOT NULL,
  valor_pago DECIMAL(8,2) NOT NULL,      -- preço congelado no momento da compra
  codigo_qr VARCHAR(64) NOT NULL UNIQUE,
  utilizado_em DATETIME NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_sessao) REFERENCES sessao(id_sessao),
  FOREIGN KEY (id_assento) REFERENCES assento(id_assento),
  FOREIGN KEY (id_tipo_ingresso) REFERENCES tipo_ingresso(id_tipo_ingresso),
  UNIQUE (id_sessao, id_assento)         -- RN03: impede venda duplicada
);

CREATE TABLE if not exists pedido_item (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_produto INT NOT NULL,
  quantidade SMALLINT NOT NULL CHECK (quantidade > 0),
  preco_unitario DECIMAL(8,2) NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE if not exists pagamento (
  id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  metodo ENUM('cartao_credito','cartao_debito','pix') NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  status ENUM('pendente','aprovado','recusado','estornado') NOT NULL,
  id_transacao_gateway VARCHAR(100),
  pago_em DATETIME NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
