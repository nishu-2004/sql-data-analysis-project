/* 
  ============================================================
   Change Over Time Analysis
   ============================================================
   Purpose: Analyze sales trends over different time periods 
            (yearly and monthly) using aggregation and date functions.
   ============================================================ 
*/

-- sales per year

select 
	year(order_date) as order_year,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by year(order_date)
order by year(order_date) 


-- sales per month
select 
	year(order_date) as order_year,
	month(order_date) as order_month,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by year(order_date),month(order_date)
order by month(order_date),year(order_date)

-- using datetrunc
select 
	DATETRUNC(month,order_date) as order_date,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by DATETRUNC(month,order_date)
order by DATETRUNC(month,order_date)
