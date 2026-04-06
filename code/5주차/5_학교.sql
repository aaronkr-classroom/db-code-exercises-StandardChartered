CREATE TABLE Professor(
	professor_id int PRIMARY KEY,
	professor_name varchar(100),
	department varchar(100),
	salary numeric,
	salary_level numeric,
	hire_date date
);
a
drop table professor;

create table Student (
	student_id int primary key,
	student_name varchar(100),
	major varchar(100)
);

create table Course(
	course_id int,
	section_id int,
	professor_id int,
	course_name varchar(100),
	Primary key (course_id, section_id),
	FOREIGN KEY (professor_id) REFERENCES professor(professor_id)
);

create table Enrollment(
	student_id int,
	course_id int,
	grade varchar(2),
	points numeric, -- 99.65
	enrolled_at DATE,
	PRIMARY KEY (student_id, course_id),
	FOREIGN KEY (student_id) REFERENCES student(student_id)
	--FOREIGN KEY (course_id) REFERENCES course(course_id)	
);