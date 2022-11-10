-- Prevencao de erros, caso alguma das estruturas ja exista
DROP USER IF EXISTS jonas;
DROP DATABASE IF EXISTS uvv;
DROP SCHEMA IF EXISTS hr;

/*  
    Criacao do usuario para ser o administrador do banco
    concede o privilegio de criar DB e cadastra uma senha
    para o usuario.
*/
CREATE USER jonas WITH 
    ENCRYPTED PASSWORD 'mypass'
    CREATEDB 
;

-- Acessar o postgres com o usuario criado
\connect uvv jonas

-- Criacao do banco de dados
CREATE DATABASE uvv 
    owner "jonas" 
    template "template0" 
    encoding "UTF8" 
    lc_collate "pt_BR.UTF-8" 
    lc_ctype "pt_BR.UTF-8" 
    allow_connections "true"
;

-- Criacao da schema
CREATE SCHEMA hr AUTHORIZATION jonas;

-- Marcando o schema hr como default
ALTER USER jonas
SET SEARCH_PATH TO hr, "$user", public;

/*
    Criacao de toda a estrutura do banco, com
    base no modelo logico desenvolvido no power architect.
*/
