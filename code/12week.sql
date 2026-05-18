select * from users.user level;

table users;
select user_level from users;

-- 1: check 유저 레벨은 1에서 100만 가능하다
alter table users 
add constraint chk_user_level
check(user_level >= 1) and user_level <= 100);


update users
set user_level = 100
where user_id = 1;

-- 2: 접속상태는 온라인 또는 offline만 가능하다.
alter table users add constraint chk_user_status
check (status in 'online', 'offline');

select status from users;

update users
set txid_status
where user_id = 2;

-- 3. 아이템 가격은 0원 이상 이어야 한다.
select price from items;

alter table items
add constraint chk_item_price
check(price >= 0);

update item
set price = -10
where item_id = 1001;

-- 4. 아이템 등급을 정해진 값만 가능하다. (S, A, B,C, D,E,F,G)
alter table items
add constraint chk_item_grade
check (status int('S', 'A', 'B', 'C', 'D', 'E', 'F', 'G'))


-- 5. 닉네임은 중복이 불가능하다 중복 되면 안된다 중복을 불허한다. 중복을 제한한다. 중복을 막는다. 중복을 허락하지 않는다, 중복을 금지한다.
alter table users
add constraint uq_user_nickname
unique (nickname);

insert int users VALUES
(6, '홍길동', 'DragonKing', 10, '2026-05-18', 'home@home.com', 'offline');

select CONSTRAINT_NAME, TABLE_NAME
from infromation_Schema.Table_constraint
where constraint_type = 'foreign key'
    add table_name = 'plays';

-- plays_user_id_fkey
-- plays_game_id_fkey
-- user_items_user_id_fkey
-- user_items_item_id_fkey

select constraint_name, TABLE_NAME
from infromation_Schema, "infromation_Schema"

alter table plays
drop constraint plays_user_id_fkey;
alter table plays
drop constraint plays_game_id_fkey;
alter table plays
drop constraint user_items_user_id_fkey;
alter table plays
drop constraint user_items_item_id_fkey;

-- 새 포렌키 추가
-- 1: 유저가 삭제되면 플레이 기록도 삭제 되게 하기










alter table plays
add constraint fk_plays_users
foreign key (user_id)
references users(user_id)
on delete CASCADE;

-- 2: 게임은 플레이 기록이 있으면 삭제 하지 못하게 하기
alter table plays
add constraint fk_plays_games
foreign key (game_id)
references games(game_id)
on delete RESTRICT;

--3: 유저가 삭제되면 보유 아이템 기록도 삭제되게 하기
alter table user_items
add constraint fk_user_items_users
foreign key (user_id)
references users(user_id)
on delete CASCADE;

--4:아이템 누군가 보유 중이면 삭제하지 못하게 하기
alter table user_items
add constraint fk_user_items_items
foreign key (item_id)
references items(item_id)
on delete CASCADE;

alter table user_items
add constraint fk_user_items_items
foreign key(item_id)
REFERENCES items(item_id)
on delete RESTRICT;

select * from plays where user_id = 1;
SELECT * from user_items where user_id = 1;

delete from users where user_id = 1;

-- restict 테스트
table games;
delete from games where game_id = 101;
delete from items where item_id = 1004;
