
CREATE SEQUENCE hr.regioes_id_regiao_seq;

CREATE TABLE hr.regioes (
                id_regiao INTEGER NOT NULL DEFAULT nextval('hr.regioes_id_regiao_seq'),
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT regioes_pk PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE hr.regioes IS 'Tabela de regioes contendo codigo e nome das regioes; utilizada em conjunto com paises e localizacoes para compor o endereco dos departamentos.';
COMMENT ON COLUMN hr.regioes.id_regiao IS 'PK da tabela de regioes, utilizada como FK na tabela de paises.';
COMMENT ON COLUMN hr.regioes.nome IS 'AK utlizada como chave secundaria da tabela de regioes; correspondendo tambem a uma unica linha da tabela.';


ALTER SEQUENCE hr.regioes_id_regiao_seq OWNED BY hr.regioes.id_regiao;

CREATE UNIQUE INDEX regioes_ak
 ON hr.regioes
 ( nome );

CREATE TABLE hr.paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT paises_pk PRIMARY KEY (id_pais)
);
COMMENT ON TABLE hr.paises IS 'Tabela de paises contendo codigo, nome e codigo das regioes pertecentes ao pais.
Compoe o endereco juntamente com a tabela de localizacoes e a tabela de regioes, se relaciona com a tabela de localizacoes atraves da chave estrangeira id_pais na tabela de localizacoes.';
COMMENT ON COLUMN hr.paises.id_pais IS 'PK da tabela e utilizada como FK na tabela de localizacoes.';
COMMENT ON COLUMN hr.paises.nome IS 'Chave secundaria da tabela de paises';
COMMENT ON COLUMN hr.paises.id_regiao IS 'FK da tabela de regioes';


CREATE UNIQUE INDEX paises_ak
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizacoes (
                id_localizacoes INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2) NOT NULL,
                CONSTRAINT localizacoes_pk PRIMARY KEY (id_localizacoes)
);
COMMENT ON TABLE hr.localizacoes IS 'Tabela de localizacoes contem o codigo, nome da rua, cidade, codigo do estado e o codigo do pais ao qual o endereco pertence.
Relaciona os enderecos dos departamentos atraves da FK id_localizacao na tabela de departamentos.';
COMMENT ON COLUMN hr.localizacoes.id_localizacoes IS 'Pk da tabela e utilizada como FK na tabela de departamentos';
COMMENT ON COLUMN hr.localizacoes.endereco IS 'Contem o nome da rua e numero de um determinado departamento.';
COMMENT ON COLUMN hr.localizacoes.cep IS 'Codigo postal de determinado departamento';
COMMENT ON COLUMN hr.localizacoes.cidade IS 'Cidade de determinado departamento.';
COMMENT ON COLUMN hr.localizacoes.uf IS 'Codigo do estado de determinado departamento';
COMMENT ON COLUMN hr.localizacoes.id_pais IS 'FK da tabela de paises';


ALTER TABLE hr.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES hr.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
