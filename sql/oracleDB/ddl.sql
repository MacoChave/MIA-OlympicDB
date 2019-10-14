/* ************************************************************************
 * [0] PREPARAR BASE DE DATOS
 * ************************************************************************
 * CREAR BASE DE DATOS OLYMPIC_DB CON ENCODING UTF-8
 * USAR LA BASE DE DATOS PARA OPERACIONES DDL Y DML
 * ************************************************************************/
CREATE DATABASE OLYMPIC_DB
    WITH ENCODING = 'UTF8';

/* ************************************************************************
 * [1] CREAR TABLAS
 * ************************************************************************
 * PLANTILLAS UTILIZADAS PARA LA SECCIÓN DE CREACIÓN DE PLANTILLAS
 * 
 * PLANTILLA UTILIZADA PARA CREAR TABLAS:
 * CREATE TABLE NOMBRE_TABLA (
     COLUMNA TIPO, [COLUMNA_N TIPO]
 * );
 * 
 * PARA MODIFICAR UNA TABLA EXISTENTE:
 * ALTER TABLE NOMBRE_TABLA --MODIFICACION A REALIZAR--
 * 
 * PARA AGREGAR UNA RESTRICCION NULL | NOT NULL A UNA COLUMNA: 
 * ALTER COLUMN columna SET [NOT NULL | NULL]
 * 
 * PARA AGREGAR UNA RESTRICCIÓN DE LLAVE PRIMARIA A UNA COLUMNA:
 * ADD CONSTRAINT PK_TABLA_columna PRIMARY KEY (columna);
 * 
 * PARA AGREGAR UNA RESTRICCIÓN DE CAMPO ÚNICO A UNA COLUMNA:
 * ADD CONSTRAINT UK_TABLA_columna UNIQUE (columna);
 * 
 * PARA AGREGAR UNA RESTRICCIÓN DE LLAVE FORÁNEA A UNA COLUMNA:
 * ADD CONSTRAINT FK_TABLA_columna FOREIGN KEY (columna) REFERENCE TABLA_REF(columna_ref);
 *
 * SECUENCIAS Y TRIGGER PARA LOS CAMPOS AUTOINCREMENTABLES
 * PLANILLA DE LAS SECUENCIAS:
 * CREATE SEQUENCE nombre_secuencia
 *  INCREMENT BY 1
 *  MINVALUE 1
 NOMAXVALUE
 *  START WITH 1
 NOCYCLE;
 * AS INT: PORQUE LOS CAMPOS AUTOINCREMENTABLES A APLICARSE, SERÁN DE TIPO INT
 * INCREMENT BY 1: PORQUE SE INCREMENTARA 1 CADA VEZ
 * MINVALUE 1: PORQUE EMPEZARÁ CON UN VALOR MÍNIMO DE 1
 NOMAXVALUE
 * START WITH 1: PORQUE EMPEZARÁ CON 1
 NOCYCLE;
 *
 * PLANTILLA PARA LOS TRIGGERS:
 * PRIMERO SE HARÁ UNA FUNCIÓN QUE LLAMARÁ EL TRIGGER
 * CREATE OR REPLACE FUNCTION TRG_FUN_tabla()
 *    RETURNS trigger AS 
 * $BODY$
 * BEGIN 
 *    NEW.cod_prof = NEXTVAL('SEQ_tabla');
 *    RETURN NEW;
 * END;
 * $BODY$
 * LANGUAGE 'plpgsql' VOLATILE;
 *
 * CREATE TRIGGER TRG_tabla
 * BEFORE INSERT 
 *    ON tabla
 *    FOR EACH ROW 
 *        EXECUTE PROCEDURE TRG_FUN_tabla();
 * ************************************************************************/
/* *************************************************************
 * TABLA PROFESION                                             *
 * *************************************************************/
CREATE TABLE PROFESION (
    cod_prof INT,
    nombre VARCHAR2(50)
);
ALTER TABLE PROFESION
    MODIFY (
        cod_prof NOT NULL, 
        nombre NOT NULL
    );
ALTER TABLE PROFESION
    ADD CONSTRAINT PK_PROFESION PRIMARY KEY (cod_prof);
ALTER TABLE PROFESION
    ADD CONSTRAINT UK_PROFESION_nombre UNIQUE (nombre);

CREATE SEQUENCE SEQ_PROFESION
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_PROFESION
    BEFORE INSERT ON PROFESION
    FOR EACH ROW
BEGIN 
    SELECT SEQ_PROFESION.NEXTVAL
    INTO :new.cod_prof
    FROM dual;
END;

/* *************************************************************
 * TABLA PAIS                                                  *
 * *************************************************************/
CREATE TABLE PAIS (
    cod_pais INT,
    nombre VARCHAR2(50)
);
ALTER TABLE PAIS 
    MODIFY (
        cod_pais NOT NULL, 
        nombre NOT NULL
    );
ALTER TABLE PAIS 
    ADD CONSTRAINT PK_PAIS PRIMARY KEY (cod_pais);
ALTER TABLE PAIS 
    ADD CONSTRAINT UK_PAIS_nombre UNIQUE (nombre);

CREATE SEQUENCE SEQ_PAIS
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_PAIS
    BEFORE INSERT ON PAIS
    FOR EACH ROW
BEGIN 
    SELECT SEQ_PAIS.NEXTVAL
    INTO :new.cod_pais
    FROM dual;
END;

/* *************************************************************
 * TABLA PUESTO                                                *
 * *************************************************************/
CREATE TABLE PUESTO (
    cod_puesto INT,
    nombre VARCHAR2(50)
);
ALTER TABLE PUESTO 
    MODIFY (
        cod_puesto NOT NULL, 
        nombre NOT NULL
    );
ALTER TABLE PUESTO 
    ADD CONSTRAINT PK_PUESTO PRIMARY KEY (cod_puesto);
ALTER TABLE PUESTO 
    ADD CONSTRAINT UK_PUESTO_nombre UNIQUE (nombre);

CREATE SEQUENCE SEQ_PUESTO
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_PUESTO
    BEFORE INSERT ON PUESTO
    FOR EACH ROW
BEGIN 
    SELECT SEQ_PUESTO.NEXTVAL
    INTO :new.cod_puesto
    FROM dual;
END;

/* *************************************************************
 * TABLA DEPARTAMENTO                                          *
 * *************************************************************/
CREATE TABLE DEPARTAMENTO (
    cod_depto INT,
    nombre VARCHAR2(50)
);
ALTER TABLE DEPARTAMENTO 
    MODIFY (
        cod_depto NOT NULL, 
        nombre NOT NULL
    );
ALTER TABLE DEPARTAMENTO 
    ADD CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (cod_depto);
ALTER TABLE DEPARTAMENTO 
    ADD CONSTRAINT UK_DEPTO_nombre UNIQUE (nombre);

CREATE SEQUENCE SEQ_DEPARTAMENTO
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_DEPARTAMENTO
    BEFORE INSERT ON DEPARTAMENTO
    FOR EACH ROW
BEGIN 
    SELECT SEQ_DEPARTAMENTO.NEXTVAL
    INTO :new.cod_depto
    FROM dual;
END;

/* *************************************************************
 * TABLA MIEMBRO                                               *
 * *************************************************************/
CREATE TABLE MIEMBRO (
    cod_miembro INT,
    nombre VARCHAR2(100),
    apellido VARCHAR2(100),
    edad INT,
    telefono INT,
    residencia VARCHAR2(100),
    PAIS_cod_pais INT,
    PROFESION_cod_prof INT
);
ALTER TABLE MIEMBRO
    MODIFY (
        cod_miembro NOT NULL, 
        nombre NOT NULL, 
        apellido NOT NULL, 
        edad NOT NULL, 
        PAIS_cod_pais NOT NULL, 
        PROFESION_cod_prof NOT NULL
    );
ALTER TABLE MIEMBRO
    ADD CONSTRAINT PK_MIEMBRO PRIMARY KEY (cod_miembro);
ALTER TABLE MIEMBRO
    ADD CONSTRAINT FK_MIEMBRO_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais) 
        ON DELETE CASCADE;
ALTER TABLE MIEMBRO
    ADD CONSTRAINT FK_MIEMBRO_cod_profesion FOREIGN KEY (PROFESION_cod_prof) REFERENCES PROFESION(cod_prof) 
        ON DELETE CASCADE;

CREATE SEQUENCE SEQ_MIEMBRO
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_MIEMBRO
    BEFORE INSERT ON MIEMBRO
    FOR EACH ROW
BEGIN 
    SELECT SEQ_MIEMBRO.NEXTVAL
    INTO :new.cod_miembro
    FROM dual;
END;

/* *************************************************************
 * TABLA PUESTO_MIEMBRO                                        *
 * *************************************************************/
CREATE TABLE PUESTO_MIEMBRO (
    MIEMBRO_cod_miembro INT NOT NULL,
    PUESTO_cod_puesto INT NOT NULL,
    DEPARTAMENTO_cod_depto INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);
ALTER TABLE PUESTO_MIEMBRO 
    MODIFY (
        MIEMBRO_cod_miembro NOT NULL, 
        PUESTO_cod_puesto NOT NULL,
        DEPARTAMENTO_cod_depto NOT NULL,
        fecha_inicio NOT NULL
    );
ALTER TABLE PUESTO_MIEMBRO 
    ADD CONSTRAINT PK_PUESTO_MIEMBRO PRIMARY KEY (MIEMBRO_cod_miembro, PUESTO_cod_puesto, DEPARTAMENTO_cod_depto);
ALTER TABLE PUESTO_MIEMBRO 
    ADD CONSTRAINT FK_PUESTO_MIEMBRO_cod_miembro FOREIGN KEY (MIEMBRO_cod_miembro) REFERENCES MIEMBRO(cod_miembro)
        ON DELETE CASCADE; 
ALTER TABLE PUESTO_MIEMBRO 
    ADD CONSTRAINT FK_PUESTO_MIEMBRO_cod_puesto FOREIGN KEY (PUESTO_cod_puesto) REFERENCES PUESTO(cod_puesto)
        ON DELETE CASCADE;
ALTER TABLE PUESTO_MIEMBRO 
    ADD CONSTRAINT fk_PUESTO_MIEMBRO_cod_depto FOREIGN KEY (DEPARTAMENTO_cod_depto) REFERENCES DEPARTAMENTO(cod_depto)
        ON DELETE CASCADE;

/* *************************************************************
 * TABLA TIPO_MEDALLA                                          *
 * *************************************************************/
CREATE TABLE TIPO_MEDALLA (
    cod_tipo INT NOT NULL,
    medalla VARCHAR2(20) NOT NULL
);
ALTER TABLE TIPO_MEDALLA 
    MODIFY (
        cod_tipo NOT NULL, 
        medalla NOT NULL
    );
ALTER TABLE TIPO_MEDALLA 
    ADD CONSTRAINT PK_TIPO_MEDALLA_cod_tipo PRIMARY KEY (cod_tipo);
ALTER TABLE TIPO_MEDALLA 
    ADD CONSTRAINT UK_TIPO_MEDALLA_medalla UNIQUE (medalla);

CREATE SEQUENCE SEQ_TIPO_MEDALLA
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_TIPO_MEDALLA
    BEFORE INSERT ON TIPO_MEDALLA
    FOR EACH ROW
BEGIN 
    SELECT SEQ_TIPO_MEDALLA.NEXTVAL
    INTO :new.cod_tipo
    FROM dual;
END;

/* *************************************************************
 * TABLA MEDALLERO                                             *
 * *************************************************************/
CREATE TABLE MEDALLERO (
    PAIS_cod_pais INT,
    cantidad_medallas INT,
    TIPO_MEDALLA_cod_tipo INT
);
ALTER TABLE MEDALLERO 
    MODIFY (
        PAIS_cod_pais NOT NULL,
        cantidad_medallas NOT NULL,
        TIPO_MEDALLA_cod_tipo NOT NULL
    );
ALTER TABLE MEDALLERO 
    ADD CONSTRAINT PK_MEDALLERO PRIMARY KEY (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo);
ALTER TABLE MEDALLERO
    ADD CONSTRAINT FK_MEDALLERO_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais)
        ON DELETE CASCADE;
ALTER TABLE MEDALLERO 
    ADD CONSTRAINT FK_MEDALLERO_cod_tipo FOREIGN KEY (TIPO_MEDALLA_cod_tipo) REFERENCES TIPO_MEDALLA(cod_tipo)
        ON DELETE CASCADE;

/* *************************************************************
 * TABLA DISCIPLINA                                            *
 * *************************************************************/
CREATE TABLE DISCIPLINA (
    cod_disciplina INT,
    nombre VARCHAR2(50),
    descripcion VARCHAR2(150)
);
ALTER TABLE DISCIPLINA 
    MODIFY (
        cod_disciplina NOT NULL, 
        nombre NOT NULL
    );
ALTER TABLE DISCIPLINA 
    ADD CONSTRAINT PK_DISCIPLINA PRIMARY KEY (cod_disciplina);

CREATE SEQUENCE SEQ_DISCIPLINA
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_DISCIPLINA
    BEFORE INSERT ON DISCIPLINA
    FOR EACH ROW
BEGIN 
    SELECT SEQ_DISCIPLINA.NEXTVAL
    INTO :new.cod_disciplina
    FROM dual;
END;

/* *************************************************************
 * TABLA ATLETA                                                *
 * *************************************************************/
CREATE TABLE ATLETA (
    cod_atleta INT,
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    edad INT,
    participaciones VARCHAR2(100),
    DISCIPLINA_cod_discip INT,
    PAIS_cod_pais INT
);
ALTER TABLE ATLETA 
    MODIFY (
        cod_atleta NOT NULL, 
        nombre NOT NULL, 
        apellido NOT NULL, 
        edad NOT NULL, 
        participaciones NOT NULL, 
        DISCIPLINA_cod_discip NOT NULL, 
        PAIS_cod_pais NOT NULL
    );
ALTER TABLE ATLETA 
    ADD CONSTRAINT PK_ATLETA PRIMARY KEY (cod_atleta);
ALTER TABLE ATLETA 
    ADD CONSTRAINT FK_ATLETA_cod_disciplina FOREIGN KEY (DISCIPLINA_cod_discip) REFERENCES DISCIPLINA(cod_disciplina)
        ON DELETE CASCADE;
ALTER TABLE ATLETA 
    ADD CONSTRAINT FK_ATLETA_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais)
        ON DELETE CASCADE;

CREATE SEQUENCE SEQ_ATLETA
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_ATLETA
    BEFORE INSERT ON ATLETA
    FOR EACH ROW
BEGIN 
    SELECT SEQ_ATLETA.NEXTVAL
    INTO :new.cod_atleta
    FROM dual;
END;

/* *************************************************************
 * TABLA CATEGORIA                                             *
 * *************************************************************/
CREATE TABLE CATEGORIA (
    cod_categoria INT,
    categoria VARCHAR2(50)
);
ALTER TABLE CATEGORIA 
    MODIFY (
        cod_categoria NOT NULL, 
        categoria NOT NULL
    );
ALTER TABLE CATEGORIA 
    ADD CONSTRAINT PK_CATEGORIA PRIMARY KEY (cod_categoria);

CREATE SEQUENCE SEQ_CATEGORIA
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_CATEGORIA
    BEFORE INSERT ON CATEGORIA
    FOR EACH ROW
BEGIN 
    SELECT SEQ_CATEGORIA.NEXTVAL
    INTO :new.cod_categoria
    FROM dual;
END;

/* *************************************************************
 * TABLA TIPO_PARTICIPACION                                    *
 * *************************************************************/
CREATE TABLE TIPO_PARTICIPACION (
    cod_participacion INT,
    tipo_participacion VARCHAR2(100)
);
ALTER TABLE TIPO_PARTICIPACION 
    MODIFY (
        cod_participacion NOT NULL, 
        tipo_participacion NOT NULL
    );
ALTER TABLE TIPO_PARTICIPACION 
    ADD CONSTRAINT PK_TIPO_PARTICIPACION PRIMARY KEY (cod_participacion);

CREATE SEQUENCE SEQ_TIPO_PARTICIPACION
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_TIPO_PARTICIPACION
    BEFORE INSERT ON TIPO_PARTICIPACION
    FOR EACH ROW
BEGIN 
    SELECT SEQ_TIPO_PARTICIPACION.NEXTVAL
    INTO :new.cod_participacion
    FROM dual;
END;

/* *************************************************************
 * TABLA EVENTO                                                *
 * *************************************************************/
CREATE TABLE EVENTO (
    cod_evento INT,
    fecha DATE,
    ubicacion VARCHAR2(50),
    hora DATE,
    DISCIPLINA_cod_discip INT,
    TIPO_PARTICIPACION_cod_part INT,
    CATEGORIA_cod_categoria INT
);
ALTER TABLE EVENTO 
    MODIFY (
        cod_evento NOT NULL, 
        fecha NOT NULL, 
        ubicacion NOT NULL, 
        hora NOT NULL, 
        DISCIPLINA_cod_discip NOT NULL, 
        TIPO_PARTICIPACION_cod_part NOT NULL, 
        CATEGORIA_cod_categoria NOT NULL
    );
ALTER TABLE EVENTO 
    ADD CONSTRAINT PK_EVENTO PRIMARY KEY (cod_evento);
ALTER TABLE EVENTO 
    ADD CONSTRAINT FK_EVENTO_cod_disciplina FOREIGN KEY (DISCIPLINA_cod_discip) REFERENCES DISCIPLINA(cod_disciplina)
        ON DELETE CASCADE;
ALTER TABLE EVENTO 
    ADD CONSTRAINT FK_EVENTO_cod_participacion FOREIGN KEY (TIPO_PARTICIPACION_cod_part) REFERENCES TIPO_PARTICIPACION(cod_participacion)
        ON DELETE CASCADE;
ALTER TABLE EVENTO 
    ADD CONSTRAINT FK_EVENTO_cod_categoria FOREIGN KEY (CATEGORIA_cod_categoria) REFERENCES CATEGORIA(cod_categoria)
        ON DELETE CASCADE;

CREATE SEQUENCE SEQ_EVENTO
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_EVENTO
    BEFORE INSERT ON EVENTO
    FOR EACH ROW
BEGIN 
    SELECT SEQ_EVENTO.NEXTVAL
    INTO :new.cod_evento
    FROM dual;
END;

/* *************************************************************
 * TABLA EVENTO_ATLETA                                         *
 * *************************************************************/
CREATE TABLE EVENTO_ATLETA (
    ATLETA_cod_atleta INT,
    EVENTO_cod_evento INT
);
ALTER TABLE EVENTO_ATLETA 
    MODIFY (
        ATLETA_cod_atleta NOT NULL, 
        EVENTO_cod_evento NOT NULL
    );
ALTER TABLE EVENTO_ATLETA 
    ADD CONSTRAINT PK_EVENTO_ATLETA PRIMARY KEY (ATLETA_cod_atleta, EVENTO_cod_evento);
ALTER TABLE EVENTO_ATLETA 
    ADD CONSTRAINT FK_EVENTO_ATLETA_cod_atleta FOREIGN KEY (ATLETA_cod_atleta) REFERENCES ATLETA(cod_atleta)
        ON DELETE CASCADE;
ALTER TABLE EVENTO_ATLETA 
    ADD CONSTRAINT FK_EVENTO_ATLETA_cod_evento FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO(cod_evento)
        ON DELETE CASCADE;

/* *************************************************************
 * TABLA TELEVISORA                                            *
 * *************************************************************/
CREATE TABLE TELEVISORA (
    cod_televisora INT,
    nombre VARCHAR2(50)
);
ALTER TABLE TELEVISORA 
    MODIFY (
        cod_televisora NOT NULL, 
        nombre NOT NULL
    );
ALTER TABLE TELEVISORA 
    ADD CONSTRAINT PK_TELEVISORA PRIMARY KEY (cod_televisora);

CREATE SEQUENCE SEQ_TELEVISORA
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_TELEVISORA
    BEFORE INSERT ON TELEVISORA
    FOR EACH ROW
BEGIN 
    SELECT SEQ_TELEVISORA.NEXTVAL
    INTO :new.cod_televisora
    FROM dual;
END;

/* *************************************************************
 * TABLA COSTO_EVENTO                                          *
 * *************************************************************/
CREATE TABLE COSTO_EVENTO (
    EVENTO_cod_evento INT,
    TELEVISORA_cod_televisora INT,
    tarifa NUMERIC
);
ALTER TABLE COSTO_EVENTO 
    MODIFY (
        EVENTO_cod_evento NOT NULL, 
        TELEVISORA_cod_televisora NOT NULL, 
        tarifa NOT NULL
    );
ALTER TABLE COSTO_EVENTO 
    ADD CONSTRAINT PK_COSTO_EVENTO PRIMARY KEY (EVENTO_cod_evento, TELEVISORA_cod_televisora);
ALTER TABLE COSTO_EVENTO 
    ADD CONSTRAINT FK_COSTO_EVENTO_cod_evento FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO(cod_evento)
        ON DELETE CASCADE;
ALTER TABLE COSTO_EVENTO 
    ADD CONSTRAINT FK_COSTO_EVENTO_cod_televisora FOREIGN KEY (TELEVISORA_cod_televisora) REFERENCES TELEVISORA(cod_televisora)
        ON DELETE CASCADE;

/* ************************************************************************
 * [2] UNIR FECHA Y HORA DE TABLA EVENTO
 * ************************************************************************
 * SE ELIMINAN LAS COLUMNAS fecha Y hora DE TABLA EVENTO
 * SE AGREGA COLUMNA fecha CON FOMMATO TIMESTAMP PARA FECHA Y HORA
 * *************************************************************************/
ALTER TABLE EVENTO 
    DROP COLUMN fecha;
ALTER TABLE EVENTO 
    DROP COLUMN hora;
ALTER TABLE EVENTO 
    ADD fecha_hora TIMESTAMP NOT NULL;

/* ************************************************************************
 * [3] VALIDAR RANGO DE FECHA EN TABLA EVENTO
 * ************************************************************************
 * CREAR PROCEDIMIENTO ALMACENADO PARA VALIDAR EVENTOS EN EL RANGO PEDIDO
 * PLANTILLA USADO PARA EL PROCEDIMIENTO ALMACENADO:
 * CREATE OR REPLACE PROCEDURE nombre_procedimiento (
 *  lista_parametros
 * )
 * LANGUAGE nombre_lenguaje
 * AS $$
 *  cuerpo_procedimiento_almacenado;
 * $$
 *
 * nombre_procedimiento: ESPECIFICAR EL NOMBRE DEL PROCEDIMIENTO.
 * lista_parametros: DEFINIR LOS PARAMETROS UTILIZADOS POR EL PROCEDIMIENTO
 *      TIENEN LA ESTRUCTURA COMO SI CREAR UNA TABLA SE TRATASE.
 * nombre_lenguaje: ESPECIFICAR EL LENGUAJE DENTRO DEL PROCEDIMIENTO. PUEDE SER:
        PLpgSQL O SQL.
 * cuerpo_procedimiento_almacenado: LO QUE HARÁ EL PROCEDIMIENTO ALMACEANDO
 *
 * IF PARA VALIDAR QUE LA FECHA SE ENCUENTRE DENTRO DEL RANGO SOLICITADO:
 * IF (in_fecha >= TIMESTAMP '2020-07-24 09:00:00' && in_fecha <= TIMESTAMP '2020-08-09 20:00:00' ) THEN
 *  sentencia_insert
 * END IF
 *
 * in_fecha >= TIMESTAMP '2020-07-24 09:00:00':
 * in_fecha ES EL CAMPO A COMPARAR
 * TIMESTAMP COMPARA EN FORMATO TIMESTAMP LO SOLICIDADO DENTRO DE LAS COMILLAS SIMPLES
 * ************************************************************************/
CREATE OR REPLACE PROCEDURE SP_InsertEventos (
    in_fecha_hora IN TIMESTAMP,
    in_ubicacion IN VARCHAR2,
    in_cod_disciplina IN INT,
    in_cod_participacion IN INT,
    in_cod_categoria IN INT
)
IS
BEGIN
    IF (in_fecha >= TIMESTAMP '2020-07-24 09:00:00' AND in_fecha <= TIMESTAMP '2020-08-09 20:00:00') THEN
        INSERT INTO 
            EVENTO(
                fecha_hora, 
                ubicacion, 
                DISCIPLINA_cod_discip, 
                TIPO_PARTICIPACION_cod_part, 
                CATEGORIA_cod_categoria
            )
        VALUES (
            in_fecha_hora, 
            in_ubicacion, 
            in_cod_disciplina, 
            in_cod_participacion, 
            in_cod_categoria
        );
    END IF;
END SP_InsertEventos;

/* ************************************************************************
 * [4] TABLA SEDE PARA REGISTRAR UBICACIONES
 * ************************************************************************
 * CREAR TABLA SEDE
 * CAMBIAR TIPO DE DATO EN COLUMNA UBICACION A INT
 * REFERENCIAR DICHA COLUMNA A TABLA SEDE
 * *************************************************************************/
CREATE TABLE SEDE (
    cod_sede INT,
    sede VARCHAR2(50)
);
ALTER TABLE SEDE 
    MODIFY (
        cod_sede NOT NULL, 
        sede NOT NULL
    );
ALTER TABLE SEDE 
    ADD CONSTRAINT PK_SEDE PRIMARY KEY (cod_sede);

ALTER TABLE EVENTO 
    MODIFY (ubicacion INT);
ALTER TABLE EVENTO 
    ADD CONSTRAINT FK_EVENTO_ubicacion FOREIGN KEY (ubicacion) REFERENCES SEDE(cod_sede);

CREATE SEQUENCE SEQ_SEDE
    INCREMENT BY 1
    MINVALUE 1
    NOMAXVALUE
    START WITH 1
    NOCYCLE;

CREATE TRIGGER TRG_SEDE
    BEFORE INSERT ON SEDE
    FOR EACH ROW
BEGIN 
    SELECT SEQ_SEDE.NEXTVAL
    INTO :new.cod_sede
    FROM dual;
END;

/* ************************************************************************
 * [5] SET TELEFONO DEFAULT 0
 * ************************************************************************
 * SE DIÓ UN VALOR POR DEFECTO 0 A TELEFONO
 * *************************************************************************/
ALTER TABLE MIEMBRO
    MODIFY telefono DEFAULT 0;

/* ************************************************************************
 * [6] SCRIPT PARA HACER LA INSERCION DE DATOS EN TABLAS REQUERIDAS
 * ************************************************************************
 * SE LLENAN LOS DATOS DADOS EN 'insercion.pdf'
 * *************************************************************************/
/* *************************************************************
 * TABLA PROFESION                                             *
 * *************************************************************/
INSERT ALL 
    INTO PROFESION (nombre) VALUES ('Médico')
    INTO PROFESION (nombre) VALUES ('Arquitecto')
    INTO PROFESION (nombre) VALUES ('Ingeniero')
    INTO PROFESION (nombre) VALUES ('Secretaria')
    INTO PROFESION (nombre) VALUES ('Auditor')
SELECT 1 FROM DUAL;
SELECT * FROM PROFESION;

/* *************************************************************
 * TABLA PAIS                                                  *
 * *************************************************************/
INSERT ALL
    INTO PAIS (nombre) VALUES ('Guatemala')
    INTO PAIS (nombre) VALUES ('Francia')
    INTO PAIS (nombre) VALUES ('Argentina')
    INTO PAIS (nombre) VALUES ('Alemania')
    INTO PAIS (nombre) VALUES ('Italia')
    INTO PAIS (nombre) VALUES ('Brasil')
    INTO PAIS (nombre) VALUES ('Estados Unidos')
SELECT 1 FROM DUAL;
SELECT * FROM PAIS;

/* *************************************************************
 * TABLA DISCIPLINA                                            *
 * *************************************************************/
INSERT ALL 
    INTO DISCIPLINA (nombre, descripcion) VALUES ('Atletismo', 'Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco.')
    INTO DISCIPLINA (nombre) VALUES ('Bádminton')
    INTO DISCIPLINA (nombre) VALUES ('Ciclismo')
    INTO DISCIPLINA (nombre, descripcion) VALUES ('Judo', 'Es un arte marcial que se originó en Japón alrededor de 1880')
    INTO DISCIPLINA (nombre) VALUES ('Lucha')
    INTO DISCIPLINA (nombre) VALUES ('Tenis de Mesa')
    INTO DISCIPLINA (nombre) VALUES ('Boxeo')
    INTO DISCIPLINA (nombre, descripcion) VALUES ('Natación', 'Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.')
    INTO DISCIPLINA (nombre) VALUES ('Esgrima')
    INTO DISCIPLINA (nombre) VALUES ('Vela')
SELECT 1 FROM DUAL;    
SELECT * FROM DISCIPLINA;

/* *************************************************************
 * TABLA TIPO_MEDALLA                                          *
 * *************************************************************/
INSERT ALL 
    INTO TIPO_MEDALLA (medalla) VALUES ('Oro')
    INTO TIPO_MEDALLA (medalla) VALUES ('Plata')
    INTO TIPO_MEDALLA (medalla) VALUES ('Bronce')
    INTO TIPO_MEDALLA (medalla) VALUES ('Platino')
SELECT 1 FROM DUAL;
SELECT * FROM TIPO_MEDALLA;

/* *************************************************************
 * TABLA CATEGORIA                                             *
 * *************************************************************/
INSERT ALL 
    INTO CATEGORIA (categoria) VALUES ('Clasificatorio')
    INTO CATEGORIA (categoria) VALUES ('Eliminatorio')
    INTO CATEGORIA (categoria) VALUES ('Final')
SELECT 1 FROM DUAL;
SELECT * FROM CATEGORIA;

/* *************************************************************
 * TABLA TIPO_PARTICIPACION                                    *
 * *************************************************************/
INSERT ALL 
    INTO TIPO_PARTICIPACION (tipo_participacion) VALUES ('Individual')
    INTO TIPO_PARTICIPACION (tipo_participacion) VALUES('Parejas')
    INTO TIPO_PARTICIPACION (tipo_participacion) VALUES('Equipos')
SELECT 1 FROM DUAL;
SELECT * FROM TIPO_PARTICIPACION;

/* *************************************************************
 * TABLA SEDE                                                  *
 * *************************************************************/
INSERT ALL 
    INTO SEDE (sede) VALUES ('Gimnasio Metropolitano de Tokio')
    INTO SEDE (sede) VALUES ('Jardín del Palacio Imperial de Tokio')
    INTO SEDE (sede) VALUES ('Gimnasio Nacional Yoyogi')
    INTO SEDE (sede) VALUES ('Nippon Budokan')
    INTO SEDE (sede) VALUES ('Estadio Olímpico')
SELECT 1 FROM DUAL;
SELECT * FROM SEDE;

/* *************************************************************
 * TABLA MIEMBRO                                               *
 * *************************************************************/
INSERT INTO MIEMBRO (nombre, apellido, edad, residencia, PAIS_cod_pais, PROFESION_cod_prof) VALUES ('Scott', 'Mitchell', 32, '1092 Highland Drive Manitowoc, WI 54220', 7, 3)
INSERT INTO MIEMBRO (nombre, apellido, edad, telefono, residencia, PAIS_cod_pais, PROFESION_cod_prof) VALUES ('Fanette', 'Poulin', 32, 25075853, '49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY', 2, 4)
INSERT INTO MIEMBRO (nombre, apellido, edad, residencia, PAIS_cod_pais, PROFESION_cod_prof) VALUES ('Laura', 'Cunha Silva', 55, 'Rua Onze, 86 uberaba-MG', 6, 5)
INSERT INTO MIEMBRO (nombre, apellido, edad, telefono, residencia, PAIS_cod_pais, PROFESION_cod_prof) VALUES ('Juan Jose', 'López', 38, 36985247, '26 Calle 4-10 zona 11', 1, 2)
INSERT INTO MIEMBRO (nombre, apellido, edad, telefono, residencia, PAIS_cod_pais, PROFESION_cod_prof) VALUES ('Arcangela', 'Panicucci', 39, 391664921, 'Via Santa Teresa, 114 90010-Geraci Siculo PA', 5, 1)
INSERT INTO MIEMBRO (nombre, apellido, edad, residencia, PAIS_cod_pais, PROFESION_cod_prof) VALUES ('Jeuel', 'Villalpando', 31, 'Acuña de Figueroa 6106 80101', 3, 5);

SELECT m.nombre, m.apellido, m.edad, m.residencia, c.nombre AS pais, p.nombre AS profesion 
FROM MIEMBRO m, PAIS c, PROFESION p 
WHERE m.PAIS_cod_pais = c.cod_pais AND 
      m.PROFESION_cod_prof = p.cod_prof;

/* *************************************************************
 * TABLA MEDALLERO                                             *
 * *************************************************************/
INSERT ALL 
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 5, 1, 3)
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 2, 1, 5)
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 6, 3, 4)
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 4, 4, 3)
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 7, 3, 10)
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 3, 2, 8)
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 1, 1, 2)
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 1, 4, 5)
    INTO MEDALLERO (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo, cantidad_medallas ) VALUES ( 5, 2, 7)
SELECT 1 FROM DUAL;
SELECT p.nombre AS pais, m.cantidad_medallas, t.medalla
FROM MEDALLERO m, PAIS p, TIPO_MEDALLA t 
WHERE m.PAIS_cod_pais = p.cod_pais AND 
      m.TIPO_MEDALLA_cod_tipo = t.cod_tipo;

/* *************************************************************
 * TABLA EVENTO                                                *
 * *************************************************************/
CALL SP_InsertEventos('24-07-2020 11:00:00', 3, 2, 2, 1);
CALL SP_InsertEventos('26-07-2020 10:30:00', 1, 6, 1, 3);
CALL SP_InsertEventos('30-07-2020 18:45:00', 5, 7, 1, 2);
CALL SP_InsertEventos('01-08-2020 12:15:00', 2, 1, 1, 1);
CALL SP_InsertEventos('08-08-2020 19:35:00', 4, 10, 3, 1);
/* BEFORE DATE */
CALL SP_InsertEventos('08-08-2020 18:35:00', 4, 10, 3, 1);
CALL SP_InsertEventos('07-08-2020 19:35:00', 4, 10, 3, 1);
/* AFTER DATE */
CALL SP_InsertEventos('08-08-2020 20:35:00', 4, 10, 3, 1);
CALL SP_InsertEventos('09-08-2020 19:35:00', 4, 10, 3, 1);
SELECT e.fecha_hora, s.sede, d.nombre AS disciplina, t.tipo_participacion, c.categoria
FROM EVENTO e, DISCIPLINA d, TIPO_PARTICIPACION t, CATEGORIA c, SEDE s 
WHERE e.DISCIPLINA_cod_discip = d.cod_disciplina AND 
      e.TIPO_PARTICIPACION_cod_part = t.cod_participacion AND 
      e.CATEGORIA_cod_categoria = c.cod_categoria AND 
      e.ubicacion = s.cod_sede;

/* ************************************************************************
 * [7] ELIMINAR RESTRICCIÓN UNIQUE
 * ************************************************************************
 * ELIMINAR RESTRICCIÓN UNIQUE DE PAIS nombre
 * ELIMINAR RESTRICCIÓN UNIQUE DE TIPO_MEDALLA medalla
 * ELIMINAR RESTRICCIÓN UNIQUE DE DEPARTAMENTO nombre
 * *************************************************************************/
ALTER TABLE PAIS 
    DROP CONSTRAINT UK_PAIS_nombre;

ALTER TABLE TIPO_MEDALLA
    DROP CONSTRAINT UK_TIPO_MEDALLA_medalla;

ALTER TABLE DEPARTAMENTO 
    DROP CONSTRAINT UK_DEPTO_nombre;

/* ************************************************************************
 * [8] ATLETAS PUEDEN PARTICIPAR EN VARIAS DISCIPLINAS
 * ************************************************************************
 * ELIMINAR FOREIGN KEY SOBRE ATELTA cod_disciplina
 * CREAR TABLA DISCIPLINA_ATLETA
 * REFERENCIAR LLAVES PRIMARIAS ATLETA cod_atleta Y DISCIPLINA cod_disciplina
 * *************************************************************************/
ALTER TABLE ATLETA 
    DROP CONSTRAINT FK_ATLETA_cod_disciplina;

CREATE TABLE DISCIPLINA_ATLETA (
    ATLETA_cod_atleta INT,
    DISCIPLINA_cod_discip INT
);
ALTER TABLE DISCIPLINA_ATLETA
    ADD CONSTRAINT PK_DISC_ATLETA PRIMARY KEY (ATLETA_cod_atleta, DISCIPLINA_cod_discip);
ALTER TABLE DISCIPLINA_ATLETA
    ADD CONSTRAINT FK_DISC_ATLETA_cod_atleta FOREIGN KEY (ATLETA_cod_atleta) REFERENCES ATLETA(cod_atleta);
ALTER TABLE DISCIPLINA_ATLETA
    ADD CONSTRAINT FK_DISC_ATLETA_cod_disciplina FOREIGN KEY (DISCIPLINA_cod_discip) REFERENCES DISCIPLINA(cod_disciplina);

/* ************************************************************************
 * [9] CAMBIAR DE INT A DECIMAL EN COSTO_EVENTO tarifa
 * ************************************************************************
 * *************************************************************************/
ALTER TABLE COSTO_EVENTO 
    MODIFY (tarifa DECIMAL(18,2));

/* ************************************************************************
 * [10] BORRAR DE TABLA TIPO_MEDALLA EL CODIGO 4
 * ************************************************************************
 * *************************************************************************/
DELETE FROM TIPO_MEDALLA
WHERE cod_tipo = 4;

/* ************************************************************************
 * [11] ELIMINAR TABLA TELEVISORAS Y COSTO_EVENTO
 * ************************************************************************
 * *************************************************************************/
DELETE FROM COSTO_EVENTO;
DELETE FROM TELEVISORA;
DROP TABLE COSTO_EVENTO;
DROP TABLE TELEVISORA;

/* ************************************************************************
 * [12] VACIAR TABLA DISCIPLINA
 * ************************************************************************
 * *************************************************************************/
DELETE FROM DISCIPLINA;

/* ************************************************************************
 * [13] MODIFICAR TELEFONO EN TABLA MIEMBRO
 * ************************************************************************
 * *************************************************************************/
UPDATE MIEMBRO
SET telefono = 55464601
WHERE nombre = 'Laura' AND
      apellido = 'Cunha Silva';

UPDATE MIEMBRO
SET telefono = 91514243
WHERE nombre = 'Jeuel' AND 
      apellido = 'Villalpando';

UPDATE MIEMBRO
SET telefono = 920686670
WHERE nombre = 'Scott' AND 
      apellido = 'Mitchell';

/* ************************************************************************
 * [14] AGREGAR COLUMNA ATLETA fotografia OPCIONAL
 * ************************************************************************
 * *************************************************************************/
ALTER TABLE ATLETA 
    ADD fotografia VARCHAR2(100);

/* ************************************************************************
 * [15] VALIDAR EDAD DE ATLETAS SEA MENOR A 25 AÑOS
 * ************************************************************************
 * *************************************************************************/
CREATE OR REPLACE PROCEDURE SP_InsertAtleta (
    in_nombre IN VARCHAR2,
    in_apellido IN VARCHAR2,
    in_edad IN INT, 
    in_fotografia IN VARCHAR2, 
    in_participaciones IN VARCHAR2,
    in_cod_disciplina IN INT,
    in_cod_pais INT
)
IS
BEGIN
    IF (in_edad < 25) THEN
        INSERT INTO ATLETA (
            nombre,
            apellido,
            edad, 
            fotografia, 
            participaciones,
            PAIS_cod_pais
        )
        VALUES (
            in_nombre,
            in_apellido,
            in_edad, 
            in_fotografia, 
            in_participaciones,
            in_cod_pais
        );

        INSERT INTO DISCIPLINA_ATLETA (
            ATLETA_cod_atleta, 
            DISCIPLINA_cod_discip
        )
        VALUES (
            SEQ_ATLETA.CURRVAL, 
            in_cod_disciplina
        );
    END IF;
END;