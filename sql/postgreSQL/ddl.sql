/* ************************************************************************
 * [0] PREPARAR BASE DE DATOS
 * ************************************************************************
 * CREAR BASE DE DATOS OLYMPIC_DB CON ENCODING UTF-8
 * USAR LA BASE DE DATOS PARA OPERACIONES DDL Y DML
 * ************************************************************************/
CREATE DATABASE OLYMPIC_DB TEMPLATE template1;

\c OLYMPIC_DB;

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
 * CREATE SEQUENCE IF NOT EXISTS nombre_secuencia
 *  AS INT 
 *  INCREMENT BY 1
 *  MINVALUE 1
 *  NO MAXVALUE
 *  START WITH 1
 *  NO CYCLE
 *  OWNED BY tabla.columna
 * AS INT: PORQUE LOS CAMPOS AUTOINCREMENTABLES A APLICARSE, SERÁN DE TIPO INT
 * INCREMENT BY 1: PORQUE SE INCREMENTARA 1 CADA VEZ
 * MINVALUE 1: PORQUE EMPEZARÁ CON UN VALOR MÍNIMO DE 1
 * NO MAXVALUE: PORQUE NO TENDRÁ NÚMERO MÁXIMO
 * START WITH 1: PORQUE EMPEZARÁ CON 1
 * NO CYCLE: PORQUE NO TENDRÁ CICLO, ES DECIR, NO SERÁ NUEVEMENTE 1
 * OWNED BY: INDICA QUE LA SECUENCIA LE PERTENECE A DICHA COLUMNA
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
    nombre VARCHAR(50)
);
ALTER TABLE PROFESION
    ALTER COLUMN cod_prof SET NOT NULL, 
    ALTER COLUMN nombre SET NOT NULL, 
    ADD CONSTRAINT PK_PROFESION PRIMARY KEY (cod_prof), 
    ADD CONSTRAINT UK_PROFESION_nombre UNIQUE (nombre);

CREATE SEQUENCE IF NOT EXISTS SEQ_PROFESION
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY PROFESION.cod_prof;

CREATE OR REPLACE FUNCTION TRG_FUN_PROFESION()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_prof = NEXTVAL('SEQ_PROFESION');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_PROFESION
BEFORE INSERT 
    ON PROFESION
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_PROFESION();

/* *************************************************************
 * TABLA PAIS                                                  *
 * *************************************************************/
CREATE TABLE PAIS (
    cod_pais INT,
    nombre VARCHAR(50)
);
ALTER TABLE PAIS 
    ALTER COLUMN cod_pais SET NOT NULL, 
    ALTER COLUMN nombre SET NOT NULL, 
    ADD CONSTRAINT PK_PAIS PRIMARY KEY (cod_pais), 
    ADD CONSTRAINT UK_PAIS_nombre UNIQUE (nombre);

CREATE SEQUENCE IF NOT EXISTS SEQ_PAIS
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY PAIS.cod_pais;

CREATE OR REPLACE FUNCTION TRG_FUN_PAIS()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_pais = NEXTVAL('SEQ_PAIS');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_PAIS
BEFORE INSERT 
    ON PAIS
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_PAIS();

/* *************************************************************
 * TABLA PUESTO                                                *
 * *************************************************************/
CREATE TABLE PUESTO (
    cod_puesto INT,
    nombre VARCHAR(50)
);
ALTER TABLE PUESTO 
    ALTER COLUMN cod_puesto SET NOT NULL, 
    ALTER COLUMN nombre SET NOT NULL, 
    ADD CONSTRAINT PK_PUESTO PRIMARY KEY (cod_puesto), 
    ADD CONSTRAINT UK_PUESTO_nombre UNIQUE (nombre);

CREATE SEQUENCE IF NOT EXISTS SEQ_PUESTO
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY PUESTO.cod_puesto;

CREATE OR REPLACE FUNCTION TRG_FUN_PUESTO()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_puesto = NEXTVAL('SEQ_PUESTO');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_PUESTO
BEFORE INSERT 
    ON PUESTO
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_PUESTO();

/* *************************************************************
 * TABLA DEPARTAMENTO                                          *
 * *************************************************************/
CREATE TABLE DEPARTAMENTO (
    cod_depto INT,
    nombre VARCHAR(50)
);
ALTER TABLE DEPARTAMENTO 
    ALTER COLUMN cod_depto SET NOT NULL, 
    ALTER COLUMN nombre SET NOT NULL, 
    ADD CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (cod_depto), 
    ADD CONSTRAINT UK_DEPTO_nombre UNIQUE (nombre);

CREATE SEQUENCE IF NOT EXISTS SEQ_DEPARTAMENTO
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY DEPARTAMENTO.cod_depto;

CREATE OR REPLACE FUNCTION TRG_FUN_DEPARTAMENTO()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_depto = NEXTVAL('SEQ_DEPARTAMENTO');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_DEPARTAMENTO
BEFORE INSERT 
    ON DEPARTAMENTO
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_DEPARTAMENTO();

/* *************************************************************
 * TABLA MIEMBRO                                               *
 * *************************************************************/
CREATE TABLE MIEMBRO (
    cod_miembro INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    edad INT,
    telefono INT,
    residencia VARCHAR(100),
    PAIS_cod_pais INT,
    PROFESION_cod_prof INT
);
ALTER TABLE MIEMBRO
    ALTER COLUMN cod_miembro SET NOT NULL, 
    ALTER COLUMN nombre SET NOT NULL, 
    ALTER COLUMN apellido SET NOT NULL, 
    ALTER COLUMN edad SET NOT NULL, 
    ALTER COLUMN PAIS_cod_pais SET NOT NULL, 
    ALTER COLUMN PROFESION_cod_prof SET NOT NULL, 
    ADD CONSTRAINT PK_MIEMBRO PRIMARY KEY (cod_miembro), 
    ADD CONSTRAINT FK_MIEMBRO_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais) 
        ON DELETE CASCADE, 
    ADD CONSTRAINT FK_MIEMBRO_cod_profesion FOREIGN KEY (PROFESION_cod_prof) REFERENCES PROFESION(cod_prof) 
        ON DELETE CASCADE;

CREATE SEQUENCE IF NOT EXISTS SEQ_MIEMBRO
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY MIEMBRO.cod_miembro;

CREATE OR REPLACE FUNCTION TRG_FUN_MIEMBRO()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_miembro = NEXTVAL('SEQ_MIEMBRO');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_MIEMBRO
BEFORE INSERT 
    ON MIEMBRO
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_MIEMBRO();
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
    ALTER COLUMN MIEMBRO_cod_miembro SET NOT NULL, 
    ALTER COLUMN PUESTO_cod_puesto SET NOT NULL,
    ALTER COLUMN DEPARTAMENTO_cod_depto SET NOT NULL,
    ALTER COLUMN fecha_inicio SET NOT NULL,
    ADD CONSTRAINT PK_PUESTO_MIEMBRO PRIMARY KEY (MIEMBRO_cod_miembro, PUESTO_cod_puesto, DEPARTAMENTO_cod_depto), 
    ADD CONSTRAINT FK_PUESTO_MIEMBRO_cod_miembro FOREIGN KEY (MIEMBRO_cod_miembro) REFERENCES MIEMBRO(cod_miembro)
        ON DELETE CASCADE, 
    ADD CONSTRAINT FK_PUESTO_MIEMBRO_cod_puesto FOREIGN KEY (PUESTO_cod_puesto) REFERENCES PUESTO(cod_puesto)
        ON DELETE CASCADE, 
    ADD CONSTRAINT fk_PUESTO_MIEMBRO_cod_depto FOREIGN KEY (DEPARTAMENTO_cod_depto) REFERENCES DEPARTAMENTO(cod_depto)
        ON DELETE CASCADE;

/* *************************************************************
 * TABLA TIPO_MEDALLA                                          *
 * *************************************************************/
CREATE TABLE TIPO_MEDALLA (
    cod_tipo INT NOT NULL,
    medalla VARCHAR(20) NOT NULL
);
ALTER TABLE TIPO_MEDALLA 
    ALTER COLUMN cod_tipo SET NOT NULL, 
    ALTER COLUMN medalla SET NOT NULL, 
    ADD CONSTRAINT PK_TIPO_MEDALLA_cod_tipo PRIMARY KEY (cod_tipo), 
    ADD CONSTRAINT UK_TIPO_MEDALLA_medalla UNIQUE (medalla);

CREATE SEQUENCE IF NOT EXISTS SEQ_TIPO_MEDALLA
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY TIPO_MEDALLA.cod_tipo;

CREATE OR REPLACE FUNCTION TRG_FUN_TIPO_MEDALLA()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_tipo = NEXTVAL('SEQ_TIPO_MEDALLA');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_TIPO_MEDALLA
BEFORE INSERT 
    ON TIPO_MEDALLA
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_TIPO_MEDALLA();
/* *************************************************************
 * TABLA MEDALLERO                                             *
 * *************************************************************/
CREATE TABLE MEDALLERO (
    PAIS_cod_pais INT,
    cantidad_medallas INT,
    TIPO_MEDALLA_cod_tipo INT
);
ALTER TABLE MEDALLERO 
    ALTER COLUMN PAIS_cod_pais SET NOT NULL,
    ALTER COLUMN cantidad_medallas SET NOT NULL,
    ALTER COLUMN TIPO_MEDALLA_cod_tipo SET NOT NULL, 
    ADD CONSTRAINT PK_MEDALLERO PRIMARY KEY (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo), 
    ADD CONSTRAINT FK_MEDALLERO_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais)
        ON DELETE CASCADE, 
    ADD CONSTRAINT FK_MEDALLERO_cod_tipo FOREIGN KEY (TIPO_MEDALLA_cod_tipo) REFERENCES TIPO_MEDALLA(cod_tipo)
        ON DELETE CASCADE;

/* *************************************************************
 * TABLA DISCIPLINA                                            *
 * *************************************************************/
CREATE TABLE DISCIPLINA (
    cod_disciplina INT,
    nombre VARCHAR(50),
    descripcion VARCHAR(150)
);
ALTER TABLE DISCIPLINA 
    ALTER COLUMN cod_disciplina SET NOT NULL, 
    ALTER COLUMN nombre SET NOT NULL, 
    ADD CONSTRAINT PK_DISCIPLINA PRIMARY KEY (cod_disciplina);

CREATE SEQUENCE IF NOT EXISTS SEQ_DISCIPLINA
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY DISCIPLINA.cod_disciplina;

CREATE OR REPLACE FUNCTION TRG_FUN_DISCIPLINA()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_disciplina = NEXTVAL('SEQ_DISCIPLINA');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_DISCIPLINA
BEFORE INSERT 
    ON DISCIPLINA
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_DISCIPLINA();

/* *************************************************************
 * TABLA ATLETA                                                *
 * *************************************************************/
CREATE TABLE ATLETA (
    cod_atleta INT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    participaciones VARCHAR(100),
    DISCIPLINA_cod_disciplina INT,
    PAIS_cod_pais INT
);
ALTER TABLE ATLETA 
    ALTER COLUMN cod_atleta SET NOT NULL, 
    ALTER COLUMN nombre SET NOT NULL, 
    ALTER COLUMN apellido SET NOT NULL, 
    ALTER COLUMN edad SET NOT NULL, 
    ALTER COLUMN participaciones SET NOT NULL, 
    ALTER COLUMN DISCIPLINA_cod_disciplina SET NOT NULL, 
    ALTER COLUMN PAIS_cod_pais SET NOT NULL, 
    ADD CONSTRAINT PK_ATLETA PRIMARY KEY (cod_atleta), 
    ADD CONSTRAINT FK_ATLETA_cod_disciplina FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA(cod_disciplina)
        ON DELETE CASCADE, 
    ADD CONSTRAINT FK_ATLETA_cod_pais FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS(cod_pais)
        ON DELETE CASCADE;

CREATE SEQUENCE IF NOT EXISTS SEQ_ATLETA
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY ATLETA.cod_atleta;

CREATE OR REPLACE FUNCTION TRG_FUN_ATLETA()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_atleta = NEXTVAL('SEQ_ATLETA');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_ATLETA
BEFORE INSERT 
    ON ATLETA
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_ATLETA();

/* *************************************************************
 * TABLA CATEGORIA                                             *
 * *************************************************************/
CREATE TABLE CATEGORIA (
    cod_categoria INT,
    categoria VARCHAR(50)
);
ALTER TABLE CATEGORIA 
    ALTER COLUMN cod_categoria SET NOT NULL, 
    ALTER COLUMN categoria SET NOT NULL, 
    ADD CONSTRAINT PK_CATEGORIA PRIMARY KEY (cod_categoria);

CREATE SEQUENCE IF NOT EXISTS SEQ_CATEGORIA
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY CATEGORIA.cod_categoria;

CREATE OR REPLACE FUNCTION TRG_FUN_CATEGORIA()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_categoria = NEXTVAL('SEQ_CATEGORIA');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_CATEGORIA
BEFORE INSERT 
    ON CATEGORIA
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_CATEGORIA();

/* *************************************************************
 * TABLA TIPO_PARTICIPACION                                    *
 * *************************************************************/
CREATE TABLE TIPO_PARTICIPACION (
    cod_participacion INT,
    tipo_participacion VARCHAR(100)
);
ALTER TABLE TIPO_PARTICIPACION 
    ALTER COLUMN cod_participacion SET NOT NULL, 
    ALTER COLUMN tipo_participacion SET NOT NULL, 
    ADD CONSTRAINT PK_TIPO_PARTICIPACION PRIMARY KEY (cod_participacion);

CREATE SEQUENCE IF NOT EXISTS SEQ_TIPO_PARTICIPACION
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY TIPO_PARTICIPACION.cod_participacion;

CREATE OR REPLACE FUNCTION TRG_FUN_TIPO_PARTICIPACION()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_participacion = NEXTVAL('SEQ_TIPO_PARTICIPACION');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_TIPO_PARTICIPACION
BEFORE INSERT 
    ON TIPO_PARTICIPACION
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_TIPO_PARTICIPACION();

/* *************************************************************
 * TABLA EVENTO                                                *
 * *************************************************************/
CREATE TABLE EVENTO (
    cod_evento INT,
    fecha DATE,
    ubicacion VARCHAR(50),
    hora DATE,
    DISCIPLINA_cod_disciplina INT,
    TIPO_PARTICIPACION_cod_participacion INT,
    CATEGORIA_cod_categoria INT
);
ALTER TABLE EVENTO 
    ALTER COLUMN cod_evento SET NOT NULL, 
    ALTER COLUMN fecha SET NOT NULL, 
    ALTER COLUMN ubicacion SET NOT NULL, 
    ALTER COLUMN hora SET NOT NULL, 
    ALTER COLUMN DISCIPLINA_cod_disciplina SET NOT NULL, 
    ALTER COLUMN TIPO_PARTICIPACION_cod_participacion SET NOT NULL, 
    ALTER COLUMN CATEGORIA_cod_categoria SET NOT NULL, 
    ADD CONSTRAINT PK_EVENTO PRIMARY KEY (cod_evento), 
    ADD CONSTRAINT FK_EVENTO_cod_disciplina FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA(cod_disciplina)
        ON DELETE CASCADE, 
    ADD CONSTRAINT FK_EVENTO_cod_participacion FOREIGN KEY (TIPO_PARTICIPACION_cod_participacion) REFERENCES TIPO_PARTICIPACION(cod_participacion)
        ON DELETE CASCADE, 
    ADD CONSTRAINT FK_EVENTO_cod_categoria FOREIGN KEY (CATEGORIA_cod_categoria) REFERENCES CATEGORIA(cod_categoria)
        ON DELETE CASCADE;

CREATE SEQUENCE IF NOT EXISTS SEQ_EVENTO
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY EVENTO.cod_evento;

CREATE OR REPLACE FUNCTION TRG_FUN_EVENTO()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_evento = NEXTVAL('SEQ_EVENTO');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_EVENTO
BEFORE INSERT 
    ON EVENTO
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_EVENTO();

/* *************************************************************
 * TABLA EVENTO_ATLETA                                         *
 * *************************************************************/
CREATE TABLE EVENTO_ATLETA (
    ATLETA_cod_atleta INT,
    EVENTO_cod_evento INT
);
ALTER TABLE EVENTO_ATLETA 
    ALTER COLUMN ATLETA_cod_atleta SET NOT NULL, 
    ALTER COLUMN EVENTO_cod_evento SET NOT NULL, 
    ADD CONSTRAINT PK_EVENTO_ATLETA PRIMARY KEY (ATLETA_cod_atleta, EVENTO_cod_evento), 
    ADD CONSTRAINT FK_EVENTO_ATLETA_cod_atleta FOREIGN KEY (ATLETA_cod_atleta) REFERENCES ATLETA(cod_atleta)
        ON DELETE CASCADE, 
    ADD CONSTRAINT FK_EVENTO_ATLETA_cod_evento FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO(cod_evento)
        ON DELETE CASCADE;

/* *************************************************************
 * TABLA TELEVISORA                                            *
 * *************************************************************/
CREATE TABLE TELEVISORA (
    cod_televisora INT,
    nombre VARCHAR(50)
);
ALTER TABLE TELEVISORA 
    ALTER COLUMN cod_televisora SET NOT NULL, 
    ALTER COLUMN nombre SET NOT NULL, 
    ADD CONSTRAINT PK_TELEVISORA PRIMARY KEY (cod_televisora);

CREATE SEQUENCE IF NOT EXISTS SEQ_TELEVISORA
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY TELEVISORA.cod_televisora;

CREATE OR REPLACE FUNCTION TRG_FUN_TELEVISORA()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_televisora = NEXTVAL('SEQ_TELEVISORA');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_TELEVISORA
BEFORE INSERT 
    ON TELEVISORA
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_TELEVISORA();

/* *************************************************************
 * TABLA COSTO_EVENTO                                          *
 * *************************************************************/
CREATE TABLE COSTO_EVENTO (
    EVENTO_cod_evento INT,
    TELEVISORA_cod_televisora INT,
    tarifa NUMERIC
);
ALTER TABLE COSTO_EVENTO 
    ALTER COLUMN EVENTO_cod_evento SET NOT NULL, 
    ALTER COLUMN TELEVISORA_cod_televisora SET NOT NULL, 
    ALTER COLUMN tarifa SET NOT NULL, 
    ADD CONSTRAINT PK_COSTO_EVENTO PRIMARY KEY (EVENTO_cod_evento, TELEVISORA_cod_televisora), 
    ADD CONSTRAINT FK_COSTO_EVENTO_cod_evento FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO(cod_evento)
        ON DELETE CASCADE, 
    ADD CONSTRAINT FK_COSTO_EVENTO_cod_televisora FOREIGN KEY (TELEVISORA_cod_televisora) REFERENCES TELEVISORA(cod_televisora)
        ON DELETE CASCADE;

/* ************************************************************************
 * [2] UNIR FECHA Y HORA DE TABLA EVENTO
 * ************************************************************************
 * SE ELIMINAN LAS COLUMNAS fecha Y hora DE TABLA EVENTO
 * SE AGREGA COLUMNA fecha CON FOMMATO TIMESTAMP PARA FECHA Y HORA
 * *************************************************************************/
ALTER TABLE EVENTO 
    DROP COLUMN fecha,
    DROP COLUMN hora, 
    ADD COLUMN fecha_hora TIMESTAMP NOT NULL;

/* ************************************************************************
 * [3] VALIDAR RANGO DE FECHA EN TABLA EVENTO
 * ************************************************************************
 * CREAR PROCEDIMIENTO ALMACENADO PARA VALIDAR EVENTOS EN EL RANGO PEDIDO
 * PLANTILLA USADO PARA EL PROCEDIMIENTO ALMACENADO:
 * CREATE FUNCTION function_name(p1 type, p2 type)
 *  RETURNS type AS
 * BEGIN
 *  -- logic
 * END;
 * LANGUAGE language_name;
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
CREATE OR REPLACE FUNCTION SP_InsertEventos (
    in_fecha_hora TIMESTAMP,
    in_ubicacion VARCHAR(50),
    in_cod_disciplina INT,
    in_cod_participacion INT,
    in_cod_categoria INT
)
    RETURNS VOID AS 
$BODY$
BEGIN 
    IF (in_fecha >= TIMESTAMP '2020-07-24 09:00:00') THEN
        IF (in_fecha <= TIMESTAMP '2020-08-09 20:00:00') THEN 
            INSERT INTO 
                EVENTO(
                    fecha_hora, 
                    ubicacion, 
                    DISCIPLINA_cod_disciplina, 
                    TIPO_PARTICIPACION_cod_participacion, 
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
    END IF;
END;
$BODY$
LANGUAGE PLpgSQL;

/* ************************************************************************
 * [4] TABLA SEDE PARA REGISTRAR UBICACIONES
 * ************************************************************************
 * CREAR TABLA SEDE
 * CAMBIAR TIPO DE DATO EN COLUMNA UBICACION A INT
 * REFERENCIAR DICHA COLUMNA A TABLA SEDE
 * *************************************************************************/
CREATE TABLE SEDE (
    cod_sede INT,
    sede VARCHAR(50)
);
ALTER TABLE SEDE 
    ALTER COLUMN cod_sede SET NOT NULL, 
    ALTER COLUMN sede SET NOT NULL, 
    ADD CONSTRAINT PK_SEDE PRIMARY KEY (cod_sede);
ALTER TABLE EVENTO 
    ALTER COLUMN ubicacion TYPE INTEGER USING (ubicacion::INTEGER),
    ADD CONSTRAINT FK_EVENTO_ubicacion FOREIGN KEY (ubicacion) REFERENCES SEDE(cod_sede);

CREATE SEQUENCE IF NOT EXISTS SEQ_SEDE
    AS INT 
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    START WITH 1
    NO CYCLE
    OWNED BY SEDE.cod_sede;

CREATE OR REPLACE FUNCTION TRG_FUN_SEDE()
    RETURNS trigger AS 
$BODY$
BEGIN 
    NEW.cod_sede = NEXTVAL('SEQ_SEDE');
    RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER TRG_SEDE
BEFORE INSERT 
    ON SEDE
    FOR EACH ROW 
        EXECUTE PROCEDURE TRG_FUN_SEDE();

CREATE OR REPLACE FUNCTION SP_InsertEventos (
    in_fecha TIMESTAMP,
    in_ubicacion INT,
    in_cod_disciplina INT,
    in_cod_participacion INT,
    in_cod_categoria INT
)
    RETURNS VOID AS 
$BODY$
BEGIN 
    IF (in_fecha >= TIMESTAMP '2020-07-24 09:00:00') THEN
        IF (in_fecha <= TIMESTAMP '2020-08-09 20:00:00') THEN 
            INSERT INTO 
                EVENTO(
                    fecha_hora, 
                    ubicacion, 
                    DISCIPLINA_cod_disciplina, 
                    TIPO_PARTICIPACION_cod_participacion, 
                    CATEGORIA_cod_categoria
                )
            VALUES (
                in_fecha, 
                in_ubicacion, 
                in_cod_disciplina, 
                in_cod_participacion, 
                in_cod_categoria
            );
        END IF;
    END IF;
END;
$BODY$
LANGUAGE PLpgSQL;

/* ************************************************************************
 * [5] SET TELEFONO DEFAULT 0
 * ************************************************************************
 * SE DIÓ UN VALOR POR DEFECTO 0 A TELEFONO
 * *************************************************************************/
ALTER TABLE MIEMBRO
    ALTER COLUMN telefono SET DEFAULT 0;

/* ************************************************************************
 * [6] SCRIPT PARA HACER LA INSERCION DE DATOS EN TABLAS REQUERIDAS
 * ************************************************************************
 * SE LLENAN LOS DATOS DADOS EN 'insercion.pdf'
 * *************************************************************************/
/* *************************************************************
 * TABLA PROFESION                                             *
 * *************************************************************/
INSERT INTO PROFESION (
        nombre
    )
VALUES 
    ('Médico'),
    ('Arquitecto'),
    ('Ingeniero'),
    ('Secretaria'),
    ('Auditor');
SELECT * FROM PROFESION;

/* *************************************************************
 * TABLA PAIS                                                  *
 * *************************************************************/
INSERT INTO PAIS (
        nombre
    )
VALUES 
    ('Guatemala'),
    ('Francia'),
    ('Argentina'),
    ('Alemania'),
    ('Italia'),
    ('Brasil'),
    ('Estados Unidos');
SELECT * FROM PAIS;

/* *************************************************************
 * TABLA DISCIPLINA                                            *
 * *************************************************************/
INSERT INTO DISCIPLINA (nombre, descripcion)
VALUES
    ('Atletismo', 'Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco.');
INSERT INTO DISCIPLINA (nombre)
VALUES
    ('Bádminton');
INSERT INTO DISCIPLINA (nombre)
VALUES
    ('Ciclismo');
INSERT INTO DISCIPLINA (nombre, descripcion)
VALUES
    ('Judo', 'Es un arte marcial que se originó en Japón alrededor de 1880');
INSERT INTO DISCIPLINA (nombre)
VALUES
    ('Lucha');
INSERT INTO DISCIPLINA (nombre)
VALUES
    ('Tenis de Mesa');
INSERT INTO DISCIPLINA (nombre)
VALUES
    ('Boxeo');
INSERT INTO DISCIPLINA (nombre, descripcion)
VALUES
    ('Natación', 'Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.');
INSERT INTO DISCIPLINA (nombre)
VALUES
    ('Esgrima');
INSERT INTO DISCIPLINA (nombre)
VALUES
    ('Vela');
SELECT * FROM DISCIPLINA;

/* *************************************************************
 * TABLA TIPO_MEDALLA                                          *
 * *************************************************************/
INSERT INTO TIPO_MEDALLA (
        medalla
    )
VALUES 
    ('Oro'),
    ('Plata'),
    ('Bronce'),
    ('Platino');
SELECT * FROM TIPO_MEDALLA;

/* *************************************************************
 * TABLA CATEGORIA                                             *
 * *************************************************************/
INSERT INTO CATEGORIA (
        categoria
    )
VALUES 
    ('Clasificatorio'),
    ('Eliminatorio'),
    ('Final');
SELECT * FROM CATEGORIA;

/* *************************************************************
 * TABLA TIPO_PARTICIPACION                                    *
 * *************************************************************/
INSERT INTO TIPO_PARTICIPACION (
        tipo_participacion
    )
VALUES
    ('Individual'),
    ('Parejas'),
    ('Equipos');
SELECT * FROM TIPO_PARTICIPACION;

/* *************************************************************
 * TABLA SEDE                                                  *
 * *************************************************************/
INSERT INTO SEDE (
        sede
    )
VALUES 
    ('Gimnasio Metropolitano de Tokio'),
    ('Jardín del Palacio Imperial de Tokio'),
    ('Gimnasio Nacional Yoyogi'),
    ('Nippon Budokan'),
    ('Estadio Olímpico');
SELECT * FROM SEDE;

/* *************************************************************
 * TABLA MIEMBRO                                               *
 * *************************************************************/
INSERT INTO MIEMBRO (nombre, apellido, edad, residencia, PAIS_cod_pais, PROFESION_cod_prof)
VALUES 
    ('Scott', 'Mitchell', 32, '1092 Highland Drive Manitowoc, WI 54220', 7, 3);
INSERT INTO MIEMBRO (nombre, apellido, edad, telefono, residencia, PAIS_cod_pais, PROFESION_cod_prof)
VALUES 
    ('Fanette', 'Poulin', 32, 25075853, '49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY', 2, 4);
INSERT INTO MIEMBRO (nombre, apellido, edad, residencia, PAIS_cod_pais, PROFESION_cod_prof)
VALUES 
    ('Laura', 'Cunha Silva', 55, 'Rua Onze, 86 uberaba-MG', 6, 5);
INSERT INTO MIEMBRO (nombre, apellido, edad, telefono, residencia, PAIS_cod_pais, PROFESION_cod_prof)
VALUES 
    ('Juan Jose', 'López', 38, 36985247, '26 Calle 4-10 zona 11', 1, 2);
INSERT INTO MIEMBRO (nombre, apellido, edad, telefono, residencia, PAIS_cod_pais, PROFESION_cod_prof)
VALUES 
    ('Arcangela', 'Panicucci', 39, 391664921, 'Via Santa Teresa, 114 90010-Geraci Siculo PA', 5, 1);
INSERT INTO MIEMBRO (nombre, apellido, edad, residencia, PAIS_cod_pais, PROFESION_cod_prof)
VALUES 
    ('Jeuel', 'Villalpando', 31, 'Acuña de Figueroa 6106 80101', 3, 5);
SELECT m.nombre, m.apellido, m.edad, m.residencia, c.nombre AS pais, p.nombre AS profesion 
FROM MIEMBRO m, PAIS c, PROFESION p 
WHERE m.PAIS_cod_pais = c.cod_pais AND 
      m.PROFESION_cod_prof = p.cod_prof;

/* *************************************************************
 * TABLA MEDALLERO                                             *
 * *************************************************************/
INSERT INTO MEDALLERO (
        PAIS_cod_pais, 
        TIPO_MEDALLA_cod_tipo, 
        cantidad_medallas 
    )
VALUES 
    ( 5, 1, 3),
    ( 2, 1, 5),
    ( 6, 3, 4),
    ( 4, 4, 3),
    ( 7, 3, 10),
    ( 3, 2, 8),
    ( 1, 1, 2),
    ( 1, 4, 5),
    ( 5, 2, 7);
SELECT p.nombre AS pais, m.cantidad_medallas, t.medalla
FROM MEDALLERO m, PAIS p, TIPO_MEDALLA t 
WHERE m.PAIS_cod_pais = p.cod_pais AND 
      m.TIPO_MEDALLA_cod_tipo = t.cod_tipo;

/* *************************************************************
 * TABLA EVENTO                                                *
 * *************************************************************/
/* 
 * fecha, 
 * ubicacion, 
 * DISCIPLINA_cod_disciplina, 
 * TIPO_PARTICIPACION_cod_participacion, 
 * CATEGORIA_cod_categoria
*/
SELECT SP_InsertEventos('2020-07-24 11:00:00', 3, 2, 2, 1);
SELECT SP_InsertEventos('2020-07-26 10:30:00', 1, 6, 1, 3);
SELECT SP_InsertEventos('2020-07-30 18:45:00', 5, 7, 1, 2);
SELECT SP_InsertEventos('2020-08-01 12:15:00', 2, 1, 1, 1);
SELECT SP_InsertEventos('2020-08-08 19:35:00', 4, 10, 3, 1);
SELECT e.fecha_hora, s.sede, d.nombre AS disciplina, t.tipo_participacion, c.categoria
FROM EVENTO e, DISCIPLINA d, TIPO_PARTICIPACION t, CATEGORIA c, SEDE s 
WHERE e.DISCIPLINA_cod_disciplina = d.cod_disciplina AND 
      e.TIPO_PARTICIPACION_cod_participacion = t.cod_participacion AND 
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
    DROP CONSTRAINT FK_ATLETA_cod_disciplina ;

CREATE TABLE DISCIPLINA_ATLETA (
    ATLETA_cod_atleta INT,
    DISCIPLINA_cod_disciplina INT
);
ALTER TABLE DISCIPLINA_ATLETA
    ADD CONSTRAINT PK_DISCIPLINA_ATLETA PRIMARY KEY (ATLETA_cod_atleta, DISCIPLINA_cod_disciplina), 
    ADD CONSTRAINT FK_DISCIPLINA_ATLETA_cod_atleta FOREIGN KEY (ATLETA_cod_atleta) REFERENCES ATLETA(cod_atleta), 
    ADD CONSTRAINT FK_DISCIPLINA_ATLETA_cod_disciplina FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA(cod_disciplina);

/* ************************************************************************
 * [9] CAMBIAR DE INT A DECIMAL EN COSTO_EVENTO tarifa
 * ************************************************************************
 * *************************************************************************/
ALTER TABLE COSTO_EVENTO 
    ALTER COLUMN tarifa TYPE DECIMAL(18,2);

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
    ADD COLUMN fotografia VARCHAR(100);

/* ************************************************************************
 * [15] VALIDAR EDAD DE ATLETAS SEA MENOR A 25 AÑOS
 * ************************************************************************
 * *************************************************************************/
CREATE OR REPLACE FUNCTION SP_InsertAtleta (
    in_nombre VARCHAR(50),
    in_apellido VARCHAR(50),
    in_edad INT, 
    in_fotografia VARCHAR(100), 
    in_participaciones VARCHAR(100),
    in_cod_disciplina INT,
    in_cod_pais INT
)
    RETURNS VOID AS 
$BODY$
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
            DISCIPLINA_cod_disciplina
        )
        VALUES (
            currval(SEQ_ATLETA), 
            in_cod_disciplina
        );
    END IF;
END;
$BODY$
LANGUAGE PLpgSQL;
