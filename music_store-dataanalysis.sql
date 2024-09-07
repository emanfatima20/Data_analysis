create database music_store;
drop database music_store; 
-- Q: Whi is the most senior employee based on level?
Select employee_id, first_name, levels from employee
order by levels desc limit 1;


-- Q:Which countries have the most invoices
select billing_country, count(invoice_id) total_invoices from invoice
group by billing_country 
order by total_invoices desc;

-- Q:What are top 3 values of total invoices
select invoice_id, total from invoice
order by total desc limit 3 ;

-- Q:which city has best costumers like write a query that returns city
--  with highest sum of total invoices
select billing_city, sum(total) as sum from invoice
group by billing_city 
order by sum desc limit 1;

-- Q:Which customer has spent most money;
select customer.customer_id, sum(invoice.total) as total
from customer  join invoice
on customer.customer_id= invoice.customer_id
group by customer.customer_id
order by total desc;

-- Q Return all the track names that have song length than average song length 
-- Return the name and milliseconds for each track.Order by the song length with the longest song
-- listed first 


 with cte as (
  select name, milliseconds, (select avg(milliseconds)  from track) as totalavg
 from track
 )
 select * from cte
  where milliseconds > totalavg
  order by milliseconds desc;
 
 select name, milliseconds from track where milliseconds >(
  select avg(milliseonds) from track
 )
 order by milliseonds desc;
 
--  Q: Return  first name ,last name, email of those who listens to rock genre
 select customer.first_name, customer.last_name, customer.email
 from customer join invoice on
 invoice.customer_id= customer.customer_id
 join invoice_line on
   invoice.invoice_id=  invoice_line.invoice_id
where track_id in (
  select track_id from track
 where genre_id= 1
);



--  Finding the world wide most popular genre also return genre name , id and country
select genre.genre_id , genre.name, invoice.billing_country, sum(invoice.total) over (partition by genre.genre_id) as total
from invoice  join invoice_line 
on invoice.invoice_id =invoice_line.invoice_id
 join track 
on  invoice_line.track_id = track.track_id
join genre  
on genre.genre_id= track.genre_id
order by total desc;

-- Q Performance of each genre for each country
with cte1 as(
select genre.genre_id as genreid , genre.name as genrename, invoice.billing_country as coun, (invoice.total)  as total
from invoice  join invoice_line 
on invoice.invoice_id =invoice_line.invoice_id
 join track 
on  invoice_line.track_id = track.track_id
join genre  
on genre.genre_id= track.genre_id
)
select  coun, genreid, sum(total) from cte1
group by genreid , coun 
order by coun desc;
