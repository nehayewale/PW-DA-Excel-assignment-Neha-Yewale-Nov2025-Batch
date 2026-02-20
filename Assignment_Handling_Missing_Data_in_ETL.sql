-- SECTION B – PRACTICAL QUESTIONS
create database monthly_sales;
use monthly_sales;

create table regional_sales(
Customer_ID int,
cname varchar(50),
city varchar(30),
monthly_sale int,
income int,
region varchar(30)
);

insert into regional_sales(Customer_ID, cname, city, monthly_sale, income, region)
values
(101, 'Rahul Mehta', 'Mumbai', 12000, 65000, 'West'),
(102, 'Anjali Rao', 'Bengaluru',  null,  null, 'South'),
(103, 'Suresh Iyer', 'Chennai', 15000, 72000, 'South'),
(104, 'Neha Singh', 'Delhi', null, null, 'North'),
(105, 'Amit Verma', 'Pune', 18000, 58000, null),
(106, 'Karan Shah', 'Ahmedabad', null, 61000, null),
(107, 'Pooja Das', 'Kolkata', 14000, null, 'East'),
(108, 'Riya Kapoor', 'Jaipur', 16000, 69000, 'North');

select * from regional_sales;
-- truncate TABLE regional_sales;
-- Use the given dataset for all questions.
-- Q8. Listwise Deletion 
-- Remove all rows where Region is missing.
-- Tasks: 1.Identify affected rows. 2.Show the dataset after deletion, 3.Mention how many records were lost
select * from regional_sales where region is null;
select count(*) as beforeDeletion from regional_sales;
delete from regional_sales where region is null;
SELECT * FROM regional_sales;
select count(*) as afterDeletion from regional_sales;

-- Q9. Imputation 
-- Handle missing values in Monthly_Sales using:
-- Forward Fill
-- Tasks: 1. Apply forward fill, 2. Show before vs after values
select Customer_ID, monthly_sale from regional_sales order by Customer_ID;
select Customer_ID, monthly_sale as Before_Value,
    coalesce(
		monthly_sale, max(monthly_sale) over (order by Customer_ID rows between unbounded preceding and current row)
    ) as After_Forward_Fill   
 from regional_sales order by Customer_ID;


-- Q10. Flagging Missing Data
-- Create a flag column for missing Income.
-- Tasks: Create Income_Missing_Flag (0 = present, 1 = missing), Show updated dataset, Count how many customers have missing income

alter table regional_sales add primary key (Customer_ID);
update regional_sales
set Income_Missing_Flag =
case
	when income is null then 1
    else 0
end;

select Customer_ID, cname, income, Income_Missing_Flag from regional_sales order by Customer_ID;

select count(*) as Missing_Income_Count from regional_sales where Income_Missing_Flag = 1;
