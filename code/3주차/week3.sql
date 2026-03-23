/*
[Entities / 개체]

[PROFESSOR TABLE 작성 (개체)]
-   id			 (BIGSERIAL) -- 자동으로 증가
-	name 		 (Varchar(30))
-	dept 		 (Varchar(50))
-	salary 		(NUMERIC)
-	salary_level (NUMERIC)
-	hire_date (DATE)
*/

CREATE TABLE prof (
   id bigserial,
   name varchar(30),
   dept varchar(50),
   salary numeric,
   salart_level numeric,
   hire_date date
);

TABLE prof;

-- 데이터 삽입
insert into prof (name, dept, salary, salary_level, hire_date)
values
	('임현성', '컴퓨터공학과','500000','5','2024-06-25'),
	('구정현', '한국어문학과','800000','1','2021-09-26'),
	('임금자', '중어중문학과','90000','1','2014-05-02'),
	('임팩트', '의학과','100000','1','2005-02-12'),
	('유청균', '군사경찰학과','500000','9','2000-04-19');

ALTER TABLE prof
RENAME COLUMN salart_level TO salary_level;

select * from prof;

select name, salary from prof;

select name,salary from prof order by salary desc: --asc

select name,salary from prof where salary > 90000;

select name, salary from prof where name like '임%'; -- PostgreSQL ILIKE 대/소문자 상관 없다

select name, dept from prof
	where dept LIKE '%컴%'
	order by dept ASC;

select name, salary from prof where salary between 70001 and 89999;