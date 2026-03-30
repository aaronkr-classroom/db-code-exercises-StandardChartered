주제: 동아리 관리 시스템
1. 시스템 설명

대학교 동아리에서 회원 정보를 관리하고, 동아리 활동 참여 여부를 기록

2. 사용자
동아리 회장
동아리 회원

3. 요구사항
회원 정보를 저장할 수 있어야 한다.
회원은 학번, 이름, 학과를 가진다.
동아리 모임 정보를 저장할 수 있어야 한다.
모임은 제목, 날짜, 장소 정보를 가진다.
어떤 회원이 어떤 모임에 참여했는지 저장할 수 있어야 한다.
회원 목록을 조회할 수 있어야 한다.
모임 참여자 목록을 조회할 수 있어야 한다.

4. 엔티티 설계
(1) Member
member_id : 회원 번호
student_id : 학번
name : 이름
department : 학과

(2) Meeting
meeting_id : 모임 번호
title : 모임 제목
meeting_date : 날짜
location : 

(3) Participation
participation_id : 참여 번호
member_id : 회원 번호
meeting_id : 모임 번호

5. SQL 코드
CREATE TABLE Member (
    member_id INT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    name VARCHAR(30) NOT NULL,
    department VARCHAR(50) NOT NULL
);

CREATE TABLE Meeting (
    meeting_id INT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    meeting_date DATE NOT NULL,
    location VARCHAR(50) NOT NULL
);

CREATE TABLE Participation (
    participation_id INT PRIMARY KEY,
    member_id INT NOT NULL,
    meeting_id INT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (meeting_id) REFERENCES Meeting(meeting_id)
);

INSERT INTO Member VALUES (1, '2024001', '김민지','소프트웨어학과');
INSERT INTO Member VALUES (2, '2024002', '이수빈', '컴퓨터공학과');
INSERT INTO Member VALUES (3, '2024003', '박지훈', '인공지능학과');

INSERT INTO Meeting VALUES (1, '신입생 환영회', '2026-03-20', '미래융합정보관');
INSERT INTO Meeting VALUES (2, '스터디 모임', '2026-03-25', '도서관 205호');

INSERT INTO Participation VALUES (1, 1, 1);
INSERT INTO Participation VALUES (2, 2, 1);
INSERT INTO Participation VALUES (3, 1, 2);
INSERT INTO Participation VALUES (4, 3, 2);

6. 간단한 설명문

회원 정보를 저장하는 Member 테이블, 모임 정보를 저장하는 Meeting 테이블, 그리고 회원의 모임 참여 여부를 저장하는 Participation 테이블로 구성.