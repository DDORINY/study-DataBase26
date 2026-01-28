/* LMS에 대한 테이블을 형성하고 더미테이터 입력(CRUD)*/

SHOW databases; -- LMS만 보인다.
use lms; -- lms 데이터베이스를 사용

/*members 테이블을 생성한다.*/
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
