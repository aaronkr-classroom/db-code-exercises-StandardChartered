-- create database ut;

create table animals(
	id bigserial,
	name varchar(20),
	age integer,
	kind varchar(20),
	dob date, 
	location varchar(50)
);

table animals; -- select * from animals;

insert into animals (name, age, kind, dob, location)
values
    ('Cat', 45, 'tiger', '2010-10-10', 'Seoul, Korea'),
    ('Elephant', 200, 'panda', '1938-09-20', 'England'),
    ('Pooh', 41, 'dog', '2034-12-15', 'USA'),
    ('Rabbit', 12, 'rabbit', '2013-05-01', 'Busan, Korea'),
    ('Monkey', 27, 'monkey', '1998-11-08', 'Bangkok, Thailand');
