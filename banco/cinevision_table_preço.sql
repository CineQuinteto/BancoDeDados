CREATE TABLE if not exists tipo_ingresso (
  id_tipo_ingresso INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(40) NOT NULL UNIQUE,
  descricao VARCHAR(200),
  exige_comprovacao BOOLEAN NOT NULL DEFAULT FALSE,
  ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE if not exists tabela_preco (
  id_preco INT AUTO_INCREMENT PRIMARY KEY,
  id_tipo_sala INT NOT NULL,
  id_formato INT NOT NULL,
  id_tipo_ingresso INT NOT NULL,
  dia_semana TINYINT NOT NULL COMMENT '1=Domingo ... 7=Sábado',
  hora_inicio TIME NOT NULL,
  hora_fim TIME NOT NULL,
  valor DECIMAL(8,2) NOT NULL CHECK (valor >= 0),
  vigencia_inicio DATE NOT NULL,
  vigencia_fim DATE NULL,
  FOREIGN KEY (id_tipo_sala) REFERENCES tipo_sala(id_tipo_sala),
  FOREIGN KEY (id_formato) REFERENCES formato(id_formato),
  FOREIGN KEY (id_tipo_ingresso) REFERENCES tipo_ingresso(id_tipo_ingresso),
  INDEX idx_preco_busca (id_tipo_sala, id_formato, id_tipo_ingresso, dia_semana, vigencia_inicio)
);


CREATE TABLE if not exists	taxa_conveniencia (
  id_taxa INT AUTO_INCREMENT PRIMARY KEY,
  tipo ENUM('percentual','fixa') NOT NULL,
  valor DECIMAL(6,2) NOT NULL,
  vigencia_inicio DATE NOT NULL,
  vigencia_fim DATE NULL
);

CREATE TABLE if not exists cupom (
  id_cupom INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(30) NOT NULL UNIQUE,
  tipo_desconto ENUM('percentual','valor') NOT NULL,
  valor_desconto DECIMAL(8,2) NOT NULL,
  validade_inicio DATETIME NOT NULL,
  validade_fim DATETIME NOT NULL,
  limite_uso INT NULL,
  usos_realizados INT NOT NULL DEFAULT 0,
  ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE if not exists produto (
  id_produto INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  categoria ENUM('pipoca','bebida','doce','combo') NOT NULL,
  preco DECIMAL(8,2) NOT NULL CHECK (preco >= 0),
  ativo BOOLEAN NOT NULL DEFAULT TRUE
);