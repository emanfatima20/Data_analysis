create database covid;

select * from coviddeaths;
select * from covidvaccination;

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
select location,  date, total_deaths, total_cases, (total_deaths/total_cases)*100 as DeathPercentage  from coviddeaths
where continent  != " ";


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
select location, date, total_cases, population,(total_cases/population*100) as InfectedPeoplePercentage  from coviddeaths
 where 
continent != '';

-- Countries with Highest Infection Rate compared to Population
select location, population, avg(total_cases/population*100) as InfectionRate from coviddeaths
where continent is not null
group by location  , population
order by InfectionRate  desc;

-- Countries with Highest Infection Rate compared to Population
select location, population, sum(total_cases) as Sumofcases , max(total_cases/population)*100 as Rate from coviddeaths
where continent  != " "
group by location , population
order by Rate desc;


-- Countries with Highest Death Count per Population

select location, avg(total_deaths/population*100) as Deathrate from coviddeaths
where continent  != " "
group by location
order by Deathrate desc;

select location, max(total_deaths) as deathnum, max(total_deaths/population*100) as Deathrate from coviddeaths
where continent is not null 
group by location 
order by deathnum desc;


-- Continent with Highest Death Count per Population
select continent,  max(total_deaths) as deathnum, max(total_deaths/population*100) as Deathrate from coviddeaths
where continent  != " "
group by continent 
order by deathnum desc;


 -- Total number of new cases and total cases per day
select date, sum(total_cases), sum(new_cases) from coviddeaths
group by date;

 -- Percentage of total deaths and cases per day
select date, sum(total_cases), sum(total_deaths), (sum(total_deaths)/sum(total_cases)*100) as PercentageofTotarDeaths from coviddeaths
where continent != ""
group by date;

-- Percentage of New deaths and new cases per day
select date, sum(new_cases), sum(new_deaths), sum(new_deaths)/sum(new_cases)*100) as PercentageofTotarDeaths from coviddeaths
where continent != ""
group by date;


-- Calculating overall total cases , total deaths, new cases, new deaths
select sum(total_cases), sum(total_deaths), sum(new_cases), sum(new_deaths)
from coviddeaths where continent !="";




