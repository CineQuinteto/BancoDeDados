create database if not exists cinevision;
use cinevision;

CREATE TABLE cinema (
  id_cinema INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  endereco VARCHAR(200) NOT NULL,
  cidade VARCHAR(80) NOT NULL,
  uf CHAR(2) NOT NULL,
  telefone VARCHAR(20)
);

CREATE TABLE if not exists tipo_sala (
  id_tipo_sala INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE if not exists sala (
  id_sala INT AUTO_INCREMENT PRIMARY KEY,
  id_cinema INT NOT NULL,
  id_tipo_sala INT NOT NULL,
  nome VARCHAR(40) NOT NULL,
  capacidade SMALLINT NOT NULL,
  FOREIGN KEY (id_cinema) REFERENCES cinema(id_cinema),
  FOREIGN KEY (id_tipo_sala) REFERENCES tipo_sala(id_tipo_sala),
  UNIQUE (id_cinema, nome)
);

CREATE TABLE if not exists assento (
  id_assento INT AUTO_INCREMENT PRIMARY KEY,
  id_sala INT NOT NULL,
  fileira CHAR(2) NOT NULL,
  numero TINYINT NOT NULL,
  tipo ENUM('normal','pcd','obeso','casal') NOT NULL DEFAULT 'normal',
  FOREIGN KEY (id_sala) REFERENCES sala(id_sala),
  UNIQUE (id_sala, fileira, numero)
);

CREATE TABLE if not exists genero (
  id_genero INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE if not exists filme (
  id_filme INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  titulo_original VARCHAR(150),
  sinopse TEXT,
  duracao_min SMALLINT NOT NULL,
  classificacao ENUM('L','10','12','14','16','18') NOT NULL,
  data_estreia DATE,
  url_poster VARCHAR(255),
  url_trailer VARCHAR(255),
  ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE if not exists filme_genero (
  id_filme INT NOT NULL,
  id_genero INT NOT NULL,
  PRIMARY KEY (id_filme, id_genero),
  FOREIGN KEY (id_filme) REFERENCES filme(id_filme),
  FOREIGN KEY (id_genero) REFERENCES genero(id_genero)
);

CREATE TABLE if not exists formato (
  id_formato INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(20) NOT NULL UNIQUE      -- 2D, 3D
);

CREATE TABLE if not exists sessao (
  id_sessao INT AUTO_INCREMENT PRIMARY KEY,
  id_filme INT NOT NULL,
  id_sala INT NOT NULL,
  id_formato INT NOT NULL,
  idioma ENUM('dublado','legendado','nacional') NOT NULL,
  data_hora_inicio DATETIME NOT NULL,
  status ENUM('aberta','esgotada','cancelada') NOT NULL DEFAULT 'aberta',
  FOREIGN KEY (id_filme) REFERENCES filme(id_filme),
  FOREIGN KEY (id_sala) REFERENCES sala(id_sala),
  FOREIGN KEY (id_formato) REFERENCES formato(id_formato),
  UNIQUE (id_sala, data_hora_inicio),
  INDEX idx_sessao_data (data_hora_inicio)
);

CREATE TABLE if not exists cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) NOT NULL,
  cpf CHAR(11) UNIQUE,
  data_nascimento DATE,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
