/*--------------------------------------------------------------------------------------
LMS에 대한 테이블을 생성 /더미테이터 입력(CRUD)
--------------------------------------------------------------------------------------*/
SHOW databases; -- LMS만 보인다.
use lms; -- lms 데이터베이스를 사용

/*--------------------------------------------------------------------------------------
members 테이블 생성
--------------------------------------------------------------------------------------*/
CREATE TABLE members (
/*필드명 타입  옵션*/
    id INT AUTO_INCREMENT PRIMARY KEY,
    /* 정수 자동번호 생성기     기본키* (다른테이블과 연결용)*/
    uid VARCHAR(50) NOT NULL UNIQUE,
    /*  가변문자 50자  공백 비허용 유일한값*/
    password VARCHAR(255) NOT NULL,
    /*       가변문자 225자  공백 비허용*/
    name VARCHAR(50) NOT NULL,
    /*   가변문자 50자  공백 비허용*/
    role ENUM('admin','manager','user') DEFAULT 'user',
    /*   열거타입 (괄호안에 글자만 허용)       기본값은 user */
    active BOOLEAN DEFAULT TRUE,
    /*     불린타입          기본값*/
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    /*생성일     날짜시간타입        기본값은 시스템시간*/
);

/* 더미데이터 입력*/
INSERT INTO members (uid,password,name,role,active)
VALUES ('kkw','1234','김기원','admin',true);


/* 더미데이터 여러 데이서 한 번에 입력*/
INSERT INTO members (uid, password, name, role, active)
VALUES
('kdh','1234','김도하','admin', TRUE),
('lhj','1234','임효정','user', TRUE),
('kdg','1234','김도균','user', TRUE),
('ksb','1234','김수빈','user', TRUE),
('kjy','1234','김지영','user', TRUE);


/* 더미데이터 출력*/
SELECT * FROM members;

/* 로그인 할 때*/
SELECT * FROM members WHERE uid ='kkw' and password ='1234' and active =true;


/* 더미데이터 수정 */
-- UID가 KKW인 경우 password의 값을 1111로 변경한다.
UPDATE members SET password = '1111' WHERE uid = 'kkw';

/*데미데이터 회원삭제|비활성*/
delete from members where uid='kkw'; -- 데이터를 삭제
UPDATE members SET active = false WHERE uid = 'kkw'; -- 데이터 비활성화

drop table scores;
/*--------------------------------------------------------------------------------------
scores 테이블 생성
--------------------------------------------------------------------------------------*/
CREATE TABLE scores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    korean INT NOT NULL,
    english INT NOT NULL,
    math INT NOT NULL,
    total INT NOT NULL,
    average FLOAT NOT NULL,
    grade CHAR(1) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (member_id) REFERENCES members(id)
    -- 외래키생성   나의 필드와   연결        테이블   필드
);

/* 후보키 | 공백이 없고 유일해야 되는 필드들 ex) 주민번호, 이메일, 학번, ID ...
PRIMARY KEY | 기본키로 공백이 없고, 유일해야 되고, 인덱싱이 되어 있는 옵션
인덱싱 | DB에서 빠른 찾기를 위한 옵션 
왜래키 | 다른 테이블과 연결이되는 키 ex) FOREIGN KEY 
왜래키는 자식이고 기본키는 부모이다.
members가 부모 ->kkw 계정이 있어야 scores 테이블에 kkw 점수를 넣을 수 있다. 
members 테이블의 id 와 scores 테이블의 member_id는 타입이 일치해야한다. */


/*성적 더미데이터 입력*/
INSERT INTO scores (member_id, korean, english, math, total, average, grade)
VALUES
(2, 99, 99, 99, 297, 99, 'A'),
(8, 88, 88, 88, 264, 88, 'B'),
(9, 77, 77, 77, 231, 77, 'C'),
(10, 66, 66, 66, 198, 66, 'F'),
(11, 80, 80, 80, 240, 80, 'B'),
(12, 90, 90, 90, 270, 90, 'A');

/*더미데이터 확인*/
SELECT *
FROM scores;

/*기본 정보 조회
성적 데이터가 존재하는 회원만 조회합니다. 
이름, 과목 점수, 평균 등급을 가져오는 쿼리.*/

SELECT
    m.name   AS 이름,
    m.uid    AS 아이디,
    s.korean AS 국어,
    s.english AS 영어,
    s.math   AS 수학,
    s.total  AS 총점,
    s.average AS 평균,
    s.grade  AS 등급
FROM members m
-- Aliasing (별칭) : members m 처럼 테이블 이름 뒤에 한 글자 별칭을 주면 쿼리가 훨씬 간결해짐.
JOIN scores s ON m.id = s.member_id;
-- ON 조건 :  m.id = s.member_id 와 같은 두 테이블을 연결하는 핵심 키 (PK-FK)를 정확히 지정.alter

DELETE FROM scores WHERE member_id = 2;

/*성적이 없는 회원도 포함 조회 (LEFT JOIN)
성적표가 아직 작성되지 않은 회원까지 모두 포함하여 명단을 만들 때 사용한다. 성적이 없으면 NULL로 표시된다.*/

SELECT
    m.name AS 이름,
    m.role AS 역할,
    s.average AS 평균,
    s.grade AS 등급,
    IFNULL(s.grade, '미산출') AS 상태
FROM members m
LEFT JOIN scores s ON m.id = s.member_id;
/*--------------------------------------------------------------------------------------
boards 테이블 생성
--------------------------------------------------------------------------------------*/

CREATE TABLE boards (
	id int auto_increment primary key,
    member_id int not null,
    title varchar(200) not null,
    content text not null,
    created_at datetime default current_timestamp,
    
    foreign key (member_id) references members(id)
    );

insert into boards (member_id, title, content)
values 
(2,'제목1','내용1'),
(8,'제목2','내용2'),
(9,'제목3','내용3'),
(10,'재목4','내용4'),
(11,'제목5','내용5'),
(12,'제목6','내용6'),
(8,'제목7','내용7');

SELECT *
FROM boards;

/*게시글 목록 조회 (INNER JOIN)*/
SELECT 
	b.id AS 번호,
    b.title AS 제목,
    m.name AS 이름, -- members 테이블에서 가져옴
    b.created_at AS 작성일
FROM boards b
INNER JOIN members m ON b.member_id = m.id
order by b.created_at desc; -- 최신글 순으로 정렬

/*특정 사용자의 글만 조회 (WHERE 절 조합)*/
SELECT
	b.title,
    b.content,
    m.name as 작성자, -- members 테이블에서 가져옴
    b.created_at
FROM boards b
JOIN members m ON b.member_id = m.id
WHERE m.uid = 'kdh'; -- 특정 아이디를 가진 유저의 글만 필터링

/*관리자용 : 통계조회(GROUP BY 조합)*/
SELECT
	m.name,
    m.uid,
    COUNT(b.id) as 작성글수 -- GROUP BY와 세트
FROM members m
LEFT JOIN boards b ON m.id = b.member_id
GROUP BY m.id;
	
/*작성자 이름으로 검색하기 (LIKE 활용)*/
SELECT
	b.id AS 글번호,
    b.title AS 제목,
    m.name AS 작성자,
    b.created_at AS 작성일
FROM boards b
INNER JOIN members m ON b.member_id =m.id
WHERE m.name LIKE '%도하%'
order by b.created_at desc;
/*WHERE m.name LIKE '%검색어%' or b.title LIKE '%검색어%'*/

/*--------------------------------------------------------------------------------------
items 테이블 생성
--------------------------------------------------------------------------------------*/
CREATE TABLE items (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    code      VARCHAR(20) NOT NULL UNIQUE,
    name      VARCHAR(100) NOT NULL,
    category  ENUM('잡화','음료','IT','도서') NOT NULL,
    price     INT NOT NULL,
    stock     INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

/*더미 데이터 입력*/
INSERT INTO items (code,name, category,price,stock)
values
('kkk','아이스커피','음료',5000,60),
('QQQ', '맥심커피','음료',1000,30),
('WWW','노트북','IT', 500000, 20),
('EEE','모니터','IT', 300000, 50),
('TTT','파이썬','도서', 30000, 80),
('AAA','공책','잡화', 1000, 55),
('SSS','데이터베이스','도서', 23000, 70);

SELECT * FROM items;

/*--------------------------------------------------------------------------------------
orders 테이블 생성
--------------------------------------------------------------------------------------*/
CREATE TABLE orders ( # 주문용 테이블
    id        INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    status    ENUM('PAID','REFUND_REQ','REFUNDED','CANCELED') DEFAULT 'PAID',
    #               결재완료   환불대기        환불됨       취소됨
    total_price INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (member_id) REFERENCES members(id)
);

INSERT INTO orders (member_id, status,total_price)
values
(2,'PAID',60000),
(8,'PAID',60000),
(9,'REFUND_REQ',70000),
(10,'REFUND_REQ',70000),
(11,'REFUNDED',80000),
(12,'CANCELED',90000);

SELECT * FROM orders;

/*--------------------------------------------------------------------------------------
order_items 테이블 생성 (주문내역 테이블)
--------------------------------------------------------------------------------------*/
CREATE TABLE order_items (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    order_id  INT NOT NULL,
    item_id   INT NOT NULL,
    qty       INT NOT NULL,
    price     INT NOT NULL,

    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (item_id) REFERENCES items(id)
);

/*더미데이터 입력*/
INSERT INTO order_items (order_id, item_id,qty,price)
values
(1, 1, 12, 50000),
(2, 3, 20, 80000),
(3, 6, 15, 80000),
(4, 7, 8, 88600);

SELECT * FROM order_items;