# DataBase26
데이터 베이스 학습용( mySQL)

mySQL설치를 진행한다.
https://dev.mysql.com/downloads/mysql(LTS 버전을 선택한다.)

mySQL 설치중 오류가 발생하면 vs code 라이브러리 설치 
구글검색 :visual c++ Redistributable v14(vc_redist.x64.exe)필요

mySQL관련 프로그램을 설치한다.
https://dev.mysql.com/downloads/workbench/

```
-정의 : 데이터 베이스는 자료를 24시간 365일동안 보관하며, 서비스를 제공함

-DBMS : 데이터베이스 프로그램 (오라클/ mySQL/ MARIADB/SQLITE….)

-SQL :structured(구조화된) Query(절의) Language(언어) 표준화된 문법

- 정의어 | DDL:Data Definition Language
   	  ㄴ 데이터베이스, 테이블, 사용자, 뷰, 인덱스, 스키마 생성/수정/ 삭제
  ㄴ 생성 : CREATE DATABASE / CREATE TABLE / CREATE USER….
	  ㄴ 수정 : ALTER DATABASE / ALTER TABLE / ALTER USER…..
	  ㄴ 삭제 : DROP DATABASE / DROP TABLE / DROP USER…..
	  ㄴ 이름변경 : RENAME TABLE / RENAME USER…..
	  ㄴ 보기 : SELECT
- 조작어 | DML:Data Manipulation Language
	  ㄴ 데이터베이스 테이블에 자료관리용
	   - C (자료를 생성하는 역할) : INSERT INTO 테이블 명(필드명 들)   VALUES (값 들)
	   - R (찾아오는 역할) : SELECT 필드명 FROM 테이블 WHERE 조건
	   - U (자료를 수정하는 역할) : UPDATE 테이블명 SET(필드명=값) WHERE 조건건
	   - D (자료를 삭제하는 역할) : DELETE FROM 테이블  WHERE 조건

- 제어어 | DCL :Data Control Language
	   ㄴ 데이터의 보안, 무결성, 데이터 회복, 병행수행 등을 처리 (데이터 관리목적)
	   ㄴ ROLLBACK : 트렌젝션 복귀
	   ㄴ COMMIT : 트렌젝션 저장
	   ㄴ GRANT :권한부여  | 사용자에게 관리자가 테이블 및 기능을 권한 부여)
	   ㄴ REVOKE : 권한삭제
		** 트렌젝션이란, 일관작업을 말한다.
```

