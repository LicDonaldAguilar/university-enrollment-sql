--PROYECTO FINAL DEL MODULO
--Manejo de Bases de Datos con SQL Server
--Sistema de matricula universitaria

--Creación de la base de datos.
CREATE DATABASE db_matricula_universitaria;
go
--Usar la base de datos
USE db_matricula_universitaria;
go
--Creación de tabla Carrera
CREATE TABLE carrera (
    id_carrera VARCHAR(10) NOT NULL PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL UNIQUE,
    grado_academico VARCHAR(30),
    duracion_cuatrimestres INT,
    costo_credito DECIMAL(10,2) NOT NULL CHECK (costo_credito > 0),
    activa BIT NOT NULL DEFAULT (1)
);
go
--Creación de tabla Profesor
CREATE TABLE profesor (
    id_profesor VARCHAR(10) NOT NULL PRIMARY KEY,
    cedula INT NOT NULL UNIQUE,
    nombre VARCHAR(60) NOT NULL,
    apellido1 VARCHAR(60) NOT NULL,
    apellido2 VARCHAR(60),
    correo TEXT,
    telefono VARCHAR (20) NOT NULL,
    activo BIT NOT NULL DEFAULT (1)
);
go
--Cración tabla Estudiante
CREATE TABLE estudiante (
    id_estudiante VARCHAR(10) NOT NULL PRIMARY KEY,
    cedula INT NOT NULL UNIQUE,
    nombre VARCHAR(60) NOT NULL,
    apellido1 VARCHAR(60) NOT NULL,
    apellido2 VARCHAR(60),
    fecha_nacimiento DATE NOT NULL,
    correo TEXT,
    telefono VARCHAR (20) NOT NULL,
    activo BIT NOT NULL DEFAULT (1)
);
go
--Creación de tabla Periodo
CREATE TABLE periodo (
    id_periodo VARCHAR(10) NOT NULL PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL UNIQUE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);
go
--Creación de tabla Curso
CREATE TABLE curso (
    id_curso VARCHAR(10) NOT NULL PRIMARY KEY,
    codigo VARCHAR(15) NOT NULL UNIQUE,
    nombre VARCHAR (60) NOT NULL UNIQUE,
    creditos INT NOT NULL CHECK (creditos > 0),
    cupo_base INT NOT NULL CHECK (cupo_base > 0),
    id_carrera VARCHAR(10) NOT NULL,
    activo BIT NOT NULL DEFAULT (1)
);
go
--Creación de tabla Grupo
CREATE TABLE grupo (
    id_grupo VARCHAR(10) NOT NULL PRIMARY KEY,
    id_curso VARCHAR(10) NOT NULL,
    id_profesor VARCHAR(10) NOT NULL,
    id_periodo VARCHAR(10) NOT NULL,
    numero_grupo INT NOT NULL,
    horario VARCHAR(20) NOT NULL CHECK (horario IN ('Mañana', 'Tarde', 'Noche')),
    aula VARCHAR(10),
    cupo_maximo INT CHECK (cupo_maximo > 0) DEFAULT (40),
    modalidad VARCHAR(20) NOT NULL CHECK (modalidad IN ('Presencial', 'Virtual', 'Hibrida'))
);
go
--Creación de tabla Matrícula
CREATE TABLE matricula (
    id_matricula INT NOT NULL PRIMARY KEY,
    id_estudiante VARCHAR(10) NOT NULL,
    id_grupo VARCHAR(10) NOT NULL,
    fecha_matricula DATE NOT NULL DEFAULT (GETDATE()),
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('Activa', 'Retirada', 'Finalizada', 'Anulada')),
    monto_total DECIMAL(12,2) NOT NULL CHECK (monto_total >= 0),
    beca_porcentaje DECIMAL(5,2) NOT NULL CHECK (beca_porcentaje BETWEEN 0 AND 100) DEFAULT (0),
    pagada BIT NOT NULL DEFAULT (0)
);
go
--Creación de tabla pago
CREATE TABLE pago (
    id_pago INT NOT NULL PRIMARY KEY,
    id_matricula INT NOT NULL,
    fecha_pago DATE NOT NULL DEFAULT (GETDATE()),
    monto DECIMAL(12,2) NOT NULL CHECK (monto > 0),
    metodo_pago VARCHAR(25) NOT NULL CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia', 'SINPE')),
    referencia TEXT,
    confirmado BIT NOT NULL DEFAULT (1)
); 
go

--Creación de los INSERT para las consultas.

INSERT INTO carrera
    (id_carrera, nombre, grado_academico, duracion_cuatrimestres, costo_credito, activa)
VALUES
    ('CAR001', 'Ciencia de Datos Aplicada', 'Maestria', 6, 48500.00, 1),
    ('CAR002', 'Administracion de Empresas', 'Bachillerato', 8, 42000.00, 1),
    ('CAR003', 'Ingenieria de Sistemas', 'Licenciatura', 12, 50000.00, 1),
    ('CAR004', 'Derecho', 'Licenciatura', 12, 45000.00, 1);
go

INSERT INTO profesor
    (id_profesor, cedula, nombre, apellido1, apellido2, correo, telefono, activo)
VALUES
    ('PROF001', 101010101, 'Laura', 'Mora', 'Sanchez', 'laura.mora@universidad.cr', '8888-1001', 1),
    ('PROF002', 102020202, 'Carlos', 'Jimenez', 'Rojas', 'carlos.jimenez@universidad.cr', '8888-1002', 1),
    ('PROF003', 203030303, 'Andrea', 'Vargas', 'Solano', 'andrea.vargas@universidad.cr', '8888-1003', 1),
    ('PROF004', 304040404, 'Miguel', 'Castro', 'Arias', 'miguel.castro@universidad.cr', '8888-1004', 1),
    ('PROF005', 105050505, 'Sofia', 'Ramirez', 'Leon', 'sofia.ramirez@universidad.cr', '8888-1005', 1),
    ('PROF006', 206060606, 'Esteban', 'Quesada', 'Mendez', NULL, '8888-1006', 1),
    ('PROF007', 307070707, 'Fernando', 'Chaves', 'Ruiz', 'fernando.chaves@universidad.cr', '8888-1007', 1),
    ('PROF008', 108080808, 'Patricia', 'Navarro', NULL, NULL, '8888-1008', 0);
go

INSERT INTO estudiante
    (id_estudiante, cedula, nombre, apellido1, apellido2, fecha_nacimiento, correo, telefono, activo)
VALUES
    ('EST001', 111111111, 'Daniel', 'Alvarado', 'Soto', '1998-03-14', 'daniel.alvarado@estudiante.cr', '8888-2001', 1),
    ('EST002', 122222222, 'Maria', 'Fernandez', 'Mora', '2000-07-22', 'maria.fernandez@estudiante.cr', '8888-2002', 1),
    ('EST003', 133333333, 'Jose', 'Rodriguez', 'Vega', '1997-11-05', NULL, '8888-2003', 1),
    ('EST004', 144444444, 'Natalia', 'Gomez', 'Araya', '2001-01-30', 'natalia.gomez@estudiante.cr', '8888-2004', 1),
    ('EST005', 155555555, 'Luis', 'Hernandez', 'Castro', '1999-09-18', 'luis.hernandez@estudiante.cr', '8888-2005', 1),
    ('EST006', 166666666, 'Valeria', 'Salazar', 'Rojas', '2002-05-12', 'valeria.salazar@estudiante.cr', '8888-2006', 1),
    ('EST007', 177777777, 'Andres', 'Quesada', 'Jimenez', '1996-12-03', NULL, '8888-2007', 1),
    ('EST008', 188888888, 'Camila', 'Vega', 'Solis', '2000-04-26', 'camila.vega@estudiante.cr', '8888-2008', 1),
    ('EST009', 199999999, 'Gabriel', 'Campos', 'Mora', '1998-08-09', 'gabriel.campos@estudiante.cr', '8888-2009', 1),
    ('EST010', 110123456, 'Paola', 'Navarro', 'Mendez', '2001-10-17', 'paola.navarro@estudiante.cr', '8888-2010', 1),
    ('EST011', 120234567, 'Ricardo', 'Sanchez', 'Vargas', '1995-06-21', 'ricardo.sanchez@estudiante.cr', '8888-2011', 1),
    ('EST012', 130345678, 'Elena', 'Mora', 'Chacon', '2002-02-11', NULL, '8888-2012', 1),
    ('EST013', 140456789, 'Marco', 'Rojas', 'Alfaro', '1997-07-07', 'marco.rojas@estudiante.cr', '8888-2013', 1),
    ('EST014', 150567890, 'Lucia', 'Solano', 'Castillo', '2000-09-29', 'lucia.solano@estudiante.cr', '8888-2014', 1),
    ('EST015', 160678901, 'Kevin', 'Araya', NULL, '1999-12-15', NULL, '8888-2015', 0);
go

INSERT INTO periodo
    (id_periodo, nombre, fecha_inicio, fecha_fin)
VALUES
    ('PER25C3', '2025-III', '2025-09-01', '2025-12-20'),
    ('PER26C1', '2026-I', '2026-01-12', '2026-04-25'),
    ('PER26C2', '2026-II', '2026-05-11', '2026-08-22'),
    ('PER26C3', '2026-III', '2026-09-07', '2026-12-19');
go

INSERT INTO curso
    (id_curso, codigo, nombre, creditos, cupo_base, id_carrera, activo)
VALUES
    ('CUR001', 'DAT-101', 'Introduccion a Ciencia de Datos', 4, 30, 'CAR001', 1),
    ('CUR002', 'DAT-202', 'SQL y Modelado de Datos', 4, 25, 'CAR001', 1),
    ('CUR003', 'DAT-303', 'Inteligencia de Negocios', 4, 24, 'CAR001', 1),
    ('CUR004', 'ADM-101', 'Fundamentos de Administracion', 3, 35, 'CAR002', 1),
    ('CUR005', 'ADM-202', 'Contabilidad de Gestion', 4, 30, 'CAR002', 1),
    ('CUR006', 'ADM-303', 'Comercio Electronico', 3, 30, 'CAR002', 1),
    ('CUR007', 'SIS-101', 'Programacion I', 4, 28, 'CAR003', 1),
    ('CUR008', 'SIS-202', 'Bases de Datos', 4, 25, 'CAR003', 1),
    ('CUR009', 'SIS-303', 'Ciberseguridad', 4, 25, 'CAR003', 1),
    ('CUR010', 'DER-101', 'Introduccion al Derecho', 3, 40, 'CAR004', 1),
    ('CUR011', 'DER-202', 'Etica y Probidad Publica', 3, 35, 'CAR004', 1),
    ('CUR012', 'DER-303', 'Derecho Administrativo', 4, 35, 'CAR004', 0);
go

INSERT INTO grupo
    (id_grupo, id_curso, id_profesor, id_periodo, numero_grupo, horario, aula, cupo_maximo, modalidad)
VALUES
    ('GRP001', 'CUR001', 'PROF001', 'PER26C1', 1, 'Noche', 'A-201', 30, 'Presencial'),
    ('GRP002', 'CUR002', 'PROF002', 'PER26C2', 1, 'Noche', 'LAB-01', 25, 'Hibrida'),
    ('GRP003', 'CUR003', 'PROF001', 'PER26C2', 1, 'Tarde', NULL, 30, 'Virtual'),
    ('GRP004', 'CUR004', 'PROF003', 'PER26C2', 1, 'Mañana', 'B-101', 35, 'Presencial'),
    ('GRP005', 'CUR005', 'PROF004', 'PER26C2', 1, 'Noche', 'B-202', 30, 'Presencial'),
    ('GRP006', 'CUR006', 'PROF003', 'PER26C2', 1, 'Tarde', NULL, 30, 'Virtual'),
    ('GRP007', 'CUR007', 'PROF005', 'PER26C3', 1, 'Mañana', 'LAB-02', 28, 'Presencial'),
    ('GRP008', 'CUR008', 'PROF002', 'PER26C3', 1, 'Noche', 'LAB-03', 25, 'Hibrida'),
    ('GRP009', 'CUR009', 'PROF006', 'PER26C3', 1, 'Noche', NULL, 25, 'Virtual'),
    ('GRP010', 'CUR010', 'PROF007', 'PER26C3', 1, 'Mañana', 'C-101', 40, 'Presencial'),
    ('GRP011', 'CUR011', 'PROF008', 'PER26C3', 1, 'Noche', 'C-201', 35, 'Hibrida'),
    ('GRP012', 'CUR012', 'PROF007', 'PER26C3', 1, 'Tarde', 'C-202', 35, 'Presencial');
go

INSERT INTO matricula
    (id_matricula, id_estudiante, id_grupo, fecha_matricula, estado, monto_total, beca_porcentaje, pagada)
VALUES
    (1, 'EST001', 'GRP001', '2026-01-05', 'Finalizada', 194000.00, 25.00, 1),
    (2, 'EST001', 'GRP002', '2026-05-04', 'Activa', 194000.00, 0.00, 0),
    (3, 'EST002', 'GRP004', '2026-05-05', 'Activa', 126000.00, 0.00, 1),
    (4, 'EST002', 'GRP005', '2026-05-05', 'Activa', 168000.00, 0.00, 1),
    (5, 'EST003', 'GRP007', '2026-07-10', 'Activa', 200000.00, 50.00, 1),
    (6, 'EST003', 'GRP008', '2026-07-10', 'Activa', 200000.00, 50.00, 0),
    (7, 'EST004', 'GRP010', '2026-07-11', 'Activa', 135000.00, 0.00, 1),
    (8, 'EST004', 'GRP011', '2026-07-11', 'Activa', 135000.00, 0.00, 0),
    (9, 'EST005', 'GRP003', '2026-05-08', 'Activa', 194000.00, 0.00, 1),
    (10, 'EST005', 'GRP006', '2026-05-08', 'Retirada', 126000.00, 0.00, 0),
    (11, 'EST006', 'GRP004', '2026-05-09', 'Activa', 126000.00, 100.00, 1),
    (12, 'EST007', 'GRP007', '2026-07-12', 'Activa', 200000.00, 0.00, 0),
    (13, 'EST008', 'GRP008', '2026-07-13', 'Activa', 200000.00, 25.00, 1),
    (14, 'EST009', 'GRP009', '2026-07-14', 'Activa', 200000.00, 0.00, 0),
    (15, 'EST010', 'GRP010', '2026-07-15', 'Activa', 135000.00, 0.00, 1),
    (16, 'EST011', 'GRP011', '2026-07-16', 'Activa', 135000.00, 15.00, 0),
    (17, 'EST012', 'GRP012', '2026-07-17', 'Activa', 180000.00, 0.00, 0),
    (18, 'EST013', 'GRP001', '2026-01-06', 'Finalizada', 194000.00, 0.00, 1),
    (19, 'EST014', 'GRP002', '2026-05-10', 'Activa', 194000.00, 30.00, 0),
    (20, 'EST015', 'GRP003', '2026-05-10', 'Retirada', 194000.00, 0.00, 0),
    (21, 'EST006', 'GRP005', '2026-05-09', 'Activa', 168000.00, 100.00, 1),
    (22, 'EST007', 'GRP006', '2026-05-11', 'Activa', 126000.00, 0.00, 0),
    (23, 'EST008', 'GRP009', '2026-07-13', 'Activa', 200000.00, 25.00, 0),
    (24, 'EST009', 'GRP012', '2026-07-14', 'Anulada', 180000.00, 0.00, 0);
go

INSERT INTO pago
    (id_pago, id_matricula, fecha_pago, monto, metodo_pago, referencia, confirmado)
VALUES
    (1, 1, '2026-01-05', 145500.00, 'Transferencia', 'BN-001-2026', 1),
    (2, 2, '2026-05-04', 100000.00, 'SINPE', 'SN-002-2026', 1),
    (3, 3, '2026-05-05', 126000.00, 'Tarjeta', 'TRJ-003-2026', 1),
    (4, 4, '2026-05-05', 168000.00, 'Transferencia', 'BAC-004-2026', 1),
    (5, 5, '2026-07-10', 100000.00, 'SINPE', 'SN-005-2026', 1),
    (6, 7, '2026-07-11', 135000.00, 'Tarjeta', 'TRJ-007-2026', 1),
    (7, 9, '2026-05-08', 100000.00, 'Efectivo', NULL, 1),
    (8, 9, '2026-05-15', 94000.00, 'SINPE', 'SN-009-2026', 1),
    (9, 13, '2026-07-13', 75000.00, 'SINPE', 'SN-013A-2026', 1),
    (10, 13, '2026-07-20', 75000.00, 'SINPE', 'SN-013B-2026', 1),
    (11, 15, '2026-07-15', 135000.00, 'Transferencia', 'BN-015-2026', 1),
    (12, 18, '2026-01-06', 194000.00, 'Tarjeta', 'TRJ-018-2026', 1),
    (13, 19, '2026-05-10', 50000.00, 'Efectivo', NULL, 1),
    (14, 8, '2026-07-11', 50000.00, 'SINPE', 'SN-008-2026', 1),
    (15, 16, '2026-07-16', 40000.00, 'Transferencia', 'BP-016-2026', 1),
    (16, 17, '2026-07-17', 80000.00, 'Tarjeta', 'TRJ-017-2026', 1),
    (17, 20, '2026-05-10', 60000.00, 'Efectivo', NULL, 1),
    (18, 22, '2026-05-11', 50000.00, 'SINPE', 'SN-022-2026', 1),
    (19, 23, '2026-07-13', 50000.00, 'Transferencia', 'BAC-023-2026', 1),
    (20, 12, '2026-07-12', 80000.00, 'Tarjeta', 'PEND-012-2026', 0);
go

--CONSULTAS--
-------------
--Mostrar todos los estudiantes y ordenarlos por apellidos y nombre.
SELECT *
FROM estudiante
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
go

--Mostrar los cursos de cuatro creditos.
SELECT id_curso, codigo, nombre, creditos
FROM curso
WHERE creditos = 4;
go

--Mostrar las modalidades sin repetir.
SELECT DISTINCT modalidad
FROM grupo;
go

--Cinco matriculas con mayor monto.
SELECT TOP (5)
    id_matricula, id_estudiante, monto_total
FROM matricula
ORDER BY monto_total DESC;
go

--Cursos relacionados con datos.
SELECT codigo, nombre
FROM curso
WHERE nombre LIKE '%Datos%';
go

--Matriculas registradas durante julio de 2026.
SELECT id_matricula, id_estudiante, fecha_matricula
FROM matricula
WHERE fecha_matricula BETWEEN '2026-07-01' AND '2026-07-31'
ORDER BY fecha_matricula;
go

--Matriculas activas o finalizadas.
SELECT id_matricula, id_estudiante, estado
FROM matricula
WHERE estado IN ('Activa', 'Finalizada');
go

--Excluir matriculas retiradas y anuladas.
SELECT id_matricula, estado
FROM matricula
WHERE NOT (estado IN ('Retirada', 'Anulada'));
go

--Profesores sin correo registrado.
SELECT id_profesor, nombre, apellido1
FROM profesor
WHERE correo IS NULL;
go

--Grupos que tienen aula asignada.
SELECT id_grupo, horario, aula, modalidad
FROM grupo
WHERE aula IS NOT NULL;
go

--Grupos virtuales o hibridos.
SELECT id_grupo, modalidad, horario
FROM grupo
WHERE modalidad = 'Virtual' OR modalidad = 'Hibrida';
go

--Cantidad de cursos por carrera.
SELECT
    id_carrera,
    COUNT(*) AS cantidad_cursos
FROM curso
GROUP BY id_carrera;
go

--Carreras con tres o mas cursos.
SELECT
    id_carrera,
    COUNT(*) AS cantidad_cursos
FROM curso
GROUP BY id_carrera
HAVING COUNT(*) >= 3;
go

--Cantidad total de estudiantes activos.
SELECT COUNT(*) AS total_estudiantes_activos
FROM estudiante
WHERE activo = 1;
go

--Total de pagos confirmados.
SELECT SUM(monto) AS total_pagos_confirmados
FROM pago
WHERE confirmado = 1;
go

--Promedio del monto de las matriculas.
SELECT AVG(monto_total) AS promedio_matriculas
FROM matricula;
go

--Menor monto de matricula.
SELECT MIN(monto_total) AS matricula_minima
FROM matricula;
go

--Mayor monto de matricula.
SELECT MAX(monto_total) AS matricula_maxima
FROM matricula;
go

--Detalle de estudiante, matricula y curso.
SELECT
    m.id_matricula,
    CONCAT(e.nombre, ' ', e.apellido1) AS estudiante,
    c.codigo,
    c.nombre AS curso,
    m.estado
FROM matricula AS m
INNER JOIN estudiante AS e ON m.id_estudiante = e.id_estudiante
INNER JOIN grupo AS g ON m.id_grupo = g.id_grupo
INNER JOIN curso AS c ON g.id_curso = c.id_curso
ORDER BY m.id_matricula;
go

--Todas las matriculas, incluso las que no tienen pagos.
SELECT
    m.id_matricula,
    m.id_estudiante,
    p.id_pago,
    p.monto,
    p.confirmado
FROM matricula AS m
LEFT JOIN pago AS p ON m.id_matricula = p.id_matricula
ORDER BY m.id_matricula, p.id_pago;
go

--Todos los grupos, tengan o no matriculas.
SELECT
    m.id_matricula,
    g.id_grupo,
    g.numero_grupo,
    g.modalidad
FROM matricula AS m
RIGHT JOIN grupo AS g ON m.id_grupo = g.id_grupo
ORDER BY g.id_grupo;
go

--Matriculas superiores al promedio.
SELECT id_matricula, id_estudiante, monto_total
FROM matricula
WHERE monto_total >
(
    SELECT AVG(monto_total)
    FROM matricula
);
go

--Estudiantes que poseen una matricula activa.
SELECT id_estudiante, nombre, apellido1
FROM estudiante
WHERE id_estudiante IN
(
    SELECT id_estudiante
    FROM matricula
    WHERE estado = 'Activa'
);
go

---Creación de vistas---
CREATE VIEW matriculas_mayor_monto
AS
    SELECT TOP (5)
    id_matricula, id_estudiante, monto_total
    FROM matricula
    ORDER BY monto_total DESC;
go

CREATE VIEW ordenar_estudiantes
AS
    SELECT apellido1, apellido2, nombre
    FROM estudiante
    GROUP BY apellido1, apellido2, nombre;
go

CREATE VIEW matr_activas_finalizadas
AS
    SELECT id_matricula, id_estudiante, estado
    FROM matricula
    WHERE estado IN ('Activa', 'Finalizada');
go

CREATE VIEW profesores_sin_correo
AS
    SELECT id_profesor, nombre, apellido1
    FROM profesor
    WHERE correo IS NULL;
go

CREATE VIEW virtuales_hibridos
AS
    SELECT id_grupo, modalidad, horario
    FROM grupo
    WHERE modalidad = 'Virtual'
       OR modalidad = 'Hibrida';
go

CREATE VIEW estudiantes_activos
AS
    SELECT COUNT(*) AS total_estudiantes_activos
    FROM estudiante
    WHERE activo = 1;
go

--Consultas de las vistas--
SELECT * FROM matriculas_mayor_monto;
go
SELECT * FROM ordenar_estudiantes;
go
SELECT * FROM matr_activas_finalizadas;
go
SELECT * FROM profesores_sin_correo;
go
SELECT * FROM virtuales_hibridos;
go
SELECT * FROM estudiantes_activos;
go