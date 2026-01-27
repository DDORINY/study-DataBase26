/* =====================================================
  1. DATABASE 생성 / 삭제
===================================================== */

/*
CREATE DATABASE 문법 (설명용)

CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name
[create_option] ...

create_option:
  [DEFAULT] CHARACTER SET [=] charset_name
| [DEFAULT] COLLATE [=] collation_name
| ENCRYPTION [=] {'Y' | 'N'}

※ {}, [], | 는 문법 설명용 기호이며
   실제 SQL 실행 시 사용하지 않는다.
*/

/* 데이터베이스 생성 */
CREATE DATABASE doitsql;

/* 사용할 데이터베이스 선택 */
USE doitsql;

/* 데이터베이스 삭제 */
-- DROP DATABASE doitsql;



/* =====================================================
  2. TABLE 생성 / 삭제
===================================================== */

/*
CREATE TABLE 기본 형식

CREATE TABLE 테이블명 (
  열이름 데이터타입,
  열이름 데이터타입,
  ...
);
*/

/* 테이블 생성 */
CREATE TABLE doit_dml (
  col_1 INT,
  col_2 VARCHAR(50),
  col_3 DATETIME
);

/* 테이블 삭제 */
-- DROP TABLE doit_dml;



/* =====================================================
  3. INSERT (데이터 입력)
===================================================== */

/* 기본 INSERT : 열 이름과 값을 모두 지정 */
INSERT INTO doit_dml (col_1, col_2, col_3)
VALUES (1, 'DoItSQL', '2023-01-01');

/* 전체 데이터 조회 */
SELECT * FROM doit_dml;

/*
데이터 타입 불일치 → 오류 발생
(col_1은 INT인데 문자열을 입력)
INSERT INTO doit_dml (col_1) VALUES ('문자 입력');
*/

/* 열 이름 생략
   → 모든 열에 대해 순서대로 값 입력 */
INSERT INTO doit_dml
VALUES (2, '열이름 생략', '2023-01-02');

/* 일부 열만 입력
   → 지정하지 않은 열은 NULL */
INSERT INTO doit_dml (col_1, col_2)
VALUES (3, 'col_3 값 생략');

/* 열 순서 변경 가능
   → 열 이름을 명시하면 순서와 무관 */
INSERT INTO doit_dml (col_1, col_3, col_2)
VALUES (4, '2023-01-03', '열순서 변경');

/* 여러 행을 한 번에 INSERT */
INSERT INTO doit_dml (col_1, col_2, col_3)
VALUES
  (5, '데이터 입력5', '2023-01-03'),
  (6, '데이터입력6', '2023-01-03'),
  (7, '데이터입력7', '2023-01-03');



/* =====================================================
  4. NOT NULL 제약조건
===================================================== */

/* NOT NULL 제약조건이 있는 테이블 */
CREATE TABLE doit_notnull (
  col_1 INT,
  col_2 VARCHAR(50) NOT NULL
);

/*
NOT NULL 컬럼에 값을 입력하지 않으면 오류 발생
INSERT INTO doit_notnull (col_1) VALUES (1);
*/



/* =====================================================
  5. PRIMARY KEY 설정
===================================================== */

/* Safe Update Mode 활성화 */
SET SQL_SAFE_UPDATES = 1;

/* col_1을 기본키(PRIMARY KEY)로 설정 */
ALTER TABLE doit_dml
ADD PRIMARY KEY (col_1);



/* =====================================================
  6. UPDATE (데이터 수정)
===================================================== */

/* 기본키를 조건으로 특정 행 수정 */
UPDATE doit_dml
SET col_2 = '데이터 수정'
WHERE col_1 = 4;

/* Safe Update Mode 비활성화 (전체 수정 허용) */
SET SQL_SAFE_UPDATES = 0;

/* 모든 행의 col_1 값을 +10 */
UPDATE doit_dml
SET col_1 = col_1 + 10;

/* Safe Update Mode 다시 활성화 */
SET SQL_SAFE_UPDATES = 1;



/* =====================================================
  7. DELETE (데이터 삭제)
===================================================== */

/* 조건에 맞는 특정 행 삭제 */
DELETE FROM doit_dml
WHERE col_1 = 14;

/* 전체 행 삭제 */
SET SQL_SAFE_UPDATES = 0;
DELETE FROM doit_dml;
SET SQL_SAFE_UPDATES = 1;



/* =====================================================
  8. SELECT 기본 문법
===================================================== */

/*
자주 사용하는 SELECT 기본 구조

SELECT [열]
FROM [테이블]
WHERE [조건]
ORDER BY [열];
*/



/* =====================================================
  9. sakila DB SELECT 실습
===================================================== */

/* sakila 데이터베이스 사용 */
USE sakila;

/* 하나의 열 조회 */
SELECT first_name
FROM customer;

/* 두 개의 열 조회 */
SELECT first_name, last_name
FROM customer;

/* 전체 열 조회 */
SELECT *
FROM customer;

/* 테이블의 컬럼 정보 조회 */
SHOW COLUMNS FROM sakila.customer;



/* =====================================================
  10. WHERE 절 조건 조회
===================================================== */

/*
WHERE 절 기본 형식

SELECT [열]
FROM [테이블]
WHERE [열] [연산자] [조건];
*/

/* first_name이 'MARIA'인 행 조회 */
SELECT *
FROM customer
WHERE first_name = 'MARIA';

/* address_id가 200인 행 조회 */
SELECT *
FROM customer
WHERE address_id = 200;

/* address_id가 200 미만인 행 조회 */
SELECT *
FROM customer
WHERE address_id < 200;

/* 문자열 비교
   → 사전 순서(콜레이션 기준)로 비교 */
SELECT *
FROM customer
WHERE first_name < 'MARLA';



/* =====================================================
  11. DATETIME 조건 조회
===================================================== */

/* 특정 날짜/시간과 정확히 일치 */
SELECT *
FROM payment
WHERE payment_date = '2005-07-09 13:24:07';

/* 특정 날짜/시간 미만 */
SELECT *
FROM payment
WHERE payment_date < '2005-07-09 13:24:07';



/* =====================================================
  12. 논리 연산자 정리
===================================================== */

/*
논리 연산자 종류

AND     : 양쪽 조건이 모두 참일 때 조회
OR      : 한쪽 조건이라도 참이면 조회
NOT     : 조건의 결과를 반대로 처리
IN      : 값이 목록 중 하나라도 포함되면 조회
BETWEEN : 값이 범위 내에 있으면 조회 (양 끝값 포함)
LIKE    : 패턴과 일치하면 조회
EXISTS  : 서브쿼리에 결과가 존재하면 조회
ALL     : 비교 대상 모두가 조건을 만족하면 참
ANY/SOME: 비교 대상 중 하나라도 조건을 만족하면 참
*/



/* =====================================================
  13. BETWEEN 실습
===================================================== */

/* address_id가 5~10 범위에 포함 */
SELECT *
FROM customer
WHERE address_id BETWEEN 5 AND 10;

/* 날짜 범위 조회 (시작/끝 날짜 모두 포함) */
SELECT *
FROM payment
WHERE payment_date BETWEEN '2005-06-17' AND '2005-07-19';

/* 정확한 날짜/시간 조회 */
SELECT *
FROM payment
WHERE payment_date = '2005-07-08 07:33:56';

/* first_name이 M~O 범위에 포함 */
SELECT *
FROM customer
WHERE first_name BETWEEN 'M' AND 'O';

/* first_name이 M~O 범위에 포함되지 않는 데이터 */
SELECT *
FROM customer
WHERE first_name NOT BETWEEN 'M' AND 'O';

/*AND 와 OR를 이용한 데이터 조회하기*/
/*두 조건을 만족하는 데이터 조회*/
select *
from city
where city ='Sunnyvale' and country_id =103;

/*두 개의 비교 연산식을 만족하는 데이터 조회*/
select *
from payment
where payment_date >= '2005-06-01' and payment_date <= '2005-07-05';

/*한 조건을 만족하는 경우 데이터 조회*/
select *
from customer
where first_name = 'MARIA' or first_name = 'LINDA';

/* or를 두개 이상 사용하는 경우*/
select *
from customer
where first_name = 'MARIA' or first_name = 'LINDA' or first_name = 'NANCY';

/*in을 활용한 데이터 조회*/
select *
from customer
where first_name in ('MARIA','LINDA','NANCY');

/*요구사항을 반영해 작성한 쿼리*/
select *
from city
where country_id = 103 or country_id = 86
and city in ('Cheju','Sunnyvale','Dallas');

/*요구사항대로라렴 3개의 행으로 구성된 데이터가 조회대야 하는데 결과는 그렇지 않다. 왜 이런 문제가 발생하는 것일까?
이유는 논리 연산자의 우선순위가 or보다 and가 높기 때문이다. */

/*쿼리 풀이 순서 1*/
select *
from city
where country_id =103;

/*쿼리 풀이 순서2*/
select *
from city
where country_id =86
and city in ('Cheju','Sunnyvale','Dallas');

/*쿼리 순서를 변경*/
select *
from city
where country_id =86 or country_id =103
and city in ('Cheju','Sunnyvale','Dallas');

/*소괄호로 우선순위를 다시 정해 데이터를 조회*/
select *
from city
where (country_id=103 or country_id=86)
and city in ('Cheju','Sunnyvale','Dallas');

/*in,and를 결합하여 조회*/
select *
from city
where country_id in (103,86)
and city in ('Cheju','Sunnyvale','Dallas');

/*NULL데이터 조회하기
데이터베이스에서 테이터를 조회하다 보면 NULL값이 포함된 열을 자주 볼 수 있다.
NULL이란 데이터가 없는 상태를 말한다. 더 풀어 설명하자만 숫자 0, 공백이 아니라 아예정의되지 않은 값을 말한다.*/

/*1. address테이블을 조회해보자 */
/*NULL이 있는 테이블 조회*/
select *
from address;

/*2. NULL은 어떻게 필터링해야할까?*/
/* = 연산자를 사용해 NULL 데이터 조회*/
select *
from address 
where address2 =NULL;

/*3. 이번에는 IS NULL을 사용해 NULL데이터를 조회해보자*/
/*address2 열어서 NULL인 데이터 조회*/
select *
from address
where address2 is null;

/*4. 반대로 null이 아닌 데이터를 조회할 때도 일반 연산자가 아닌 is not null을 사용해 데이터를 조회한다.*/
/*address2열에서 null이 아닌 데이터 조회*/
select *
from address 
where address2 is not null;

/*5. 이번엔 address2에 데이터가 공백인 행을 조회해 보자*/
/*address2 열에서 NULL이 아닌 데이터 조회*/
select *
from address
where address2 = '';

/*order by절로 데이터 정렬하기
order by절의 기본형식
select [열] from [테이블] where [열]=[조건] order by [duf] [asc또는 desc]
1.order by : 조회한 데이터를 정렬하기 위한 구문이다.
2. [열] : 정렬한 열 이름을 입력한다.
3. [asc또는 desc] : 정렬 기준을 정하기 위한 오름차순(asc) 또는 내림차순(desc)를 명시한다.*/

/*order by 절로 열 기준 정렬하기*/
/*1. first_name 열과 last_name열 기준으로 정렬하는 쿼리이다*/
/* first_name 열을 기준으로 정렬*/
select *
from customer
order by first_name;

/*last_name 열을 기준으로 정렬*/
select *
from customer 
order by last_name;

/*2. 2개 이상의 열을 기준으로 정렬할 때는 쉼표를 사용하여 열이름을 나열하면 된다. */
/* store_id,first_name순으로 데이터 정렬*/
select *
from customer
order by store_id,first_name;

/* first_name,store_id순으로 데이터 정렬*/
select *
from customer
order by first_name,store_id;

/*오름차순 또는 내림차순으로 정렬하기*/
/*asc로 데이터 정렬하기*/
/*오른차순으로 정렬하는 방법을 알아보자 . 기본형식에서도 보았듯 asc를 정렬하는 열 이름 뒤에 붙이면 된다.*/
/*first_name 열을 오름차순으로 정렬*/
select *
from customer 
order by first_name asc;

/*desc로 데이터 정렬하기*/
/*first_name열을 내림차순으로 정렬*/
select *
from customer
order by first_name desc;

/* asc와 desc를 조합하여 데이터 정렬하기*/
/*asc와 desc를 조합하여 데이터 정렬하기*/
select *
from customer
order by store_id desc, first_name asc;
