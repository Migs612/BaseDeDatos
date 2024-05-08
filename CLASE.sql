Informatizar las notas en los diferentes modulos;

CREATE DATABASE RAYOFP CHARACTER SET utf8mb4;
USE RAYOFP;

CREATE TABLE PROFESORES (
ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
NOMBRE VARCHAR(20) NOT NULL,
APELLIDO1 VARCHAR(20),
APELLIDO2 VARCHAR(20)
);

INSERT INTO PROFESORES VALUES(1,'RAYO','','');
INSERT INTO PROFESORES VALUES(2,'ALICIA','','');
INSERT INTO PROFESORES VALUES(3,'GABRIEL','','');
INSERT INTO PROFESORES VALUES(4,'Rey','Perez','Juan');

SELECT * FROM PROFESORES;

UPDATE PROFESORES SET NOMBRE='Jose Manuel' WHERE ID =1;
UPDATE PROFESORES SET APELLIDO1 ='Rayo' WHERE ID = 1;
UPDATE PROFESORES SET APELLIDO2='Ortigüela' WHERE ID = 1;

UPDATE PROFESORES SET APELLIDO1 ='Rey' WHERE ID = 3;
UPDATE PROFESORES SET APELLIDO2='Perez' WHERE ID = 3;

ALTER TABLE PROFESORES ADD EDAD INT;

UPDATE PROFESORES SET EDAD=24 WHERE ID=2;
UPDATE PROFESORES SET EDAD=35 WHERE EDAD IS NULL;

CREATE TABLE ALUMNOS (
DNI_NIE VARCHAR(15) PRIMARY KEY,
NOMBRE VARCHAR(20) NOT NULL,
APELLIDO1 VARCHAR(20),
APELLIDO2 VARCHAR(20),
TELEFONO VARCHAR(12),
EMAIL VARCHAR(30)
);

CREATE TABLE CICLOS_FORMATIVOS(
MODULO VARCHAR(5) PRIMARY KEY,
DENOMINACION 
);