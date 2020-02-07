USE [master];

CREATE DATABASE [testdb];

GO

USE [testdb];


create table customer (
  id bigint not null primary key,
  nombre           varchar(255) not null,
  apellido_paterno varchar(255) not null,
)
go