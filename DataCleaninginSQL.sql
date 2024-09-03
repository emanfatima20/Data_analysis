-- In this data cleaning we will perform these practices
--  1:Removing Duplicates from Our data
--  2: Standardize Our data
--  3: Removing extra or useless characters from our data to make it clean
--  4:Correcting data type of Each column in oy table
--  5:Working  with nulls to make data more useful to us

create database data_cleaning;
-- By being more proffesional Lets create duplicate of our table 
create table layoffs_stagging like layoffs;
insert into layoffs_stagging
select * from  layoffs;
--  Creating CTE to  Remove Duplicates
select * , row_number() over (partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions)
from layoffs;

with cte as(
select * , row_number() over (partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_no
from layoffs

)
select * from cte where row_no > 1;




CREATE TABLE `layoffs_stagging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   `row_num` int 
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_stagging2;

insert into layoffs_stagging2 
select * , row_number() over (partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_no
from layoffs;
select * from layoffs_stagging2;
 SET SQL_SAFE_UPDATES = 0;
-- Now Deleting duplicates
delete  from layoffs_stagging2
where row_num>1;
-- Now focussing on individual columns to identifying issues
-- lets trim extra spaces from company column
select  distinct company from layoffs_stagging2 ;
SET SQL_SAFE_UPDATES = 0;
 update layoffs_stagging2
 set company =trim(company);
 
--  Correcting naming Issue from industry column
 select distinct industry from  layoffs_stagging2;
update layoffs_stagging2
set industry ='Crypto Currency'
 where industry = 'CryptoCurrency';
 
--  Removing irrelevant special characters from end
select distinct country from layoffs_stagging2;
 select distinct trim(trailing'...' from  country) from layoffs_stagging2;
 update layoffs_stagging2
set country =trim(trailing' ...' from  country);
 select distinct industry from  layoffs_stagging2;
 -- Correcting the Data type of date column
 select date, str_to_date(date,'%m/%d/%Y') from layoffs_stagging2;
 update layoffs_stagging2
set date = str_to_date(date,'%m/%d/%Y') ;
select * from layoffs_stagging2;
alter table layoffs_stagging2
modify column date date;
-- Dealing With Nulls
select * from layoffs_stagging2
where industry is null  or industry ='';
select * from layoffs_stagging
where  company= 'Carvana';

select * from layoffs_stagging
where  company = "Bally's Interactive";
select * from layoffs_stagging2;
alter table layoffs_stagging2
drop column row_num;
select * from layoffs_stagging2;

update layoffs_stagging2
set industry = "Consumer"
where company = "Juul" and industry = "";




select * from layoffs_stagging2
where total_laid_off is null  and percentage_laid_off is null;


select * from layoffs_stagging
where  company = "Bally's Interactive";

update layoffs_stagging2
set industry = "Travel"
where company = "Airbnb" and industry = "";
update layoffs_stagging2
set industry = "Consumer"
where company = "Juul" and industry = "";

delete from layoffs_stagging2
where total_laid_off is null  and percentage_laid_off is null;

-- Dropping row_num which is now not useful for us
alter table layoffs_stagging2 
drop column row_num;