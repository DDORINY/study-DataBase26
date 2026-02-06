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

/* DESC로 데이터 정렬하기 */
/* first_name열을 내림차순으로 정렬*/
SELECT *
FROM customer ORDER BY first_name DESC;

/* ASC와 DESC를 조합하여 데이터 정렬하기 */
SELECT * FROM customer order by store_id DESC, first_name ASC;

/* LIMIT으로 상위 데이터 조회하기*/
/* LIMIT으로 상위 10개의 데이터 조회*/
SELECT * FROM customer order by store_id DESC,first_name asc limit 10;

/* LIMIT으로 101번째부터 10개의 데이터 조회*/
select * from customer order by customer_id asc limit 100,10;

/*OFFSET으로 특정구간의 데이터조회하기*/
/*데이터 100개 건너뛰고 101번쨰부터 데이터 10개 조회*/
select * from customer order by customer_id asc limit 10 offset 100;

/*와일카드로 문자열조회하기*/
/*LIKE와 %로 특정 문자열을 포함하는 데이터 조회*/
/*첫번째 글자가 A로 시작하는 데이터 조회*/
select * from customer where first_name like 'A%';

/*첫번째 글자가 AA로 시작하는 데이터 조회*/
select * from customer where first_name like 'AA%';

/* A로 끝나는 모든 데이터 조회*/
select * from customer where first_name like '%A';

/* RA로 끝나는 모든 데이터 조회*/
select * from customer where first_name like '%RA';

/* A를 포함하는 모든 데이터 조회*/
select * from customer where first_name like '%A%';

/*첫번째 글자가 A로 시작하지 않는 데이터 조회*/
select * from customer where first_name not like 'A%';

/*ESCAPE로 특수문자를 포함한 데이터 조회*/
/* 특수 문자를 포함한 임의의 테이블 생성*/
WITH CTE (col_1) AS(
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)

SELECT * FROM CTE;

/* 특수문자%를 포함한 데이터 조회*/
WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)

SELECT *FROM CTE WHERE col_1 LIKE '%';

/* ESCAPE특수문자%를 포함한 데이터 조회*/
WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)

SELECT *FROM CTE WHERE col_1 LIKE '%#%%' ESCAPE '#';

/* ESCAPE와 !로 특수문자%를 포함한 데이터 조회*/
WITH CTE (col_1) AS (
SELECT 'A%BC' UNION ALL
SELECT 'A_BC' UNION ALL
SELECT 'ABC'
)

SELECT *FROM CTE WHERE col_1 LIKE '%!%%' ESCAPE '!';

/*LIKE와 _로 길이가 정해진 데이터 조회하기*/
/*A로 시작하면서 문자열 길이가 2인 데이터 조회*/
SELECT * FROM customer WHERE first_name LIKE 'A_';

/*A로 시작하면서 문자열 길이가 3인 데이터 조회*/
SELECT *FROM customer WHERE first_name LIKE 'A__';

/*A로 끝나면서 문자열 길이가 3인 데이터 조회*/
SELECT * FROM customer WHERE first_name LIKE 'A__A';

/*문자열의 길이가 5인 데이터 조회*/
SELECT * FROM customer WHERE first_name LIKE '_____';

/*_과 %로 문자열 조회하기*/
/*A_R로 시작하는 문자열 조회*/
SELECT *FROM customer WHERE first_name LIKE 'A_R%';

/*_R로 시작하는 문자열 조회*/
SELECT *FROM customer WHERE first_name LIKE '__R%';

/*A로 시작하면서 R_로 끝나는 문자열 조회*/
SELECT * From customer WHERE first_name LIKE 'A%R_';

/*REGEXP로 더 다양한 데이터 조회하기*/
/*. 줄 바꿈 문자 \n를 제외한 임의의 한 문자를 의미한다. 
* 해당 문자 패턴이 0번 이상 반복한다. 
+ 해당문자 패턴이 1번 이상 반복한다. 
^ 문자열의 처음을 의미한다. 
$ 문자열의 끝을 의미한다. 
| or을 의미한다. 
[...] 대괄호 ([])안에 있는 어떠한 문자를 의미한다. 
[^...] 대괄호 ([])안에 있는 않은 어떠한 문자를 의미한다.
{n} 반복되는 횟수를 지정한다. 
{m,n} 반복되는 횟수의 최솟값과 최댓값을 지정한다. */

/*^,|,$를 사용해 데이터 조회*/
SELECT * FROM customer WHERE first_name REGEXP '^K|N$';

/*[...]를 사용해 데이터를 조회*/
SELECT * FROM customer WHERE first_name REGEXP 'K[L-N]';

/*[^...]를 사용해 데이터를 조회*/
SELECT * FROM customer WHERE first_name REGEXP 'K[^L-N]';

/*와일드카드 더 활용해 보기*/
/*%와 [...]을 사용해 데이터 조회*/
SELECT * FROM customer WHERE first_name LIKE 'S%' AND first_name REGEXP 'A[L-N]';

/*와잍드카드 조합으로 데이터 조회*/
SELECT * FROM customer WHERE first_name Like '_______'
	AND first_name REGEXP 'A[L-N]'
    AND first_name REGEXP 'O$';
    
/*GROUP BY 절로 데이터 묶기*/
/*테이터 그룹에 특정 조건을 필터링해 필요한 데이터를 조회하는 경우도 있다.
GROUP BY전과 HAVING절의 기본형식
SELECT [열] FROM [테이블] WHERE [열] = [조건값] GROUP BY [열] HAVING [열] = [조건값]*/

/*GROUP BY 절로 데이터 그룹화하기*/
/*하나의 열을 기준으로 그룹화하기*/
/*special features열의 데이터를 그룹화*/
SELECT special_features FROM film GROUP BY special_features;

/*rating열의 데이터 그룹화*/
SELECT rating FROM film GROUP BY rating;

/*2개 이상의 열을 기준으로 그룸화하기*/
/*special_features,rating 열 순서로 데이터를 그룹화*/
SELECT special_features, rating FROM film GROUP BY special_features, rating;

/*rating, special_features 열 순서로 데이터 그룹화*/
SELECT rating,special_features FROM film GROUP BY special_features, rating;

/*COUNT 로 그룹화한 열의 데이터 개수 세기*/
/*COUNT 함수로 그룹에 속한 데이터 개수 세기*/
SELECT special_features, COUNT(*) AS cnt FROM film GROUP BY special_features;

/*두 열의 데이터 그룹에 속한 데이터 개수 세기*/
SELECT special_features, rting, COUNT(*) AS cnt FROM film
group by special_features, rting order by special_features, rting, cnt DESC;
 
 /*sELECT 문과 GROUP BY절의 열 이름을 달리할 경우*/
 SELECT special_features, rating, COUNT(*) AS cnt FRom film GROUP BY rating;
 /* Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 
 'sakila.film.special_features' which is not functionally dependent on columns in GROUP BY clause; this is 
 incompatible with sql_mode=only_full_group_by	
 
 오류 내용은 SELECT 문에 사용된 열이 GROUP BY에 명시되지 않아 열을 그룹화할 수 없다는 의미*/
 
 /*HAVING 절로 그룹화한 데이터 필터링하기*/
 /*rating 열을 기준으로 그룹화한 뒤, rating 열에서 G인 데이터만 필터링해보자!
 rating 열에서 G인 데이터 필터링*/
SELECT special_features, rating
FROM film
GROUP BY special_features, rating
HAVING rating = 'G';

/*special_features 열에서 데이터 개수가 70보다 큰 것만 필터링*/
SELECT special_features, COUNT(*) AS cnt 
FROM film
GROUP BY special_features
HAVING cnt > 70;

/*DISTINCT로 중복된 데이터 제거하기*/
/*DISTINCT의 기본형식
SELECT DISTINCT [열] FROM [테이블]*/

/*두 열의 데이터 중복제거*/
SELECT DISTINCT special_features, rating From film;

/*GROUP BY 절로 두 열을 그룹화한 경우*/
SELECT special_features, rating FROM film
GROUP BY special_features,rating;

/*AUTO_INCREMENT로 데이터 자동입력하기*/
/*첫번쨰 열에서 AUTO_INCREMENT 적용*/
USE doitsql;

CREATE TABLE doit_increment(
col_1 INT auto_increment primary key,
col_2 varchar(50),
col_3 int);

insert into doit_increment (col_2,col_3) values ('1 자동입력',1);
insert into doit_increment (col_2,col_3) values ('2 자동입력',2);
select *from doit_increment;

/*자동 입력된 값과 동일한 값을 입력하는 경우*/
insert into doit_increment (col_1,col_2,col_3) values (3,'3 자동입력',3);
select *from doit_increment;

/*자동입력되는 값보다 큰 값을 입력한 경우*/
insert into doit_increment (col_1,col_2,col_3) values (5,'4를 건너뛰고 5자동입력',5);
select *from doit_increment;

/*1열을 제외하고 데이터 입력한 경우*/
insert into doit_increment (col_2,col_3) values ('어디까지 입력되었을까?',0);
select *from doit_increment;

/*AUTO_INCREMENT로 자동 생성된 마지막 값 확인하기*/
/*AUTO_INCREMENT가 적용된 열의 마지막 데이터 조회*/
SELECT LAST_INSERT_ID();

/*AUTO_INCREMENT 시작값 변경하기*/
/*자동으로 입력되는 값을 100부터 시작*/
ALTER TABLE doit_increment AUTO_INCREMENT = 100;
INSERT INTO doit_increment (col_2,col_3) values('시작값이 변경되었을까?',0);

/*AUTO_INCREMENT 증갓값 변경하기*/
/*자동으로 입력되는 값이 5씩 증가*/
SET @@AUTO_INCREMENT_INCREMENT =5;
INSERT INTO doit_increment (col_2,col_3) values('5씩 증가할까?(1)',0);
INSERT INTO doit_increment (col_2,col_3) values('5씩 증가할까?(2)',0);
select *from doit_increment;

/*조회결과를 테이블에 입력하기*/
/*조회결과를 다른 테이블에 입력하기*/
/*INSERT INTO와 SELECT로 다른 테이블에 결과 입력*/
CREATE TABLE doit_insert_select_from (
    col_1 INT,
    col_2 VARCHAR(10)
);

CREATE TABLE doit_insert_select_to (
    col_1 INT,
    col_2 VARCHAR(10)
);

insert into doit_insert_select_from values(1,'do');
insert into doit_insert_select_from values(2,'it');
insert into doit_insert_select_from values(3,'mysql');

insert into doit_insert_select_to
SELECT * FROM doit_insert_select_from;

SELECT * FROM doit_insert_select_to;

/*새 테이블에 조회결과 입력하기*/
/*CREATE TABLE로 새 테이블에 결과입력*/
CREATE TABLE doit_select_new AS (SELECT * FROM doit_insert_select_from);
SELECT *FROM doit_select_new;

/*외래어로 연결되어 있는 테이블 조작하기*/
/*외래키로 연결되어 있는 테이블에 데이터 입력 및 삭제하기*/
/*부모 테이블과 자식테이블 생성*/
CREATE TABLE doit_parent (col_1 int primary key);
create table doit_child (col_1 int);
alter table doit_child
add foreign key (col_1)references doit_parent(col_1);

/*자식테이블에 데이터 입력 시 부모 테이블에 해당 데이터가 없는 경우*/
insert into doit_child values(1);
/*Error Code: 1452. Cannot add or update a child row: 
a foreign key constraint fails (`doitsql`.`doit_child`,
 CONSTRAINT `doit_child_ibfk_1` FOREIGN KEY (`col_1`) 
 REFERENCES `doit_parent` (`col_1`)
 
 
 오류 내용 : doit_child 테이블에 doit_parent테이블의 col_1에 대해서 외래키가 설정되어 있어 참조 오류가 발생*/
 
 /*부모테이블에 데이터 입력 후 자식 테이블에도 데이터 입력*/
 insert into doit_parent values (1);
 insert into doit_child values (1);
 
 select * from doit_parent;
 select * from doit_child;
 
 /*자식테이블의 데이터 삭제 후 부모 테이블의 데이터 삭제*/
 DELETE FROM doit_child WHERE col_1=1;
 DELETE FROM doit_parent WHERE col_1=1;
 
 /*외래어로 연결되어 있는 테이블 삭제*/
 /*하위 테이블 삭제 후 상위 텝이블 삭제*/
 DROP TABLE doit_child;
 drop table doit_parent;
 

 /*부모 테이블 생성 후 제약 조건 확인*/
CREATE TABLE doit_parent (col_1 INT PRIMARY KEY);
create table doit_child (col_1 int);
alter table doit_child add foreign key (col_1) references doit_parent(col_1);

/*제약 조건 제거 후 상위 테이블 삭제*/
alter table doit_child
drop constraint doit_child_ibfk_1;

drop table doit_Parent;

/*MySQL의 데이터 유형 정리하기*/
/*실수형 데이터가 있는 테이블 생성*/
USE doitsql;
CREATE TABLE doit_float (col_1 FLOAT);
INSERT INTO doit_float VALUES (0.7);

SELECT *
FROM doit_float 
WHERE col_1 =0.7;

/*암시적 형 변환으로 계산 결과과 출력된 예*/
SELECT 10/3;

/*문자형 알아보기*/
/*문자열 데이터의 길이와 크기 확인*/
USE doitsql;
CREATE TABLE doit_char_varchar (
col_1 CHAR(5),
col_2 VARCHAR(5)
);

INSERT INTO doit_char_varchar VALUES ('12345','12345');
INSERT INTO doit_char_varchar VALUES ('ABCDE','ABCDE');
INSERT INTO doit_char_varchar VALUES ('가나다라마','가나다라마');
INSERT INTO doit_char_varchar VALUES ('hello','안녕하세요');

SELECT
col_1, CHAR_LENGTH(col_1) as char_length, LENGTH(col_1) AS char_byte,
col_2, CHAR_LENGTH(col_2) as char_length, LENGTH(col_2) AS char_byte
from doit_char_varchar;

/*문자 집합*/
/*MYSQL의 문자 집합 확인*/
SHOW CHARACTER SET;

/*콜레이션에 따른 정렬순서 비교를 위한 테이블 생성*/
CREATE TABLE doit_collation (
  col_latin1_ci   VARCHAR(10) COLLATE latin1_general_ci,
  col_latin1_cs   VARCHAR(10) COLLATE latin1_general_cs,
  col_latin1_bin  VARCHAR(10) COLLATE latin1_bin
);

INSERT INTO doit_collation VALUES ('a','a','a');
INSERT INTO doit_collation VALUES ('b','b','b');
INSERT INTO doit_collation VALUES ('A','A','A');
INSERT INTO doit_collation VALUES ('B','B','B');
INSERT INTO doit_collation VALUES ('*','*','*');
INSERT INTO doit_collation VALUES ('_','_','_');
INSERT INTO doit_collation VALUES ('!','!','!');
INSERT INTO doit_collation VALUES ('1','1','1');
INSERT INTO doit_collation VALUES ('2','2','2');

/*콜라레이션에 따른 정렬 순서 확인*/
SELECT col_latin1_ci  FROM doit_collation ORDER BY col_latin1_ci;
SELECT col_latin1_cs  FROM doit_collation ORDER BY col_latin1_cs;
SELECT col_latin1_bin FROM doit_collation ORDER BY col_latin1_bin;

/*데이터 유형에 따른 현재 시간 조회*/
CREATE TABLE date_table (
justdate DATE,
justtime TIME,
justdatetime datetime,
justfimeeamp TIMESTAMP);

INSERT INTO date_table VALUES (now(),now(),now(),now());
select *from date_table;
