-- DB Final Project Skeleton
-- Student Name: 유청균
-- Student ID: 2126044

-- 1. CREATE TABLE

CREATE TABLE class_code (
    code INT PRIMARY KEY,
    class VARCHAR(20) NOT NULL,
    basis VARCHAR(50) NOT NULL
);

CREATE TABLE task_code (
    code INT PRIMARY KEY,
    task VARCHAR(50) NOT NULL
);

CREATE TABLE customer (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(30) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100),
    class_code INT NOT NULL DEFAULT 1,
    join_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_customer_class
        FOREIGN KEY (class_code)
        REFERENCES class_code(code)
);

CREATE TABLE staff (
    staff_id VARCHAR(10) PRIMARY KEY,
    staff_name VARCHAR(30) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    task_code INT NOT NULL,
    salary NUMERIC(10, 0) NOT NULL DEFAULT 0,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT chk_staff_salary CHECK (salary >= 0),
    CONSTRAINT fk_staff_task
        FOREIGN KEY (task_code)
        REFERENCES task_code(code)
);

CREATE TABLE tour (
    tour_id VARCHAR(10) PRIMARY KEY,
    tour_name VARCHAR(100) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price NUMERIC(12, 0) NOT NULL DEFAULT 0,
    max_people INT NOT NULL DEFAULT 20,
    manager_staff_id VARCHAR(10) NOT NULL,
    CONSTRAINT chk_tour_date CHECK (end_date >= start_date),
    CONSTRAINT chk_tour_price CHECK (price >= 0),
    CONSTRAINT chk_tour_max_people CHECK (max_people > 0),
    CONSTRAINT fk_tour_staff
        FOREIGN KEY (manager_staff_id)
        REFERENCES staff(staff_id)
);

CREATE TABLE reserve (
    reserve_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    tour_id VARCHAR(10) NOT NULL,
    reserve_date DATE NOT NULL DEFAULT CURRENT_DATE,
    reserve_people INT NOT NULL DEFAULT 1,
    total_price NUMERIC(12, 0) NOT NULL DEFAULT 0,
    reserve_status VARCHAR(20) NOT NULL DEFAULT '예약완료',
    CONSTRAINT chk_reserve_people CHECK (reserve_people > 0),
    CONSTRAINT chk_reserve_total_price CHECK (total_price >= 0),
    CONSTRAINT fk_reserve_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_reserve_tour
        FOREIGN KEY (tour_id)
        REFERENCES tour(tour_id)
);

-- 5. BONUS TABLES (Optional)

CREATE TABLE driver (
    driver_id VARCHAR(10) PRIMARY KEY,
    driver_name VARCHAR(30) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    license_no VARCHAR(30) NOT NULL UNIQUE,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE tour_bus (
    bus_id VARCHAR(10) PRIMARY KEY,
    bus_no VARCHAR(20) NOT NULL UNIQUE,
    bus_type VARCHAR(30) NOT NULL DEFAULT '일반버스',
    seat_count INT NOT NULL DEFAULT 45,
    CONSTRAINT chk_bus_seat CHECK (seat_count > 0)
);

CREATE TABLE assign_driver (
    assign_driver_id VARCHAR(10) PRIMARY KEY,
    tour_id VARCHAR(10) NOT NULL,
    driver_id VARCHAR(10) NOT NULL,
    assign_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_assign_driver_tour
        FOREIGN KEY (tour_id)
        REFERENCES tour(tour_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_assign_driver_driver
        FOREIGN KEY (driver_id)
        REFERENCES driver(driver_id),
    CONSTRAINT uq_assign_driver UNIQUE (tour_id, driver_id)
);

CREATE TABLE assign_bus (
    assign_bus_id VARCHAR(10) PRIMARY KEY,
    tour_id VARCHAR(10) NOT NULL,
    bus_id VARCHAR(10) NOT NULL,
    assign_date DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_assign_bus_tour
        FOREIGN KEY (tour_id)
        REFERENCES tour(tour_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_assign_bus_bus
        FOREIGN KEY (bus_id)
        REFERENCES tour_bus(bus_id),
    CONSTRAINT uq_assign_bus UNIQUE (tour_id, bus_id)
);

-- 2. INSERT DATA

INSERT INTO class_code (code, class, basis) VALUES
(1, '일반', '기본 고객 등급'),
(2, '우수', '누적 예약 2회 이상'),
(3, 'VIP', '연간 예약금액 300만원 이상'),
(4, 'VVIP', '전담 상담 대상 고객'),
(5, '신규', '가입 30일 이내 고객');

INSERT INTO task_code (code, task) VALUES
(1, '고객 상담'),
(2, '예약 관리'),
(3, '여행상품 기획'),
(4, '회계 관리'),
(5, '인솔 관리');

INSERT INTO customer (customer_id, customer_name, phone, email, class_code, join_date) VALUES
('C001', '김민수', '010-1111-1111', 'minsu@example.com', 1, '2026-01-05'),
('C002', '이서연', '010-2222-2222', 'seoyeon@example.com', 2, '2026-01-10'),
('C003', '박지훈', '010-3333-3333', 'jihoon@example.com', 3, '2026-02-01'),
('C004', '최유진', '010-4444-4444', 'yujin@example.com', 4, '2026-02-12'),
('C005', '정다은', '010-5555-5555', 'daeun@example.com', 5, '2026-03-03');

INSERT INTO staff (staff_id, staff_name, phone, task_code, salary, hire_date) VALUES
('S001', '한지민', '010-9001-0001', 1, 2800000, '2024-03-01'),
('S002', '오준석', '010-9001-0002', 2, 3000000, '2023-07-15'),
('S003', '강하늘', '010-9001-0003', 3, 3200000, '2022-09-20'),
('S004', '윤서아', '010-9001-0004', 4, 2900000, '2025-01-10'),
('S005', '문태영', '010-9001-0005', 5, 3100000, '2024-11-05');

INSERT INTO tour (tour_id, tour_name, destination, start_date, end_date, price, max_people, manager_staff_id) VALUES
('T001', '제주 힐링 3일', '제주', '2026-07-10', '2026-07-12', 450000, 25, 'S003'),
('T002', '오사카 자유여행 4일', '오사카', '2026-07-20', '2026-07-23', 850000, 20, 'S003'),
('T003', '부산 야경 투어 2일', '부산', '2026-08-05', '2026-08-06', 250000, 30, 'S005'),
('T004', '괌 가족 여행 5일', '괌', '2026-08-15', '2026-08-19', 1500000, 18, 'S003'),
('T005', '스위스 알프스 7일', '스위스', '2026-09-01', '2026-09-07', 3200000, 15, 'S005');

INSERT INTO reserve (reserve_id, customer_id, tour_id, reserve_date, reserve_people, total_price, reserve_status) VALUES
('R001', 'C001', 'T001', '2026-06-01', 2, 900000, '예약완료'),
('R002', 'C002', 'T002', '2026-06-02', 1, 850000, '예약완료'),
('R003', 'C003', 'T001', '2026-06-04', 3, 1350000, '예약완료'),
('R004', 'C004', 'T005', '2026-06-05', 2, 6400000, '예약완료'),
('R005', 'C005', 'T004', '2026-06-07', 4, 6000000, '예약대기');

INSERT INTO driver (driver_id, driver_name, phone, license_no, hire_date) VALUES
('D001', '장도현', '010-7001-0001', 'BUS-2020-001', '2020-04-01'),
('D002', '서민재', '010-7001-0002', 'BUS-2021-002', '2021-05-15'),
('D003', '김태완', '010-7001-0003', 'BUS-2022-003', '2022-03-10'),
('D004', '이현우', '010-7001-0004', 'BUS-2023-004', '2023-08-21'),
('D005', '최성민', '010-7001-0005', 'BUS-2024-005', '2024-01-12');

INSERT INTO tour_bus (bus_id, bus_no, bus_type, seat_count) VALUES
('B001', '충북70바1001', '대형버스', 45),
('B002', '충북70바1002', '대형버스', 45),
('B003', '충북70바1003', '중형버스', 30),
('B004', '충북70바1004', '리무진버스', 28),
('B005', '충북70바1005', '대형버스', 45);

INSERT INTO assign_driver (assign_driver_id, tour_id, driver_id, assign_date) VALUES
('AD001', 'T001', 'D001', '2026-06-10'),
('AD002', 'T002', 'D002', '2026-06-11'),
('AD003', 'T003', 'D003', '2026-06-12'),
('AD004', 'T004', 'D004', '2026-06-13'),
('AD005', 'T005', 'D005', '2026-06-14');

INSERT INTO assign_bus (assign_bus_id, tour_id, bus_id, assign_date) VALUES
('AB001', 'T001', 'B001', '2026-06-10'),
('AB002', 'T002', 'B002', '2026-06-11'),
('AB003', 'T003', 'B003', '2026-06-12'),
('AB004', 'T004', 'B004', '2026-06-13'),
('AB005', 'T005', 'B005', '2026-06-14');

-- 3. INDEX

CREATE INDEX idx_customer_class_code ON customer(class_code);
CREATE INDEX idx_staff_task_code ON staff(task_code);
CREATE INDEX idx_tour_manager_staff_id ON tour(manager_staff_id);
CREATE INDEX idx_reserve_customer_id ON reserve(customer_id);
CREATE INDEX idx_reserve_tour_id ON reserve(tour_id);
CREATE INDEX idx_assign_driver_tour_id ON assign_driver(tour_id);
CREATE INDEX idx_assign_bus_tour_id ON assign_bus(tour_id);

-- 4. TEST QUERIES

-- Customer Grade Search
-- 고객 등급 검색
SELECT
    c.customer_id,
    c.customer_name,
    cc.class AS customer_grade,
    cc.basis AS grade_basis,
    c.join_date
FROM customer c
JOIN class_code cc ON c.class_code = cc.code
ORDER BY c.customer_id;

-- Employee Task Search
-- 직원 담당업무 검색
SELECT
    s.staff_id,
    s.staff_name,
    tc.task AS staff_task,
    s.salary,
    s.hire_date
FROM staff s
JOIN task_code tc ON s.task_code = tc.code
ORDER BY s.staff_id;

-- Tour Reservation Search
-- 여행상품 예약 고객 검색
SELECT
    t.tour_id,
    t.tour_name,
    t.destination,
    r.reserve_id,
    c.customer_id,
    c.customer_name,
    r.reserve_people,
    r.total_price,
    r.reserve_status
FROM reserve r
JOIN customer c ON r.customer_id = c.customer_id
JOIN tour t ON r.tour_id = t.tour_id
WHERE t.tour_id = 'T001'
ORDER BY r.reserve_id;

-- Assigned Driver Search
-- 여행상품 배정 운전기사 검색
SELECT
    t.tour_id,
    t.tour_name,
    d.driver_id,
    d.driver_name,
    d.phone,
    d.license_no,
    ad.assign_date
FROM assign_driver ad
JOIN tour t ON ad.tour_id = t.tour_id
JOIN driver d ON ad.driver_id = d.driver_id
WHERE t.tour_id = 'T001';

-- INSERT example
-- 신규 고객 등록
INSERT INTO customer (customer_id, customer_name, phone, email, class_code)
VALUES ('C006', '신규고객', '010-6666-6666', 'newcustomer@example.com', 5);

SELECT *
FROM customer
WHERE customer_id = 'C006';

-- UPDATE example
-- 직원 급여 수정
UPDATE staff
SET salary = salary + 100000
WHERE staff_id = 'S002';

SELECT
    staff_id,
    staff_name,
    salary
FROM staff
WHERE staff_id = 'S002';

-- DELETE example
-- 예약 정보 삭제 테스트를 위해 임시 예약을 먼저 등록한 뒤 삭제
INSERT INTO reserve (reserve_id, customer_id, tour_id, reserve_people, total_price, reserve_status)
VALUES ('R006', 'C006', 'T003', 1, 250000, '예약완료');

SELECT *
FROM reserve
WHERE reserve_id = 'R006';

DELETE FROM reserve
WHERE reserve_id = 'R006';

SELECT *
FROM reserve
WHERE reserve_id = 'R006';

SELECT * FROM reserve;