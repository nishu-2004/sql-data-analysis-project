
/* 
=================================================================
Customer Report 
=================================================================
Purpose:
	This report consolidates key customer metrics and behaviors

Highlights:
	1. Gathers essential fields such as names, ages and transaction details.
	2. segments customers into categories (important, Regular, New) and age groups.
	3. Aggregates customer level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- lifespan(in months)
	4. Calculates:
		- recency (months since last order) 
		- average order value
		- average monthly spending
==================================================================
*/
with base_query as (
-- Step 1: Retrieving columns
select 
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_key,
	concat(coalesce(c.first_name,''),' ',coalesce(c.last_name,'')) as full_name,
	c.customer_number,
	datediff(year,c.birthdate,getdate()) as age
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
where order_date is not null
),
customer_aggregation as 
(
-- Step 2: aggregating functions
select 
	customer_key,
	customer_number,
	full_name,
	age,
	count(distinct order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct product_key) as total_products,
	max(order_date) as last_order,
	datediff(month,min(order_date),max(order_date)) as lifespan
from base_query
group by customer_key,
	customer_number,
	full_name,
	age
)
-- Reporting query
select 
	customer_key,
	customer_number,
	full_name,
	age,
	case 
		when age<20 then 'Under 20'
		when age between 20 and 29 then '20-29'
		when age between 30 and 39  then '30-39'
		when age between 40 and 49  then '40-49'
		else
			'50 and above'
	end as age_group,
	case 
		when age >=12 and total_sales >5000 then 'Important'
		when age <12 and total_sales<5000 then 'Regular'
		else	
			'New Customer'
	end as customer_segment, 
	last_order,
	datediff(month,last_order,getdate()) as recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	lifespan,
	-- compute average order value
	case
		when total_orders = 0 then 0
		else
			total_sales/total_orders  
	end as average_order_value,
	-- average monthly spend
	case 
		when lifespan = 0 then total_sales
		else
			total_sales/lifespan
	end as average_monthly_spending
from customer_aggregation

/*
================================================================
Creating a view
================================================================
*/
create or alter view gold.report_customers as 
with base_query as (
-- Step 1: Retrieving columns
select 
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_key,
	concat(coalesce(c.first_name,''),' ',coalesce(c.last_name,'')) as full_name,
	c.customer_number,
	datediff(year,c.birthdate,getdate()) as age
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
where order_date is not null
),
customer_aggregation as 
(
-- Step 2: aggregating functions
select 
	customer_key,
	customer_number,
	full_name,
	age,
	count(distinct order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct product_key) as total_products,
	max(order_date) as last_order,
	datediff(month,min(order_date),max(order_date)) as lifespan
from base_query
group by customer_key,
	customer_number,
	full_name,
	age
)
-- Reporting query
select 
	customer_key,
	customer_number,
	full_name,
	age,
	case 
		when age<20 then 'Under 20'
		when age between 20 and 29 then '20-29'
		when age between 30 and 39  then '30-39'
		when age between 40 and 49  then '40-49'
		else
			'50 and above'
	end as age_group,
	case 
		when age >=12 and total_sales >5000 then 'Important'
		when age <12 and total_sales<5000 then 'Regular'
		else	
			'New Customer'
	end as customer_segment, 
	last_order,
	datediff(month,last_order,getdate()) as recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	lifespan,
	-- compute average order value
	case
		when total_orders = 0 then 0
		else
			total_sales/total_orders  
	end as average_order_value,
	-- average monthly spend
	case 
		when lifespan = 0 then total_sales
		else
			total_sales/lifespan
	end as average_monthly_spending
from customer_aggregation

/*
=============================================================
Executing the view
=============================================================
*/
select * from gold.report_customers
