# DataBase26 — MySQL & SQL Study Repository
MySQL 기반 데이터베이스 학습 및 SQL 실습 기록 저장소입니다.
DDL / DML / DCL 문법 실습부터 LMS 프로젝트용 DB 설계 및 CRUD 테스트까지 포함합니다.

SQL 자격증(SQLD) 대비와 실무 SQL 활용을 목표로 정리했습니다.

---
## Study Goals
- MySQL 설치 및 환경 구성 이해
- SQL 기본 문법 숙련 (DDL / DML / DCL)
- 테이블 설계 및 데이터 모델링 실습
- CRUD 쿼리 작성 및 검증
- JOIN / GROUP BY / 서브쿼리 실습
- LMS 프로그램용 데이터베이스 설계
- SQL 자격증 대비 정리

---
## Environment
- MySQL 8.x (LTS)
- MySQL Workbench
- Windows 11
- Git / GitHub

---
## Repository Structure
```
sql/
├── ddl/
│ └── DDL.sql
│ ├── dml/
│ └── DDL_DML.sql
│ ├── lms/
│ ├── LMS_MBC.sql
│ └── LMS_ROOT.sql
│ └── project/
└── MySQL_Practice_Annotated_Keywords.sql
```
## Contents
- DATABASE / TABLE 생성
- ALTER / DROP
- 제약조건 설정
- 기본키 / 외래키 설계

---
## DML Practice
- INSERT / SELECT / UPDATE / DELETE
- WHERE 조건절
- 정렬 및 필터링

---
## LMS DB Model
- 회원 테이블
- 성적 테이블
- 게시판 테이블
- 관계형 구조 설계
- 더미데이터 입력 및 조회 테스트

---
## Annotated SQL
- SQL 키워드별 주석 정리
- 실습 예제 포함
- 빠른 복습용 구조

---
## Practice Focus
- 실제 실행 가능한 SQL 중심
- 단순 이론이 아닌 실행 결과 검증
- 오류 케이스 포함 테스트
- CRUD 시나리오 기반 실습

---
## Next Plan
- JOIN / SUBQUERY 심화 정리
- 인덱스 / 실행계획 분석
- 성능 비교 실험
-SQLD 기출 유형 정리 추가

---
## Author
Database & Backend Study 기록용 저장소

---
## mySQL설치
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

