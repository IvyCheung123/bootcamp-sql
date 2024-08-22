-- database -> table (row & column)
-- highlight row and then click 閃電 to execute

create database db_bc2405p;
-- go to Schemas and then refresh

use db_bc2405p;

-- table name is per database
create table customers (
	id int,
	name varchar(50),
    email varchar(50)
);

-- insert into table_name (column_name) values (column_value);
insert into customers (id, name, email) values (1, 'John', 'john@gmail.com');
insert into customers (id, name, email) values (2, 'Peter', 'peter@gmail.com');

-- *: all columns
-- where: conditions on columns
select * from customers;
select * from customers where id = 2; -- Peter (all columns)
select * from customers where id = 1 or id = 2; -- John, Peter (all columns)
select * from customers where id = 1 and id = 2; -- no data matches this criteria

select name from customers where id = 1; -- John (name)
select name, email from customers where id = 1; -- John (name, email)

-- where (filter), order by (sort)
select * from customers order by id; -- by default asc
select * from customers order by id desc;
select * from customers where id = 1 order by id;

create table students (
	id integer, -- int
    name varchar(20), -- length
    weight numeric(5,2), -- 5-2 (integer), 2 (decimal place)
    height numeric(5,2) -- 000.00 ~ 999.99
);

insert into students(id, name, weight, height) values (1, 'John', 60.5, 170.50); -- 60.50, 170.50
insert into students(id, name, weight, height) values (2, 'Peter', 65.5, 175); -- 65.50, 175.00

-- oracle will warning but mysql will not
insert into students(id, name, weight, height) values (3.4, 'John', 60.5, 170.5); -- 3.4 -> 3
insert into students(id, name, weight, height) values (3.5, 'John', 60.5, 170.5); -- 3.5 -> 4
insert into students(id, name, weight, height) values (5, 10, 60.5, 170.50); -- name -> 10
insert into students(id, name, weight, height) values (6, 'John', 60.555, 170.5); -- 60.555 -> 60.56

select * from students;

-- drop table students;

-- try: datatime, integer, numeric, varchar
-- save script as .sql and push to GitHub