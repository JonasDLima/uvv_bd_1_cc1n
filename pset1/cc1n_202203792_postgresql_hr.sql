
CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT cargos_pk PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE hr.cargos IS 'Tabela de cargos contendo: codigo, nome do cargo, salario minimo e maximo do cargo';
COMMENT ON COLUMN hr.cargos.id_cargo IS 'Pk da tabela e FK na tabela de empregados';
COMMENT ON COLUMN hr.cargos.cargo IS 'Coluna contendo o nome do cargo';
COMMENT ON COLUMN hr.cargos.salario_minimo IS 'Coluna contendo o salario base do cargo';
COMMENT ON COLUMN hr.cargos.salario_maximo IS 'Coluna contendo o salario maximo para o cargo';


CREATE UNIQUE INDEX cargos_idx
 ON hr.cargos
 ( cargo );

CREATE TABLE hr.regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT regioes_pk PRIMARY KEY (id_regiao)
);
COMMENT ON TABLE hr.regioes IS 'Tabela de regioes contendo codigo e nome das regioes; utilizada em conjunto com paises e localizacoes para compor o endereco dos departamentos.';
COMMENT ON COLUMN hr.regioes.id_regiao IS 'PK da tabela de regioes, utilizada como FK na tabela de paises.';
COMMENT ON COLUMN hr.regioes.nome IS 'Chave secundaria da tabela de regioes; correspondendo tambem a uma unica linha da tabela.';


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
COMMENT ON COLUMN hr.paises.nome IS 'Chave secundaria da tabela de paises; correspondendo tambem a uma unica linha da tabela.';
COMMENT ON COLUMN hr.paises.id_regiao IS 'FK da tabela de regioes';


CREATE UNIQUE INDEX paises_ak
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2) NOT NULL,
                CONSTRAINT localizacoes_pk PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE hr.localizacoes IS 'Tabela de localizacoes contem o codigo, nome da rua, cidade, codigo do estado e o codigo do pais ao qual o endereco pertence.
Relaciona os enderecos dos departamentos atraves da FK id_localizacao na tabela de departamentos.';
COMMENT ON COLUMN hr.localizacoes.id_localizacao IS 'Pk da tabela e utilizada como FK na tabela de departamentos';
COMMENT ON COLUMN hr.localizacoes.endereco IS 'Contem o nome da rua e numero de um determinado departamento.';
COMMENT ON COLUMN hr.localizacoes.cep IS 'Codigo postal de determinado departamento';
COMMENT ON COLUMN hr.localizacoes.cidade IS 'Cidade de determinado departamento.';
COMMENT ON COLUMN hr.localizacoes.uf IS 'Codigo do estado de determinado departamento';
COMMENT ON COLUMN hr.localizacoes.id_pais IS 'FK da tabela de paises';


CREATE TABLE hr.departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_localizacao INTEGER NOT NULL,
                id_gerente INTEGER NOT NULL,
                CONSTRAINT departamentos_pk PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE hr.departamentos IS 'Tabela de departamentos contendo: codigo, nome; relacionada com as tabelas de localizacaoes(id_Localizacao) e empregados(id_empregados)';
COMMENT ON COLUMN hr.departamentos.id_departamento IS 'PK da tabela';
COMMENT ON COLUMN hr.departamentos.nome IS 'Coluna contendo o nome do departamento';
COMMENT ON COLUMN hr.departamentos.id_localizacao IS 'FK da tabela de localizacoes';
COMMENT ON COLUMN hr.departamentos.id_gerente IS 'PK da tabela';


CREATE UNIQUE INDEX departamentos_ak
 ON hr.departamentos
 ( nome );

CREATE TABLE hr.empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                id_departamento INTEGER NOT NULL,
                id_supervisor INTEGER NOT NULL,
                CONSTRAINT empregados_pk PRIMARY KEY (id_empregado)
);
COMMENT ON TABLE hr.empregados IS 'Tabela de empregados contendo: cod, nome, email, telefone, data de contratacao, salario e comissao; relacionada com as tabelas de cargos(id_cargo), departamentos(id_departamentos) e possui auto relacionamento(id_supervisor)';
COMMENT ON COLUMN hr.empregados.id_empregado IS 'PK da tabela';
COMMENT ON COLUMN hr.empregados.nome IS 'Coluna contendo o nome do funcionario';
COMMENT ON COLUMN hr.empregados.email IS 'Coluna contendo email do funcionario, utilizada com chave secundaria';
COMMENT ON COLUMN hr.empregados.telefone IS 'Coluna contendo o telefone';
COMMENT ON COLUMN hr.empregados.data_contratacao IS 'Coluna contendo a data em que o funcionario foi contratado';
COMMENT ON COLUMN hr.empregados.id_cargo IS 'FK da tabela de empregados';
COMMENT ON COLUMN hr.empregados.salario IS 'Coluna contendo salario';
COMMENT ON COLUMN hr.empregados.comissao IS 'Coluna contendo a taxa de comissao do funcionario';
COMMENT ON COLUMN hr.empregados.id_departamento IS 'FK da tabela de departamentos';
COMMENT ON COLUMN hr.empregados.id_supervisor IS 'FK de auto relacionamento';


CREATE UNIQUE INDEX empregados_ak
 ON hr.empregados
 ( email );

CREATE TABLE hr.historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final VARCHAR NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT historico_cargos_pk PRIMARY KEY (id_empregado, data_inicial)
);
COMMENT ON TABLE hr.historico_cargos IS 'Tabela usada para guardar os registros de promocoes e movimentacoes dos funcionarios';
COMMENT ON COLUMN hr.historico_cargos.id_empregado IS 'PK da tabela';
COMMENT ON COLUMN hr.historico_cargos.data_inicial IS 'PK da tabela';
COMMENT ON COLUMN hr.historico_cargos.id_cargo IS 'Pk da tabela e FK na tabela de empregados';
COMMENT ON COLUMN hr.historico_cargos.id_departamento IS 'PK da tabela';


ALTER TABLE hr.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

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

ALTER TABLE hr.departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES hr.localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamento)
REFERENCES hr.departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
