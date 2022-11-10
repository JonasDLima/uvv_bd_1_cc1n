#!/bin/bash

echo "Instalando suporte para varias linguagens ..."

dnf install langpacks-en glibc-all-langpacks;

echo "Reiniciando postgres ..."

systemctl restart postgresql-14.service;

echo "Acessando o cliente do postgreSql ..."

#Inicio da criacao do banco de dados.

su -c -u postgres psql;

#Criacao do usuario
#...

exit;

psql -U jonas3 uvv;
