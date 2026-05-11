--User, Game, Item, Play, UserItem
Create table users(
	user_id INT PRIMARY KEY,
	user_name VARCHAR(30) Not null,
	nickname varchar(30) not null,
	user_level int,
	join_date date
);

create table games(
	game_id int primary key,
	game_name varchar(50) NOT NULL,
	genre varchar(20), 
	release_date DATE,
);

create table items(
	item_id int primary key,
	item_name varchar(30),
	price int,
	grade char -- 'S'
);

create table plays(
	user_id int,
	game_id int,
	start_date DATE,
	play_time int, -- Time.Now()
	PRIMARY KEY (user_id, game_id),
	FOREIGN KEY(user_id) REFERENCES users(user_id),
	foreign key(game_id) references games(user_id)
)

create table user_items(
	user_id int,
	item_id int,
	acquired_date DATE,
	quantity int,
	primary key (user_id, item_id),
	foreign key (user_id) references users(user_id),
	foreign key	(item_id) references items(item_id)
)

table users;

table games;

table items;
table plays;

table user_items;

-- insert values
insert int users values
(1, '김민준', 'DragonKingNeverDieLegend', 15,'2024-03-01'),
(2, '이서연', 'crazygirl', 19, '2023-02-12'),
(3, '박지우', 'ThunderKingSquad', 32, '2022-03-30'),
(4, '곽덕팔', 'FastNSlowThing', 59, '1961-05-04'),
(5, '김봉순', 'CatchMeIfYouCan', 95, '1949-03-01');

insert into games values
(101, 'super mario rpg', 'rpg', '2021-01-01'),
(102, 'gran turismo', 'racing', '2019-12-31'),
(103, 'puzzle chezzle', 'puzzle', '2022-07-04')

insert into items values
(1001, '강철검', 5000, 'B'),
(1002, '청동검', 2000, 'A'),
(1003, '뗀석검', 3000, 'C'),
(1004, '반달검', 4000, 'D'),
(1005, '옵시디언검', 5000, 'B'),

insert into plays values
(1, 101, '2020-01-22', 120),
(2, 102, '2021-02-23', 120),
(3, 103, '2022-03-24', 120),
(4, 104, '2023-04-25', 120),
(5, 105, '2024-05-26', 120),

insert into user_items values
(1, 1001, '2026-01-23', 1),
(2, 1002, '2025-02-23', 2),
(3, 1003, '2024-03-23', 3),
(4, 1004, '2023-04-23', 4),
(5, 1005, '2022-05-23', 5),

--기본 조회 연습
-- 1. 전체 유저 조회
select * from users;

-- 2. 레벨 높은 순서로 조회
select * from users
order by user_level desc;


-- 3. 레벨이 10 이상인 유저 조회
select * from users
where user_level >= 10;

--4. "S" 등급 아이템 조회
select * from items
where grade = 'S';

-- 테이블 수정할 때 (ALTER TABLE)
-- 1. 게임 회사에서 유저의 이메일도 저장하기로 했다.
alter table users
add column email varchar(50);
table users;

-- 2. 유저에게 현재 접속 상태를 저장해야 한다.
alter table users
add column status varchar(10) default 'offline';
table users;

-- 3. 아이템 테이블에 판매 가능 여부를 추가해야 한다.
alter table items
add column is_sellable boolean default true;
table items;
-- 4. 게임 테이블에 게임 등급 정보를 추가해야 한다.
alter table games 
add column age_rating varchar(10);
table games;

-- 테이블에 있는 값이 변경할 때 UPDATE 
-- 1. 김민준 유저의 이메일을 추가합니다.
update users
set email = 'minjun@email.com'
where user_id = 1;
-- 2. 이서연 유저의 레벨이 25로 올랐다.
update users
set user_level = 25
where user_id = 2;
-- 3. 모든 유저의 기본 접속 상태를 online으로 설정한다.
update users
set status = 'online';

-- 4. dragonKingneverDie 유저가 현재 접속 중이다.
update users
set status = 'connecting'
where nickname = 'DrangonKing'
-- 5. 회복 포션의 가격을 700으로 변경한다.
update items
set price = 700
where item_name = '회복포션';
-- 6. gran turismo의 이용 가능 연령을 12세 이상으로 설정한다.
update games
set age_rating = '12+'
where game_id = 102

-- 주의 설명
-- delete는 데이터를 삭제한다
-- DROP TABLE은 테이블 자체를 삭제한다
-- alter table은 테이블 구조를 변경한다
-- update는 기존 데이터를 수정한다.
