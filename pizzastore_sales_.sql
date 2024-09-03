create database practice ;
use practice;
create table info(
product varchar(20),
sales_qty int,
sales_amount int

);

insert into info
values
("tv", 2, 20000);

insert into info
values
("ac", 1, 10000);

insert into info
values
("fan", 3, 50000);


insert into info
values
("mobile", 1, 20000);
select sum(sales_qty) from info;
set sql_safe_updates=0;
update info
set product="laptop"
where product= "tv";
create table city(
name varchar(20),
id int,
sales int

);
insert into info
values
("mobile", 5, 20000),
("mobile", 9, 20000),
("led", 11, 20000);
insert into city
values
("lhr", 2, 1),
("khi", 3, 2),

("khi" ,4, 3);
insert into city
values

("mubbai", 20, 19),
("dehli", 2, 16),
("bali", 20, 91);


select * from city;
 
select city.name, info.product
from city left join info on
city.sales= info.sales_qty 
union
select city.name, info.product
from city right join info on
city.sales= info.sales_qty;

