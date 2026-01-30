-- Use “World” Database to solve the following questions 
-- (Hint : World Database is inbuilt in SQL Workbench so use code “use world;” to make use of the database)
USE WORLD;
SELECT * FROM CITY;
SELECT * FROM COUNTRY;
SELECT * FROM COUNTRYLANGUAGE;
-- Question 1 : Count how many cities are there in each country?
SELECT distinct COUNT(NAME) FROM CITY;

-- Question 2 : Display all continents having more than 30 countries.
select distinct continent, count(*) as countries from country group by continent having count(*) > 30;

-- Question 3 : List regions whose total population exceeds 200 million.
select Region, Population from country having Population > 200000000;

-- Question 4 : Find the top 5 continents by average GNP per country.
select Continent, avg(GNP) as avg_gnp
from country group by Continent 
order by avg_gnp DESC limit 5;

-- Question 5 : Find the total number of official languages spoken in each continent.
SELECT c.Continent, count(cl.Language) as lang_count
FROM COUNTRY as c left join COUNTRYLANGUAGE as cl
on c.Code = cl.CountryCode
and cl.IsOfficial = 'T' group by c.Continent;


-- Question 6 : Find the maximum and minimum GNP for each continent.
select continent, max(GNP), min(GNP) from country group by continent;

-- Question 7 : Find the country with the highest average city population.
select Continent, avg(Population) as avg_p from country 
group by Continent order by avg_p DESC limit 1;

-- Question 8 : List continents where the average city population is greater than 200,000.
select Continent, avg(Population) as avg_p
from country where Population > 200000 group by Continent order by avg_p DESC;

-- Question 9 : Find the total population and average life expectancy for each continent, ordered by average life
-- expectancy descending.
select Continent, sum(Population) as sum_p, avg(LifeExpectancy) as avg_l
from country group by Continent order by avg_l DESC;

-- Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where
-- the total population is over 200 million.
select Continent, avg(LifeExpectancy) as avg_l
from country where Population > 200000000 
group by Continent order by avg_l DESC limit 3;