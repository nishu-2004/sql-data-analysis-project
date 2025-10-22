use data_warehouse;
/*
===============================================================
Product Report
===============================================================
Purpose:
	- This report consolidates key product metrics and behaviors.

Highlights:
	1. Gathers essential fields such as product name, category, subcategory and cost.
	2. Segments products by revenue to identify high performers, Mid-Range or Low performers
	3. Aggregates product-level metrics:
		- total orders
		- total sales
		- total quantity sold
		- total customers (unique) 
		- lifespan (months)
	4. Calculates:
		- Recency
		- Average order revenue
		- Average monthly revenue
===============================================================
*/
with base_query as (
-- Base query
select 
	f.order_number,
	f.customer_key,
	f.product_key,
	f.order_date,
	f.shipping_date,
	f.due_date,
	f.sales_amount,
	f.quantity,
	f.price,
	p.product_id,
	p.category_id,
	p.category,
	p.subcategory,
	p.product_name,
	p.maintenance,
	p.cost,
	p.product_line,
	p.start_date
from gold.fact_sales as f
left join gold.dim_products as p
on f.product_key = p.product_key
where order_date is not null
), 
cte_aggregating_query as(
-- Aggregating query
select 
	product_id,
	product_name,
	category,
	subcategory,
	count(distinct order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct customer_key) as total_customers,
	min(order_date) as first_day_order,
	max(due_date) as last_day_delivery,
	max(order_date) as last_day_order,
	datediff(month, min(order_date),max(due_date)) as lifespan
from base_query
group by
	product_id,
	product_name,
	category,
	subcategory
)
-- Calculating the final steps for generating the report
select 
	product_id,
	product_name,
	category,
	subcategory,
	total_sales,
	case
		when total_sales <70000 then 'Low Performers'
		when total_sales between 70000 and 170000 then 'Mid Performers'
		else 'Top Performers'
	end as performance_product,
	total_orders,
	total_quantity,
	first_day_order,
	last_day_delivery,
	lifespan,
	-- recency
	datediff(month,last_day_order, getdate()) as recency,
	-- Average order revenue
	case 
		when total_orders = 0 then total_sales
		else 
			total_sales/total_orders
	end as average_revenue,
	-- average monthly revenue
	case 
		when lifespan = 0 then total_sales
		else 
			total_sales/lifespan
	end as average_monthly_revenue
from cte_aggregating_query;

/* 
=================================================================================================
Creating view
=================================================================================================
*/
go
create or alter view gold.product_report as
with base_query as (
-- Base query
select 
	f.order_number,
	f.customer_key,
	f.product_key,
	f.order_date,
	f.shipping_date,
	f.due_date,
	f.sales_amount,
	f.quantity,
	f.price,
	p.product_id,
	p.category_id,
	p.category,
	p.subcategory,
	p.product_name,
	p.maintenance,
	p.cost,
	p.product_line,
	p.start_date
from gold.fact_sales as f
left join gold.dim_products as p
on f.product_key = p.product_key
where order_date is not null
), 
cte_aggregating_query as(
-- Aggregating query
select 
	product_id,
	product_name,
	category,
	subcategory,
	count(distinct order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct customer_key) as total_customers,
	min(order_date) as first_day_order,
	max(due_date) as last_day_delivery,
	max(order_date) as last_day_order,
	datediff(month, min(order_date),max(due_date)) as lifespan
from base_query
group by
	product_id,
	product_name,
	category,
	subcategory
)
-- Calculating the final steps for generating the report
select 
	product_id,
	product_name,
	category,
	subcategory,
	total_sales,
	case
		when total_sales <70000 then 'Low Performers'
		when total_sales between 70000 and 170000 then 'Mid Performers'
		else 'Top Performers'
	end as performance_product,
	total_orders,
	total_quantity,
	first_day_order,
	last_day_delivery,
	lifespan,
	-- recency
	datediff(month,last_day_order, getdate()) as recency,
	-- Average order revenue
	case 
		when total_orders = 0 then total_sales
		else 
			total_sales/total_orders
	end as average_revenue,
	-- average monthly revenue
	case 
		when lifespan = 0 then total_sales
		else 
			total_sales/lifespan
	end as average_monthly_revenue
from cte_aggregating_query;
go

/*
===================================================================
Executing the view
===================================================================
*/

select * from gold.product_report
