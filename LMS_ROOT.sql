/* 파이썬과 mysql 병합 작업을 위한 sql페이지

-- 절차 일반적으로 system (root)계정은 개발용으로 사용하지 않는다.
-- mysql에 사용할 id와 pw와 권한을 부여하고 db를 생성한다.
*/
/*****************************************************************************/

/* 사용가 계정을 생성한다.*/
CREATE USER 'mbc'@'localhost' IDENTIFIED BY '1234';
/*			 ID     접속IP                     암호 
			'kdh'@'192.168.0.161'           '5687'  -> kdh가 161 주소로 들어옴
            'lhj'@'192.168.0.0%' -> 192.168.0.1~192.168.0.255까지 들어올 수 있음
            'lhj'@'%' -> 전체 IP (외부에서도 접속이 가능 -> 보안에 취약)*/
            
/* 사용자 계정 생성은 ID가 중복되어도 됨 | 대신 접속 PC를 다중처리할 수 있음
CREATE USER 'mbc'@'192.168.0.0%' IDENTIFIED BY '5678';
CREATE USER 'mbc'@'%' IDENTIFIED BY 'Mbc320!!';

/*****************************************************************************/

/* 사용자 계정을 삭제한다.*/
drop user 'mbc'@'localhost';

/*****************************************************************************/

/* mbc 사용자에게 LMS권한을 부여*/
/*1. 데이터베이스를 생성
  2. 계정에 권한을 준다.*/
  
CREATE DATABASE lms
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

  /* lms 데이터베이스를 생성               한국어 지원 utf-8
	COLLATE : 문자 집합에 포함된 문자들을 어떻게 비교하고 정렬할지 정의하는 키워드
    데이터비교시 대소문자구분, 문자 간의 정렬순서, 언어별 특수문자처리 방식지원
    utf8mb4 : 문자집합
    general : 비교규칙(간단한 일반비교)
    ci : Case Insensitive(대소문자 구분하지 않음)
    
    ** COLLATE utf8mb4_bin : 대소문자를 구분함 */
    
/*****************************************************************************/  
 
/* mbc라는 계정에 lms를 사용할 수 있게 권한부여*/
GRANT ALL PRIVILEGES ON LMS.* TO 'mbc'@'localhost';
/*                      DB명. 테이블 ID     접속PC
ALL PRIVILEGES : 모든권한 부여
GRANT select, insert ON LMS.* TO '알바'@'%';
	   READ   CREATE -> 알바생 권한
권한 즉시 반영
FLUSH PRIVILEGES;*/

USE MYSQL; -- MYSQL 최고 DB에 접속
select * from user; -- MYSQL의 사용자 목록을 볼 수 있다. 

/*****************************************************************************/   