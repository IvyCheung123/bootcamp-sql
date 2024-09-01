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

-- you can skip some column(s) when you execute insert statement -> null value
-- if you don't specify the column name, then you have to put all column values
insert into students(id, name, weight, height) values (7, 'John', null, 170.5);

-- try: datatime, integer, numeric, varchar
-- save script as .sql and push to GitHub

create table employee (
	id integer,
	onboard_date datetime,
    name varchar(20),
    salary numeric(10,2)
);

insert into employee (id, onboard_date, name, salary) values (1, '2024-01-01', 'John', 25000); -- 2024-01-01 00:00:00
insert into employee (id, onboard_date, name, salary) values (2, '2024-01-01', 'Peter', 30000); -- 2024-01-01 00:00:00

rename table employee to employees;

select * from employees order by id desc;

delete from employee where id = 2;

-- DDL (Data Definition Language): create/drop table, add/drop column (cannot add into middle column), modify column definition (common sense: will not change varchar(50) to varchar(49), only will increase character length)
-- DML (Data Manipulation Language): insert row, delete row, update column, truncate table (remove all data)

-- +, -, *, /, %
select id, name, weight, height, weight / height^2 as bmi from students;

-- =, <> (!=), <, >, <=, >=
select s.*, s.weight + s.height as weight_plus_height from students s where s.weight < 65 and s.weight <> 60.56 order by id;

-- in, not in
select * from students where id in (3,4,5);
select * from students where id not in (1,2);

-- like, not like
select * from students where name = 'John';
select * from students where name like 'John%'; -- any name with prefix (0 or more characters) and suffix (0 or more characters)
select * from students where name like 'John'; -- no % -> end with 'John'
select * from students where name not like 'John'; -- Peter, 10

-- null check
select * from students where weight is null or height is null;

-- functions (similar to java instance method)
insert into students (id, name, weight, height) values (8, '陳大明', 70, 180);
select s.id, s.name , char_length(s.name) as name_char_length, length(s.name) as name_length from students s; -- 1 中文字 = 3 char

-- upper, lower case
select s.name, upper(s.name), lower(s.name) from students s;

-- substring(), trim(), replace()
select s.name, substring(s.name, 1, 3) from students s; -- start from 1, no index in db
select s.name, trim(s.name) from students s; -- trim out 頭尾 space
select s.name, replace(s.name, '陳大明', '陳小明') from students s;

-- Java: indexOf() vs DB: instr()
-- return position start from 1, return 0 if not found
select s.*, instr(s.name, 'John') from students s;

-- Java: get and set -> store in DB
-- DB: will not calculate, only store the status -> back to Java for calculation
create table orders (
	id integer,
    total_amount numeric(10,2),
    customer_id integer
);

select * from orders; -- List<Order>

-- one to many -> key put in many
insert into orders values (1, 2005.10, 2);
insert into orders values (2, 10000.9, 2);
insert into orders values (3, 99.9, 1);

-- sum(), avg(), max(), min()
-- 3ms without network consideration -> already slower than Java
-- Java one server -> DB another server (need to via network)
-- Java (memory RAM) -> 冇咩事唔好落DB (harddisk) -> 除非要儲落harddisk
-- frontend call Java -> Java落DB (via network) -> DB get back to Java (via network) -> very slow
select sum(o.total_amount) from orders o;
select avg(o.total_amount) from orders o where customer_id = 2;

-- filter id first, and then min() and max()
select min(o.total_amount), max(o.total_amount) from orders o where customer_id = 2;
select min(o.total_amount), max(o.total_amount) from orders o;

-- count()
select count(o.total_amount) from orders o; -- same as count(*) -> column name

select o.*, 1 as number, 'hello' as string from orders o; -- put 1 and hello into all rows
select 1 as number from orders o;
select count(1) from orders o; -- 當你擺曬1係所有行, 就算冇寫select 1 as number from orders o;

-- Why can we put all functions in select statement?
-- Ans: Aggregation Functions
-- sum(), avg(), max(), min(), count() -> aggregation result must be one row
select sum(o.total_amount), avg(o.total_amount), max(o.total_amount), min(o.total_amount), count(*) from orders o;
-- select o.total_amount, sum(o.total_amount) from orders o; -- error

-- group by
select * from orders;
-- '1','2005.10','2'
-- '2','10000.90','2'
-- '3','99.90','1'
select sum(total_amount) from orders where customer_id = 1;
select sum(total_amount) from orders where customer_id = 2;


-- group by -> select "group key" and Aggregation Functions
-- o.* -> group information or individual data information
-- select o.customer_id, sum(o.total_amount), o.id from orders o group by o.customer_id; -- error: o.id
-- '1','99.90'
-- '2','12006.00' -> use which one (o.id = 1 or 2) to present this aggregation result?
-- Conclusion: group by cannot select all columns (o.*), can only select group by "key"

select o.customer_id, sum(o.total_amount) from orders o group by o.customer_id order by o.customer_id;
-- '1','99.90'
-- '2','12006.00'

-- group by unique key -> meaningless
select o.id, sum(o.total_amount) from orders o group by o.id; -- meaningless

-- having (must use together with group by)
insert into orders values (4, 10000.9, 3);
insert into orders values (5, 20000, 3);
select * from orders;
-- '1','2005.10','2'
-- '2','10000.90','2'
-- '3','99.90','1'
-- '4','10000.90','3'
-- '5','20000.00','3'

-- where -> group by -> having -> order by
select o.customer_id, avg(o.total_amount) 
from orders o 
where o.customer_id in (2,3) -- filter before group by (5 rows -> 4 rows) -> result: 4 rows x 3 columns
group by o.customer_id -- result: 2 rows x 2 columns
having avg(o.total_amount) > 10000 -- filter after group by -> result: 1 row x 2 columns
;

-- 2 tables (one to many)
-- example: authors and books

-- MySQLWorkbench -> Settings -> SQL Editor -> untick Safe Updates

select * from customers where name = 'JOHN'; -- case insensitive
select * from customers where upper(name) = 'JOHN'; -- if case sensitive

-- Wildcard
-- % represents zero or more characters
select * from customers where name like '%OH%'; -- John
select * from customers where name like 'J%N'; -- John
-- _ represents any single character
select * from customers where name like '_OH%'; -- John
select * from customers where name like '_H%'; -- No data matches

-- round(): round off, ceil(): round up, floor(): round down
select o.total_amount, round(o.total_amount, 0), ceil(o.total_amount), floor(o.total_amount) from orders o;

-- power()
select power(2, 3.5) as result;

select 1, abs(-5) from dual;

-- MySQL syntax: Date Formatting
select date_format('2024-08-31', '%Y-%M-%D') from dual; -- '2024-August-31st'
select date_format('2024-08-31', '%Y-%m-%d') from dual; -- '2024-08-31'
select date_format('2024-08-31', '%Y-%m-%d') + interval 1 day from dual; -- '2024-09-01'
select date_format('2024/08/31', '%Y/%m/%d') + interval 1 day from dual; -- '2024-09-01'
select date_format('31-08-2024', '%d-%m-%Y') + interval 1 day from dual; -- null
select str_to_date('2024-08-31', '%Y-%m-%d') + interval 1 day from dual; -- '2024-09-01'

-- Oracle syntax: Date Formatting
-- select to_date('20240831', 'YYYYMMDD') + 1 from dual;

-- MySQL syntax: extract year or month or day
select extract(year from date_format('2024-08-31', '%Y-%m-%d')) from dual; -- 2024
select extract(month from date_format('2024-08-31', '%Y-%m-%d')) from dual; -- 8
select extract(day from date_format('2024-08-31', '%Y-%m-%d')) from dual; -- 31

select * from orders;
alter table orders add column tran_date date; -- DDL

update orders set tran_date = date_format('2023-01-01', '%Y-%m-%d') where id = 1;
update orders set tran_date = date_format('2022-01-02', '%Y-%m-%d') where id = 2;
update orders set tran_date = date_format('2023-01-03', '%Y-%m-%d') where id = 3;
update orders set tran_date = date_format('2024-01-04', '%Y-%m-%d') where id = 4;
update orders set tran_date = date_format('2023-01-05', '%Y-%m-%d') where id = 5;

select extract(year from tran_date) as year, count(1) as number_of_orders 
from orders 
group by extract(year from tran_date) 
having count(1) >= 2;
-- '2023','3'
-- '2022','1'
-- '2024','1'
-- after having ...
-- '2023','3' -- count the result after group by

select * from students; -- contain NULL
-- '2','Peter','65.50','175.00'
-- '3','John','60.50','170.50'
-- '4','John','60.50','170.50'
-- '5','10','60.50','170.50'
-- '6','John','60.56','170.50'
-- '7','John',NULL,'170.50'
-- '8','陳大明','70.00','180.00'

-- ifnull(), coalesce(): will not update the original data
-- only update will update the original data
select s.*, ifnull(s.weight, 'N/A') from students s;
select s.*, coalesce(s.weight, 'N/A') from students s; -- coalesce() same as ifnull()

-- < 2000 -> 'S'
-- >= 2000 and <= 10000 -> 'M'
-- > 10000 -> 'L'
select case when o.total_amount < 2000 then 'S' 
			when o.total_amount between 2000 and 10000 then 'M' 
			else 'L' 
	end as category
    , o.total_amount 
from orders o;
-- 'M','2005.10'
-- 'L','10000.90'
-- 'S','99.90'
-- 'L','10000.90'
-- 'L','20000.00'

-- between (inclusive)
select * 
from orders 
where tran_date between date_format('2023-01-01', '%Y-%m-%d') 
and date_format('2023-12-31', '%Y-%m-%d');
-- '1','2005.10','2','2023-01-01'
-- '3','99.90','1','2023-01-03'
-- '5','20000.00','3','2023-01-05'

insert into customers values (3, 'Jenny Yu', 'jenny@hotmail.com');
insert into customers values (4, 'Benny Kwok', 'benny@hotmail.com');
select * from customers;
-- '1','John','john@gmail.com'
-- '2','Peter','peter@gmail.com'
-- '3','Jenny Yu','jenny@hotmail.com'
-- '4','Benny Kwok','benny@hotmail.com'
select * from orders;
-- '1','2005.10','2','2023-01-01'
-- '2','10000.90','2','2022-01-02'
-- '3','99.90','1','2023-01-03'
-- '4','10000.90','3','2024-01-04'
-- '5','20000.00','3','2023-01-05'

-- Approach 1: you cannot select columns from table orders
-- One SQL (similar to for loop)
-- o.customer_id = c.id (有key) -> check if the customer exits in orders
select * 
from customers c 
where exists (select 1 from orders o where o.customer_id = c.id);
-- '1','John','john@gmail.com'
-- '2','Peter','peter@gmail.com'
-- '3','Jenny Yu','jenny@hotmail.com'

-- join tables
select * -- cannot use 'distinct' ???
from customers c inner join orders o; -- on condition
-- 4 customers x 6 orders -> 24 rows

-- Approach 2: you can select columns from both table customers and table orders
-- inner join: similar to exists
select c.*, o.* 
from customers c inner join orders o on o.customer_id = c.id;

select * 
from customers c 
where not exists (select 1 from orders o where o.customer_id = c.id);
-- '4','Benny Kwok','benny@hotmail.com'

select * from orders;
insert into orders values (6, 9999, 3, date_format('2024-08-04', '%Y-%m-%d'));
insert into orders values (7, 9999, 3, date_format('2024-08-04', '%Y-%m-%d'));

-- MySQL syntax
select concat_ws('-', extract(year from o.tran_date), extract(month from o.tran_date)) from orders o;
-- '2024-08' 1

-- distinct: remove duplicates
-- distinct one column
select distinct concat_ws('-', extract(year from o.tran_date), extract(month from o.tran_date)) from orders o;
-- distinct two columns
select distinct concat_ws('-', extract(year from o.tran_date), extract(month from o.tran_date)), total_amount from orders o;

-- Oracle syntax
-- select extract(year from o.tran_date) + '-' + extract(month from o.tran_date) from orders o;

select o.*, (select max(o.total_amount) from orders o) 
from orders o;

-- Subquery: two SQL (搵完第一個再用第一個嘅result搵第二個)
-- First SQL to execute: select id from customers where name like '%kwok'
-- Second SQL to execute: select * from orders where customer_id in ... (冇key)
-- Make sense but very slow performance
-- Better performance: use join
select * 
from orders 
where customer_id in (select id from customers where name like '%kwok');

select * from orders;
delete from orders where id = 7;

insert into orders values (7, 400, null, date_format('2024-08-31', '%Y-%m-%d'));

-- left join
select c.*, o.* 
from customers c left join orders o on c.id = o.customer_id;

select o.*, c.* 
from orders o left join customers c on c.id = o.customer_id; -- result same as right join

-- right join
select o.*, c.* 
from customers c right join orders o on c.id = o.customer_id;

-- Step 1: left join on key
-- Step 2: where
-- Step 3: group by
-- Step 4: order by
-- Step 5: select -> count(), max(), ifnull(), etc
select c.id, c.name, count(o.id) number_of_orders, ifnull(max(o.total_amount), 0) as max_amount_of_orders 
from customers c left join orders o on c.id = o.customer_id -- and o.total_amount > 100 -- faster but ... '1','John','0','0.00'
where o.total_amount > 100 or o.total_amount is null 
group by c.id, c.name 
order by c.name;
-- if count(1) or count(c.id): '4','Benny Kwok','1','0.00'
-- if count(o.id): '4','Benny Kwok','0','0.00'

select * from customers;
insert into customers values (4, 'Mary Chan', 'mary@gmail.com');
-- '1','John','john@gmail.com'
-- '2','Peter','peter@gmail.com'
-- '3','Jenny Yu','jenny@hotmail.com'
-- '4','Benny Kwok','benny@hotmail.com'
-- '4','Mary Chan','mary@gmail.com' -- duplicate key
delete from customers where name = 'Mary Chan';

-- DDL: add PK
alter table customers add constraint pk_customer_id primary key (id);
-- insert into customers values (4, 'Mary Chan', 'mary@gmail.com'); -- Error Code: 1062. Duplicate entry '4' for key 'customers.PRIMARY'
insert into customers values (5, 'Mary Chan', 'mary@gmail.com');

-- add FK (o.customer_id need to exist in c.id)
select * from orders;
alter table orders add constraint fk_customer_id foreign key (customer_id) references customers(id);
insert into orders values (8, 9000, 10, date_format('2024-08-04', '%Y-%m-%d')); -- NOT OK, we do not have customer_id 10
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`db_bc2405p`.`orders`, CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`))

-- Table Design: PK & FK ensures data is inserted / updated with integrity & consistency
-- PK and FK are also a type of constraint
-- Every table has only one PK, but may be more than one FK
-- We won't use HKID as PK, normally use table_id as PK

-- Other Constraint: unique (one or more columns can be 'unique')
select * from customers;
alter table customers add constraint unique_email unique (email); -- e.g. HKID
insert into customers values (6, 'John Chan', 'john@gmail.com'); -- Error Code: 1062. Duplicate entry 'john@gmail.com' for key 'customers.unique_email'

-- Other Constraint: not null (one or more columns can be 'not null')
alter table customers modify name varchar(50) not null;
insert into customers values (6, null, 'john@gmail.com'); -- Error Code: 1048. Column 'name' cannot be null

-- NOT EXISTS (most likely, better performance)
SELECT * FROM department d 
WHERE NOT EXISTS (SELECT 1 FROM employee e WHERE e.department_id = d.department_id);

-- Similar to NOT EXISTS, but you can select both tables
select e.*, d.* 
FROM department d LEFT JOIN employee e ON e.department_id = d.department_id;

-- customers and orders: not fit left join

select c.name, c.email from customers c 
union all 
select o.id, o.total_amount from orders o;

-- union all -> combine two result set, no matter any duplicate
select 1 from customers 
union all 
select 1 from orders;

-- union -> similar to distinct
select 1 from customers 
union 
select 1 from orders;

-- join -> *, union -> +



