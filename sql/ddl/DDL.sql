/* =====================================================
  1. DATABASE 생성 / 삭제  (DDL)
===================================================== */

CREATE DATABASE doitsql;
USE doitsql;

-- DROP DATABASE doitsql;


/* =====================================================
  2. TABLE 생성 / 삭제 (DDL)
===================================================== */

CREATE TABLE doit_dml (
  col_1 INT,
  col_2 VARCHAR(50),
  col_3 DATETIME
);

-- DROP TABLE doit_dml;


/* =====================================================
  4. NOT NULL 제약조건 (DDL)
===================================================== */

CREATE TABLE doit_notnull (
  col_1 INT,
  col_2 VARCHAR(50) NOT NULL
);


/* =====================================================
  5. PRIMARY KEY 설정 (DDL)
===================================================== */

ALTER TABLE doit_dml
ADD PRIMARY KEY (col_1);


/* =====================================================
  AUTO_INCREMENT (DDL)
===================================================== */

CREATE TABLE doit_increment(
  col_1 INT auto_increment primary key,
  col_2 varchar(50),
  col_3 int
);

/* AUTO_INCREMENT 시작값 변경 */
ALTER TABLE doit_increment AUTO_INCREMENT = 100;


/* =====================================================
  INSERT INTO + SELECT 결과용 테이블 생성 (DDL)
===================================================== */

CREATE TABLE doit_insert_select_from (
  col_1 INT,
  col_2 VARCHAR(10)
);

CREATE TABLE doit_insert_select_to (
  col_1 INT,
  col_2 VARCHAR(10)
);

/* 새 테이블에 조회결과 입력 (DDL) */
CREATE TABLE doit_select_new AS (SELECT * FROM doit_insert_select_from);


/* =====================================================
  FK(외래키) 실습용 테이블 (DDL)
===================================================== */

CREATE TABLE doit_parent (col_1 int primary key);

CREATE TABLE doit_child (col_1 int);

ALTER TABLE doit_child
ADD FOREIGN KEY (col_1) REFERENCES doit_parent(col_1);

/* FK 제약 조건 제거 */
ALTER TABLE doit_child
DROP CONSTRAINT doit_child_ibfk_1;

/* 테이블 삭제 */
DROP TABLE doit_child;
DROP TABLE doit_parent;


/* =====================================================
  데이터 유형 실습용 테이블 (DDL)
===================================================== */

CREATE TABLE doit_float (col_1 FLOAT);

CREATE TABLE doit_char_varchar (
  col_1 CHAR(5),
  col_2 VARCHAR(5)
);

/* 콜레이션 비교용 테이블 */
CREATE TABLE doit_collation (
  col_latin1_ci   VARCHAR(10) COLLATE latin1_general_ci,
  col_latin1_cs   VARCHAR(10) COLLATE latin1_general_cs,
  col_latin1_bin  VARCHAR(10) COLLATE latin1_bin
);

/* 날짜 유형 비교용 테이블 */
CREATE TABLE date_table (
  justdate DATE,
  justtime TIME,
  justdatetime datetime,
  justfimeeamp TIMESTAMP
);


/* =====================================================
  CROSS JOIN 실습용 테이블 (DDL)
===================================================== */

CREATE TABLE doit_cross1(num INT);
CREATE TABLE doit_cross2(name VARCHAR(10));
