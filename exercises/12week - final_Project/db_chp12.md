# 12장 연습문제 정답

## 개념퍼즐

### 가로

1. 가장 최근에 생성된 현재 시퀀스 값을 반환하는 의사열
   정답: `CURRVAL`

2. 시퀀스를 변경하는 명령
   정답: `ALTER SEQUENCE`

3. 시퀀스를 삭제하는 명령
   정답: `DROP SEQUENCE`

4. 사용자가 수동으로 인덱스를 생성하는 명령
   정답: `CREATE INDEX`

5. 테이블 구조는 남겨두고 저장된 데이터만 삭제하는 명령
   정답: `TRUNCATE TABLE`

6. 기본 테이블의 구조를 변경하는 명령
   정답: `ALTER TABLE`

7. 기본 테이블로부터 만들어지는 가상 테이블인 뷰를 생성하는 명령
   정답: `CREATE VIEW`

8. 기본 테이블 구조와 함께 저장된 데이터와 인덱스까지 한꺼번에 삭제하는 명령
   정답: `DROP TABLE`

9. DDL 문으로 만들어지지 않고, 질의문 처리 과정의 중간 결과로 만들어지는 테이블
   정답: 임시 테이블

10. 기존 테이블에 새로운 데이터를 삽입하는 명령
    정답: `INSERT INTO`

11. 시퀀스에 의해 자동으로 생성되는 가상의 열
    정답: 의사열

12. CREATE VIEW 명령을 이용해서 기본 테이블로부터 만들어지는 테이블
    정답: 뷰

13. 단 하나의 테이블만 기초로 하여 생성된 뷰
    정답: 단순 뷰

14. 테이블에서 기존 데이터를 갱신하는 명령
    정답: `UPDATE`

---

### 세로

1. 시퀀스를 생성하는 명령
   정답: `CREATE SEQUENCE`

2. 기존 뷰를 삭제하는 명령
   정답: `DROP VIEW`

3. 기존 테이블에 새로운 데이터를 삽입하는 명령
   정답: `INSERT INTO`

4. 테이블에서 기존 데이터를 삭제하는 명령
   정답: `DELETE`

5. 기본 테이블을 생성하는 명령
   정답: `CREATE TABLE`

6. 다음에 사용 가능한 시퀀스 값을 생성하는 의사열
   정답: `NEXTVAL`

7. 고정길이 문자열을 기억하는 데이터 타입
   정답: `CHAR`

8. 테이블에서 데이터를 검색하는 명령
   정답: `SELECT`

9. 독자적으로 존재하는 테이블
   정답: 기본 테이블

10. 다중 테이블을 기초로 하여 생성된 뷰
    정답: 복합 뷰

---

## 연습문제

### 1. DB 구현 단계의 주요 업무가 아닌 것은?

1. DB에 초기 데이터를 삽입한다.
2. 생성된 DB 구조가 설계된 DB 구조와 정확히 일치하는지 확인한다.
3. 유지보수를 위한 문서화 작업을 수행한다.
4. 트랜잭션 처리용 응용 프로그램을 작성한다.

정답: 3번

---

### 2. 다음과 같은 내부 스키마를 기초로 하여 lab 테이블을 생성하는 SQL 문을 작성하시오.

정답:

```sql
CREATE TABLE lab (
    lab_num NUMBER(3) PRIMARY KEY,
    name VARCHAR2(50) NOT NULL UNIQUE,
    building VARCHAR2(50) NOT NULL,
    room_id CHAR(4),
    dept_id CHAR(4),
    CONSTRAINT lab_dept_fk FOREIGN KEY (dept_id)
        REFERENCES dept(id)
);
```

---

### 3. 02번 문제에서 생성한 lab 테이블에 숫자 타입 4바이트의 면적, 즉 lab_size 열을 추가하고, 디폴트 값을 50으로 설정하는 SQL 문을 작성하시오.

정답:

```sql
ALTER TABLE lab
ADD lab_size NUMBER(4) DEFAULT 50;
```

---

### 4. 02번 문제에서 생성한 lab 테이블의 호실, 즉 room_id 열에 room_id_idx라는 인덱스를 생성하는 SQL 문을 작성하시오.

정답:

```sql
CREATE INDEX room_id_idx
ON lab(room_id);
```

---

### 5. 02번 문제에서 생성한 lab 테이블에 다음 데이터를 삽입하는 SQL 문을 작성하시오.

실험실번호: 188, 명칭: 가상현실, 건물명: 2공학관, 호실: B283, 소속학과: comp
실험실번호: 118, 명칭: 인공지능, 건물명: 2공학관, 호실: A181, 소속학과: comp

정답:

```sql
INSERT INTO lab (lab_num, name, building, room_id, dept_id)
VALUES (188, '가상현실', '2공학관', 'B283', 'comp');

INSERT INTO lab (lab_num, name, building, room_id, dept_id)
VALUES (118, '인공지능', '2공학관', 'A181', 'comp');
```

---

### 6. 02번 문제에서 생성한 lab 테이블에 건물명이 2공학관인 모든 실험실의 명칭과 소속학과번호를 검색하는 SQL 문을 작성하시오.

정답:

```sql
SELECT name, dept_id
FROM lab
WHERE building = '2공학관';
```

---

### 7. 02번 문제에서 생성한 lab 테이블에 명칭이 인공지능인 실험실의 호실을 B102로 변경하는 SQL 문을 작성하시오.

정답:

```sql
UPDATE lab
SET room_id = 'B102'
WHERE name = '인공지능';
```

---

### 8. 02번 문제에서 생성한 lab 테이블을 기초로 하여 소속학과 id가 comp인 모든 실험실의 명칭, 호실, 면적을 포함하는 com_lab_view라는 뷰를 생성하는 SQL 문을 작성하시오.

정답:

```sql
CREATE VIEW com_lab_view AS
SELECT name, room_id, lab_size
FROM lab
WHERE dept_id = 'comp';
```

---

### 9. 02번 문제에서 생성한 lab 테이블의 기본키인 실험실번호 lab_num 값을 자동으로 생성하는 데 사용할 시퀀스인 lab_num_seq를 생성하려고 한다. 첫 번째 시퀀스 값은 120이고, 최대 990까지 10씩 증가시키고, 최댓값에 도달한 후에 다시 첫 번째 시퀀스 번호부터 생성하지 않고, 시퀀스 값을 미리 생성하지 않도록 시퀀스를 정의하는 SQL 문을 작성하시오.

정답:

```sql
CREATE SEQUENCE lab_num_seq
START WITH 120
INCREMENT BY 10
MAXVALUE 990
NOCYCLE
NOCACHE;
```

---

### 10. 09번 문제에서 생성한 시퀀스인 lab_num_seq를 이용해서 2번 문제에서 생성한 lab 테이블에 다음과 같은 데이터를 삽입하는 SQL 문을 작성하시오.

명칭: 네트워크, 건물명: 2공학관, 호실: B281, 소속학과: comp

정답:

```sql
INSERT INTO lab (lab_num, name, building, room_id, dept_id)
VALUES (lab_num_seq.NEXTVAL, '네트워크', '2공학관', 'B281', 'comp');
```

---

### 11. 앞에서 생성한 테이블과 인덱스, 뷰, 시퀀스를 모두 삭제하는 SQL 문을 작성하시오.

정답:

```sql
DROP VIEW com_lab_view;

DROP INDEX room_id_idx;

DROP SEQUENCE lab_num_seq;

DROP TABLE lab;
```

참고: 실습에서 dept 테이블까지 직접 생성했다면 다음 문장도 추가할 수 있다.

```sql
DROP TABLE dept;
```
