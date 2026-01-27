select @@hostname;

# 이창은 메모장처럼 사용됨 
# 스크립트를 1줄씩 실행하는 것이 기본임(ctrl + enter)
# 만약 더미데이터를 20개를 입력한다면!!(블럭설정 + ctrl + shift + enter) address,category

use sakila; -- sakila라는 데이터베이스에 가서 사용할게!!
select * from actor; -- acter 테이블에 모든 값을 가져와!!

use world; -- world라는 데이터베이스에 가서 사용할게!
select * from city; -- city 테이블에 모든 값을 가져와!