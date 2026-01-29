/*빠른 찾기(CTRL+F) 키워드 목차
아래 태그를 그대로 CTRL+F로 검색하면 해당 파트로 바로 점프 가능
-------------------------------------------------
#DDL_DATABASE 데이터베이스 생성/삭제
#DDL_TABLE 테이블 생성/삭제
#DML_INSERT INSERT 입력
#CONSTRAINT_NOT_NULL NOT NULL
#CONSTRAINT_PK PRIMARY KEY
#DML_UPDATE_SAFE UPDATE + SAFE_UPDATES
#DML_DELETE_SAFE DELETE + SAFE_UPDATES
#SELECT_BASIC SELECT 기본
#WHERE_BASIC WHERE 비교
#WHERE_DATETIME 날짜/시간 조건
#LOGIC_PRECEDENCE AND/OR 우선순위
#BETWEEN_IN BETWEEN / IN
#NULL_FILTER NULL 필터링
#ORDER_LIMIT ORDER BY / LIMIT / OFFSET
#LIKE_ESCAPE LIKE / ESCAPE
#REGEXP REGEXP
#GROUPBY_HAVING GROUP BY / HAVING / ONLY_FULL_GROUP_BY
#DISTINCT DISTINCT
#AUTO_INCREMENT AUTO_INCREMENT
#INSERT_SELECT INSERT INTO SELECT / CTAS
#FOREIGN_KEY FOREIGN KEY
#CHARSET_COLLATION 문자셋/콜레이션
#JOIN_INNER INNER JOIN
#JOIN_OUTER OUTER JOIN
#JOIN_CROSS CROSS JOIN
#JOIN_SELF SELF JOIN
#SUBQUERY_WHERE WHERE 서브쿼리
#SUBQUERY_FROM FROM 서브쿼리
#SUBQUERY_SELECT SELECT(스칼라) 서브쿼리
*/
/* =====================================================
  #DDL_DATABASE 1) DATABASE 생성 / 삭제 (DDL)
===================================================== */
/*
[WHY] 데이터베이스(DB)는 "프로젝트 단위의 큰 저장공간"이다.
[WHEN] 프로젝트/실습 단위로 스키마를 분리하고 싶을 때 사용.
[CAUTION]
- CREATE DATABASE는 이미 존재하면 Error Code: 1007이 날 수 있음.
- 안전하게 하려면 IF NOT EXISTS를 붙인다.
*/

CREATE DATABASE doitsql;      -- DB 생성
USE doitsql;                 -- 앞으로 쿼리 실행할 DB 선택
-- DROP DATABASE doitsql;    -- DB 삭제(주의: 복구 어려움)


/* =====================================================
  #DDL_TABLE 2) TABLE 생성 / 삭제 (DDL)
===================================================== */
/*
[WHY] 테이블은 "행(row)들의 집합"이며, 컬럼(열) 정의가 먼저다.
[WHEN] 데이터를 구조적으로 저장하려면 CREATE TABLE 필요.
[CAUTION]
- 컬럼 타입/길이는 나중 변경(ALTER) 가능하지만 비용이 든다.
*/

CREATE TABLE doit_dml (
  col_1 INT,
  col_2 VARCHAR(50),
  col_3 DATETIME
);
-- DROP TABLE doit_dml;


/* =====================================================
  #DML_INSERT 3) INSERT (데이터 입력)
===================================================== */
/*
[WHY] 데이터를 테이블에 "행 단위"로 넣는다.
[WHEN] 신규 데이터 생성 시.
[CAUTION]
- 컬럼명을 생략하면 테이블 컬럼 순서 그대로 전부 넣어야 한다.
- 타입 불일치(INT에 문자 등)는 에러.
*/

INSERT INTO doit_dml (col_1, col_2, col_3)
VALUES (1, 'DoItSQL', '2023-01-01');

SELECT * FROM doit_dml;

-- (오류 예) col_1은 INT인데 문자열 입력
-- INSERT INTO doit_dml (col_1) VALUES ('문자 입력');

-- 컬럼명 생략: 테이블 정의 순서대로 3개 다 입력해야 함
INSERT INTO doit_dml
VALUES (2, '열이름 생략', '2023-01-02');

-- 일부 컬럼만 입력: 나머지는 NULL
INSERT INTO doit_dml (col_1, col_2)
VALUES (3, 'col_3 값 생략');

-- 컬럼명 명시하면 순서 변경 가능
INSERT INTO doit_dml (col_1, col_3, col_2)
VALUES (4, '2023-01-03', '열순서 변경');

-- 여러 행 한번에 입력
INSERT INTO doit_dml (col_1, col_2, col_3)
VALUES
  (5, '데이터 입력5', '2023-01-03'),
  (6, '데이터입력6', '2023-01-03'),
  (7, '데이터입력7', '2023-01-03');


/* =====================================================
  #CONSTRAINT_NOT_NULL 4) NOT NULL 제약조건
===================================================== */
/*
[WHY] NULL(값 없음)을 허용하지 않게 해서 데이터 품질을 올림.
[WHEN] 반드시 있어야 하는 값(이름, 아이디 등)에 사용.
[CAUTION]
- NOT NULL 컬럼을 INSERT할 때 빠지면 오류 발생.
*/

CREATE TABLE doit_notnull (
  col_1 INT,
  col_2 VARCHAR(50) NOT NULL
);

-- 오류 예: col_2 값 없음
-- INSERT INTO doit_notnull (col_1) VALUES (1);


/* =====================================================
  #CONSTRAINT_PK 5) PRIMARY KEY (기본키)
===================================================== */
/*
[WHY] 행을 유일하게 식별하는 "대표값".
[RULE]
- 중복 불가(UNIQUE)
- NULL 불가(NOT NULL)
[WHEN] 거의 모든 테이블의 id 역할로 사용.
[CAUTION]
- 기존 데이터에 중복/NULL이 있으면 PK 추가 실패 가능.
*/

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE doit_dml
ADD PRIMARY KEY (col_1);


/* =====================================================
  #DML_UPDATE_SAFE 6) UPDATE + Safe Update Mode
===================================================== */
/*
[WHY] 기존 데이터를 수정한다.
[WHEN] 값 변경, 상태 변경(active 등)에 사용.
[CAUTION]
- WHERE 없이 UPDATE하면 전체 행 수정.
- Workbench Safe Update Mode가 켜져있으면 WHERE 없는 UPDATE/DELETE 막힘.
*/

UPDATE doit_dml
SET col_2 = '데이터 수정'
WHERE col_1 = 4;

-- 위험: SAFE_UPDATES 끄면 WHERE 없이도 수정 가능
SET SQL_SAFE_UPDATES = 0;

-- 주의: PK 값을 전체 변경하면 충돌 위험(중복 발생 가능)
UPDATE doit_dml
SET col_1 = col_1 + 10;

SET SQL_SAFE_UPDATES = 1;


/* =====================================================
  #DML_DELETE_SAFE 7) DELETE + Safe Update Mode
===================================================== */
/*
[WHY] 데이터를 삭제한다.
[WHEN] 불필요한 행 제거.
[CAUTION]
- WHERE 없이 DELETE하면 전체 삭제.
*/

DELETE FROM doit_dml
WHERE col_1 = 14;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM doit_dml;  -- 전체 삭제
SET SQL_SAFE_UPDATES = 1;


/* =====================================================
  #SELECT_BASIC 8) SELECT 기본 구조
===================================================== */
/*
[KEYWORD] SELECT 실행 순서(논리적)
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
(실제 실행계획은 다르지만 "이 순서로 결과가 만들어진다"는 감각이 중요)
*/


/* =====================================================
  #WHERE_BASIC 9) WHERE 비교 연산
===================================================== */
USE sakila;

SELECT *
FROM customer
WHERE first_name = 'MARIA';

SELECT *
FROM customer
WHERE address_id < 200;

/*
[NOTE] 문자열 비교는 콜레이션(정렬규칙)에 따라 사전식 비교가 된다.
*/
SELECT *
FROM customer
WHERE first_name < 'MARLA';


/* =====================================================
  #WHERE_DATETIME 10) DATETIME 조건
===================================================== */
/*
[POINT] DATETIME은 'YYYY-MM-DD HH:MM:SS' 형태가 가장 안전.
*/
SELECT *
FROM payment
WHERE payment_date = '2005-07-09 13:24:07';

SELECT *
FROM payment
WHERE payment_date < '2005-07-09 13:24:07';


/* =====================================================
  #LOGIC_PRECEDENCE 11) AND / OR 우선순위
===================================================== */
/*
[KEY] NOT > AND > OR
[WHY] OR와 AND를 섞으면 결과가 의도와 달라질 수 있다.
[BEST] 섞이면 무조건 괄호 ()로 의도를 고정한다.
*/

-- 의도와 다른 결과가 나오는 대표 케이스
select *
from city
where country_id = 103 or country_id = 86
and city in ('Cheju','Sunnyvale','Dallas');

-- 해결: OR 묶기
select *
from city
where (country_id = 103 or country_id = 86)
and city in ('Cheju','Sunnyvale','Dallas');

-- 더 깔끔한 해결: IN 사용
select *
from city
where country_id in (103,86)
and city in ('Cheju','Sunnyvale','Dallas');


/* =====================================================
  #BETWEEN_IN 12) BETWEEN / IN
===================================================== */
/*
[BETWEEN] 양 끝 포함
[IN] 목록 중 하나라도 포함되면 참
*/

SELECT *
FROM customer
WHERE address_id BETWEEN 5 AND 10;

SELECT *
FROM customer
WHERE first_name IN ('MARIA','LINDA','NANCY');


/* =====================================================
  #NULL_FILTER 13) NULL 필터링 (매우 중요)
===================================================== */
/*
[WHY] NULL은 "값이 없음"이라서 비교 연산(=)이 안 먹는다.
[RESULT] address2 = NULL → 항상 UNKNOWN → 결과가 안 나옴
[SOLUTION] IS NULL / IS NOT NULL 사용
*/

select *
from address
where address2 = NULL;      -- ❌ 틀림

select *
from address
where address2 IS NULL;     -- ✅ 맞음

select *
from address
where address2 IS NOT NULL; -- ✅ 맞음

-- 빈 문자열은 NULL이 아님
select *
from address
where address2 = '';


/* =====================================================
  #ORDER_LIMIT 14) ORDER BY / LIMIT / OFFSET
===================================================== */
/*
[ORDER BY] 정렬
- ASC 오름차순(기본)
- DESC 내림차순
[LIMIT] 결과 행 개수 제한
*/

select *
from customer
order by store_id desc, first_name asc
limit 10;

select *
from customer
order by customer_id asc
limit 100, 10;     -- offset 100부터 10개

select *
from customer
order by customer_id asc
limit 10 offset 100; -- 위와 동일 의미


/* =====================================================
  #LIKE_ESCAPE 15) LIKE / ESCAPE
===================================================== */
/*
[LIKE]
- % : 길이 제한 없는 문자열
- _ : 1글자
[ESCAPE]
- %나 _를 "문자 그대로" 검색하고 싶을 때 사용
*/

WITH CTE (col_1) AS(
  SELECT 'A%BC' UNION ALL
  SELECT 'A_BC' UNION ALL
  SELECT 'ABC'
)
SELECT * FROM CTE;

-- % 문자 자체를 검색하려면 ESCAPE
WITH CTE (col_1) AS(
  SELECT 'A%BC' UNION ALL
  SELECT 'A_BC' UNION ALL
  SELECT 'ABC'
)
SELECT * FROM CTE
WHERE col_1 LIKE '%#%%' ESCAPE '#';


/* =====================================================
  #REGEXP 16) REGEXP (정규식)
===================================================== */
/*
[WHY] LIKE보다 더 복잡한 패턴 검색 가능
*/
SELECT * FROM customer WHERE first_name REGEXP '^K|N$';
SELECT * FROM customer WHERE first_name REGEXP 'K[L-N]';
SELECT * FROM customer WHERE first_name REGEXP 'K[^L-N]';


/* =====================================================
  #GROUPBY_HAVING 17) GROUP BY / HAVING / ONLY_FULL_GROUP_BY
===================================================== */
/*
[GROUP BY] 묶어서 집계(Count, Sum, Avg 등)
[HAVING] 그룹 결과를 필터링
[ONLY_FULL_GROUP_BY]
- MySQL 모드에 따라 "SELECT에 있는 비집계 컬럼은 GROUP BY에 포함" 요구
*/

-- 정상: 그룹 기준 컬럼만 SELECT
SELECT rating
FROM film
GROUP BY rating;

-- 정상: 그룹 기준 2개
SELECT special_features, rating
FROM film
GROUP BY special_features, rating;

-- 집계
SELECT special_features, rating, COUNT(*) AS cnt
FROM film
GROUP BY special_features, rating
ORDER BY special_features, rating, cnt DESC;

-- HAVING: 그룹 결과 필터
SELECT special_features, COUNT(*) AS cnt
FROM film
GROUP BY special_features
HAVING cnt > 70;


/* =====================================================
  #DISTINCT 18) DISTINCT
===================================================== */
/*
[WHY] 중복 제거
[NOTE] DISTINCT는 "행 단위"로 중복 제거한다.
*/
SELECT DISTINCT special_features, rating
FROM film;


/* =====================================================
  #AUTO_INCREMENT 19) AUTO_INCREMENT
===================================================== */
/*
[WHY] PK 값을 자동 증가로 생성해서 중복/관리 부담을 줄임.
[NOTE] 중간 숫자를 직접 넣으면 다음 증가값이 영향을 받을 수 있음.
*/

USE doitsql;

CREATE TABLE doit_increment(
  col_1 INT auto_increment primary key,
  col_2 varchar(50),
  col_3 int
);

INSERT INTO doit_increment (col_2,col_3) VALUES ('1 자동입력',1);
INSERT INTO doit_increment (col_2,col_3) VALUES ('2 자동입력',2);

SELECT LAST_INSERT_ID();


/* =====================================================
  #INSERT_SELECT 20) INSERT INTO SELECT / CTAS
===================================================== */
/*
[INSERT INTO ... SELECT]
- 조회 결과를 다른 테이블로 복사/적재할 때 사용
[CTAS]
- CREATE TABLE ... AS SELECT ...
*/

CREATE TABLE doit_insert_select_from (
  col_1 INT,
  col_2 VARCHAR(10)
);

CREATE TABLE doit_insert_select_to (
  col_1 INT,
  col_2 VARCHAR(10)
);

INSERT INTO doit_insert_select_from VALUES (1,'do'),(2,'it'),(3,'mysql');

INSERT INTO doit_insert_select_to
SELECT * FROM doit_insert_select_from;

CREATE TABLE doit_select_new AS
SELECT * FROM doit_insert_select_from;


/* =====================================================
  #FOREIGN_KEY 21) FOREIGN KEY
===================================================== */
/*
[WHY] 부모-자식 관계 데이터 무결성 유지
[RULE]
- 자식 테이블 값은 부모의 PK에 존재해야 한다.
[CAUTION]
- 삭제는 자식 먼저, 부모 나중
*/

CREATE TABLE doit_parent (col_1 int primary key);
CREATE TABLE doit_child (col_1 int);

ALTER TABLE doit_child
ADD FOREIGN KEY (col_1) REFERENCES doit_parent(col_1);

-- insert into doit_child values(1);  -- ❌ 부모에 1 없으면 실패

INSERT INTO doit_parent values(1);
INSERT INTO doit_child values(1);

DELETE FROM doit_child  WHERE col_1=1;
DELETE FROM doit_parent WHERE col_1=1;


/* =====================================================
  #CHARSET_COLLATION 22) 문자셋 / 콜레이션
===================================================== */
/*
[CHARSET] 어떤 문자들을 저장할 수 있는가 (utf8mb4 등)
[COLLATION] 문자열 비교/정렬 규칙(대소문자 구분 여부 등)
*/

SHOW CHARACTER SET;

CREATE TABLE doit_collation (
  col_latin1_ci   VARCHAR(10) COLLATE latin1_general_ci,
  col_latin1_cs   VARCHAR(10) COLLATE latin1_general_cs,
  col_latin1_bin  VARCHAR(10) COLLATE latin1_bin
);


/* =====================================================
  #JOIN_INNER 23) INNER JOIN
===================================================== */
/*
[WHY] 두 테이블에서 "공통으로 매칭되는 행"만 가져옴.
[KEY] ON 조건이 매칭 기준
*/

USE sakila;

SELECT
  a.customer_id, a.first_name, a.last_name,
  b.address_id, b.address, b.district
FROM customer AS a
INNER JOIN address AS b
  ON a.address_id = b.address_id
WHERE a.first_name = 'ROSA';


/* =====================================================
  #JOIN_OUTER 24) OUTER JOIN (LEFT/RIGHT/FULL)
===================================================== */
/*
[LEFT JOIN] 왼쪽 테이블은 전부 유지, 오른쪽이 없으면 NULL
[RIGHT JOIN] 반대
[FULL JOIN] MySQL은 공식 지원 X → UNION으로 구현
*/

SELECT
  a.address, a.address_id, b.store_id
FROM address AS a
LEFT JOIN store AS b
  ON a.address_id = b.address_id
WHERE b.address_id IS NULL;


/* =====================================================
  #JOIN_CROSS 25) CROSS JOIN
===================================================== */
/*
[WHY] 모든 조합(데카르트 곱) 생성
[WHEN] 옵션 조합/샘플 데이터 만들 때
*/

USE doitsql;

CREATE TABLE doit_cross1(num INT);
CREATE TABLE doit_cross2(name VARCHAR(10));

INSERT INTO doit_cross1 VALUES (1),(2),(3);
INSERT INTO doit_cross2 VALUES ('Do'),('It'),('SQL');

SELECT a.num, b.name
FROM doit_cross1 AS a
CROSS JOIN doit_cross2 AS b;


/* =====================================================
  #JOIN_SELF 26) SELF JOIN
===================================================== */
/*
[WHY] 같은 테이블을 두 번 불러서 서로 비교/연결
*/

USE sakila;

SELECT
  a.payment_id, a.amount,
  b.payment_id, b.amount,
  b.amount - a.amount AS diff
FROM payment AS a
LEFT JOIN payment AS b
  ON a.payment_id = b.payment_id - 1;


/* =====================================================
  #SUBQUERY_WHERE 27) WHERE 서브쿼리
===================================================== */
/*
[WHY] 조건값을 다른 조회 결과로부터 얻음
*/

SELECT *
FROM customer
WHERE customer_id = (
  SELECT customer_id
  FROM customer
  WHERE first_name = 'ROSA'
);


/* =====================================================
  #SUBQUERY_FROM 28) FROM 서브쿼리(인라인 뷰)
===================================================== */
/*
[WHY] 서브쿼리를 임시 테이블처럼 만들어 JOIN
*/

SELECT
  a.film_id, a.title, x.name
FROM film AS a
JOIN (
  SELECT b.film_id, c.name
  FROM film_category AS b
  JOIN category AS c ON b.category_id = c.category_id
  WHERE b.film_id > 10 AND b.film_id < 20
) AS x ON a.film_id = x.film_id;


/* =====================================================
  #SUBQUERY_SELECT 29) SELECT 스칼라 서브쿼리
===================================================== */
/*
[WHY] 각 행마다 "추가 정보 컬럼"을 하나 붙이고 싶을 때
[CAUTION] 행마다 서브쿼리 실행될 수 있어 성능 이슈 가능(상황에 따라 JOIN이 더 좋음)
*/

SELECT
  a.film_id,
  a.title,
  (SELECT c.name
   FROM film_category AS b
   JOIN category AS c ON b.category_id = c.category_id
   WHERE b.film_id = a.film_id
   LIMIT 1) AS category_name
FROM film AS a
WHERE a.film_id > 10 AND a.film_id < 20;
