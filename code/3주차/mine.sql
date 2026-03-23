create table clan (
    clan_id bigserial primary key,
    clan_name varchar(50) not null,
    master_id bigint,
    member_count int,
    create_at timestamp default current_timestamp
);

create table users (
    id bigserial primary key,
    nickname varchar(30) not null,
    job_class varchar(20) not null,
    level int not null,
    phone_number varchar(15),
    user_rank varchar(20),
    clan_id bigint references clan(clan_id)
);

create table status (
    user_id bigint primary key references users(id),
    str int not null,
    dex int not null,
    int_stat int not null,
    luk int not null,
    speed int not null
);

alter table clan
add foreign key (master_id) references users(id);

select * from users