-- dbdiagram.io를 위해 수정하기
TABLE Professor{
	professor_id int [PK]
	professor_name varchar
	department varchar
	salary numeric
	salary_level numeric
	hire_date date
}

TABLE Student {
	student_id int [PK]
	student_name varchar
	major varchar
}

TABLE Course{
	course_id int
	section_id int
	professor_id int
	course_name varchar
	indexes {
		(course_id, section_id) [PK]
	}
}

TABLE Enrollment{
	student_id int
	course_id int
	grade varchar
	points numeric -- 99.65
	enrolled_at DATE
	indexes {
		(student_id, course_id) [PK]
	}
}

Eef:enrollment.student_id > Student.student_id
eef:course.professor_id > Professor.professor_id