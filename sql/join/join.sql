/*조인의 종류*/
/*INNER JOIN의 기본형식
SELECT
	[열]
FROM [테이블 1]
	INNER JOIN [테이블 2] ON [테이블 1.열] =[테이블2. 열]
WHERE [검색조건]*/

/*INNER JOIN을 적용한 예
SELECT
	[고객. 고객번호],[고객. 고객이름],[주문.주문번호],[주문. 고객번호],[주문.주문날짜]
FROM [고객]
	INNER JOIN [주문] ON [고객.고객번호] =[주문.고객번호]*/
    
/*INNER JOIN으로 테이블 2개 조인하기*/
/*내부 조인한 테이블에서 조건에 맞는 데이터 조회*/
USE sakila;
SELECT
	a.customer_id,
    a.store_id,
    a.first_name,
    a.last_name,
    a.email,
    a.address_id AS a_address_id,
    b.address_id AS b_address_id,
    b.address,
    b.district,
    b.city_id,
    b.postal_code,
    b.phone,
    b.location
FROM customer AS a
	INNER JOIN address AS b ON a.address_id =b.address_id
WHERE a.first_name = 'ROSA';

/*INNER JOIN에 조인 조건 2개 이상 사용하기*/
/*2개의 조인 조건으로 조인한 테이블에서 조건에 맞는 데이터 조회*/
SELECT
	a.customer_id,
    a.first_name,
    a.last_name,
    b.address_id,
    b.address,
    b.district,
    b.postal_code
FROM customer AS a
	INNER JOIN address AS b ON a.address_id =b.address_id AND a.create_date =b.last_update
WHERE a.first_name ='RASA';

/*INNER JOIN으로 테이블 3개 이상 조인하기
테이블 3개 이상일때 INNER JOIN의 기본형식
SELECT 
	[열]
FROM [테이블 1]
	INNER JOIN [테이블 2] ON [테이블1.열] =[테이블2. 열]
    INNER JOIN [테이블 3] ON [테이블2.열] =[테이블3. 열]
WHERE [검색조건]
*/

/*3개의 테이블을 조인한 테이블에서 조건에 맞는 데이터 조회*/
SELECT
	a.customer_id,
    a.first_name,
    a.last_name,
    b.address_id,
    b.address,
    b.district,
    b.postal_code,
    c.city_id,
    c.city
FROM customer AS a
	INNER JOIN address AS b ON a.address_id =b.address_id
    INNER JOIN city AS c ON b.city_id = c.city_id
WHERE a.first_name ='ROSA';

/*외부조인
OUTER JOIN 기본형식
SELECT
	[열]
FROM [테이블 1]
	[LEFT|RIGHT|FULL] OUTER JOIN [테이블2]ON [테이블1.열] =[테이블2.열]
    WHERE [검색조건]*/

/*LEFT OUTER JOIN으로 외부 조인하기*/
/*LEFT OUTER JOIN을 적용한 예
SELECT 
	[고객.고객번호],[고객.고객이름],[주문.주문번호],[주문.고객번호],[주문.주문날짜]
FROM [고객]
	LEFT OUTER JOIN [주문] ON [고객.고객번호] =[주문.고객번호]*/

/*LEFT OUTER JOIN한 결과 조회*/
SELECT
	a.address,
    a.address_id AS a_address_id,
    b.address_id AS b_address_id,
    b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id = b.address_id;
    
/*LEFT OUTER JOIN 으로 조회한 결과에서 NULL만 조회*/
SELECT
	a.address,
    a.address_id AS a_address_id,
    b.address_id AS b_address_id,
    b.store_id
FROM address AS a
	LEFT OUTER JOIN store AS b ON a.address_id =b.address_id
WHERE b.address_id IS NULL;

/*RIGHT OUTER JOIN한 결과조회 */

SELECT
	a.address,
	a.address_id AS a_address_id,
	b.address_id AS b_address_id,
	b.store_id
FROM address AS a
	RIGHT OUTER JOIN store AS b ON a.address_id = b.address_id;
    
/*RIGHT OUTER JOIN으로 조회한 결과에서 NULL만 조회*/
SELECT 
	a.address_id AS a_address_id, a.store_id,
    b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;

/*FULL OUTER JOIN으로 외부 조인하기*/
SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	LEFT OUTER JOIN address AS b ON a.address_id = b.address_id

UNION

SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a	
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id;

/*FULL OUTER JOIN으로 조회한 결과에서 NULL만 조회*/
SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	LEFT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE b.address_id IS NULL

UNION

SELECT
	a.address_id AS a_address_id, a.store_id,
	b.address, b.address_id AS b_address_id
FROM store AS a
	RIGHT OUTER JOIN address AS b ON a.address_id = b.address_id
WHERE a.address_id IS NULL;

/*교차조인
CORSS JOIN의 기본형식
SELECT [열]
FROM [테이블 1]
	CROSS JOIN [테이블2]
WHERE [검색조건]*/

/* 샘플 데이터 생성*/
CREATE TABLE doit_cross1(num INT);
CREATE TABLE doit_cross2(name VARCHAR(10));

INSERT INTO doit_cross1 VALUES (1), (2), (3);
INSERT INTO doit_cross2 VALUES ('Do'), ('It'), ('SQL');

/*CROSS JOIN을 적용한 쿼리*/
SELECT
	a.num, b.name
FROM doit_cross1 AS a
	CROSS JOIN doit_cross2 AS b
ORDER BY a.num;

/*WHERE 절을 사용한 CROSS JOIN*/
SELECT
	a.num, b.name
FROM doit_cross1 AS a
	CROSS JOIN doit_cross2 AS b
WHERE a.num = 1;

/*셀프조인*/

/*SELF JOIN을 적용한 쿼리1*/
SELECT 
	a.customer_id AS a_customer_id, b.customer_id AS b_customer_id
FROM customer AS a
	INNER JOIN customer AS b ON a.customer_id = b.customer_id;
    
/*SELF JOIN을 적용한 쿼리2*/
SELECT
	a.payment_id, a.amount, b.payment_id, b.amount, b.amount - a.amount AS profit_amount
FROM payment AS a
	LEFT OUTER JOIN payment AS b ON a.payment_id = b.payment_id -1;

/*쿼리 안에 또 다른 쿼리,서브 쿼리
서브쿼리의 특징
01. 서브쿼리는 반드시 소괄호로 감싸 사용한다. 
02. 서브 쿼리는 주 쿼리를 실행하기 전에 1번만 실행된다.
03. 비교 연산자와 함게 서브 쿼리를 사용하는 경우 서브쿼리를 연산자 오른쪽에 기술해야한다. 
04. 서브 쿼리 내부에는 정렬 구문인 ORDER BY 절을 사용할 수 없다.*/

/*WHERE 절에 서브 쿼리 사용하기
단일 행 서브 쿼리 사용하기 기본형식
SELECT [열]
FROM [테이블]
WHERE [열] =  (SELECT [열] FROM [테이블])*/

/*단일 행 서브 쿼리 적용*/
SELECT *
FROM customer
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name ='ROSA');

/*다중행 서브 쿼리 사용하기 
IN을 활용한 다중 행 서브 쿼리의 기본형식
SELECT [열]
FROM [테이블]
WHERE [열] IN (SELECT[열] FROM [테이블]) */

/*IN을 활용한 다중 행 서브 쿼리 적용 1*/
SELECT * FROM customer
WHERE first_name IN ('ROSA','ANA');

/*IN을 활용한 다중 행 서브 쿼리 적용 2*/
SELECT * FROM customer
WHERE customer_id IN (SELECT customer_id FROM customer WHERE first_name IN ('ROSA','ANA'));

/*테이블 3개를 조인하는 쿼리*/
SELECT
	a.film_id, a.title
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
    INNER JOIN category AS c ON b.category_id = c.category_id
WHERE c.name ='Action';

/*IN을 활용한 서브 쿼리 적용*/
SELECT
	film_id, title
FROM film
WHERE film_id IN (
	SELECT a.film_id
	FROM film_category AS a
		INNER JOIN category AS b ON a.category_id = b.category_id
	WHERE b.name = 'Action'
	);
    
/*NOT IN을 활용한 서브 쿼리 적용*/
SELECT
	film_id, title
FROM film
WHERE film_id NOT IN(
	SELECT a.film_id
	FROM film_category AS a
		INNER JOIN category AS b ON a.category_id = b.category_id
	WHERE b.name = 'Action');
    
/* = ANY를 활용한 서브 쿼리 적용*/
SELECT * FROM customer
WHERE customer_id = ANY (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

/* < ANY를 활용한 서브쿼리 적용*/
SELECT * FROM customer
WHERE customer_id < ANY (SELECT customer_id FROM customer WHERE first_name IN ('ROSA','ANA'));

/* > ANY를 활용한 서브 쿼리 적용*/
SELECT * FROM customer
WHERE customer_id > ANY (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

/*EXISTS를 활용한 서브 쿼리 적용: TRUE를 반환하는 경우*/
SELECT * FROM customer
WHERE EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('ROSA', 'ANA'));

/*EXISTS를 활용한 서브 쿼리 적용: FALSE를 반환하는 경우*/
SELECT * FROM customer
WHERE EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('KANG'));

/*OT EXISTS를 활용한 서브 쿼리 적용: TRUE를 반환하는 경우*/
SELECT * FROM customer
WHERE NOT EXISTS (SELECT customer_id FROM customer WHERE first_name IN ('KANG'));

/*ALL을 활용한 서브 쿼리 적용*/
SELECT * FROM customer
WHERE customer_id = ALL (SELECT customer_id FROM customer WHERE first_name IN ('ROSA','ANA'));

/*FROM 절에 서브 쿼리 사용하기*/
/*기본형식
SELECT
	[열]
FROM [테이블] AS a
	INNER JOIN (SELECT [열] FROM [테이블] WHERE [열] = [값]) AS b ON [a.열] =[ㅠ.duf]
WHERE [열] = [값]*/

/*테이블 조인*/
SELECT
	a.film_id, a.title, a.special_features, c.name
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id =b.film_id
    INNER JOIN category AS c ON b.category_id = c.category_id
WHERE a.film_id > 10 AND a.film_id < 20;

/*FROM절에 서브 쿼리 적용*/
SELECT
	a.film_id, a.title, a.special_features, x.name
FROM film AS a
INNER JOIN (
	SELECT
		b.film_id, c.name
	FROM film_category AS b
		INNER JOIN category AS c ON b.category_id = c.category_id
	WHERE b.film_id > 10 AND b.film_id < 20
	) AS x ON a.film_id = x.film_id;
    
/*SELECT 절에 서브 쿼리 사용하기
스칼라 서브 쿼리의 기본형식
SELECT
	[열], (SELECT <집계 함수> [열] FROM [테이블2]
    WHERE [테이블 2.열]=[테이블1.열]) AS a
From [테이블1]
WHERE [조건]*/

/*테이블 조인*/
SELECT
	a.film_id, a.title, a.special_features, c.name
FROM film AS a
	INNER JOIN film_category AS b ON a.film_id = b.film_id
	INNER JOIN category AS c ON b.category_id = c.category_id
WHERE a.film_id > 10 AND a.film_id < 20;

/*SELECT 절에 서브 쿼리 적용*/
SELECT
	a.film_id, a.title, a.special_features, (SELECT c.name FROM film_category as
	b INNER JOIN category AS c ON b.category_id = c.category_id WHERE a.film_id =
	b.film_id) AS name
FROM film AS a
WHERE a.film_id > 10 AND a.film_id < 20;
