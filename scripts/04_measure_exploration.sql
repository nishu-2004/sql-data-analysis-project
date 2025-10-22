
/* 
  ============================================================
   Measures Exploration
   ============================================================
   Purpose: Analyze key business metrics from fact and dimension tables
            including sales, orders, products, and customer counts
   ============================================================
*/

-- total sales
select sum(sales_amount) as total_sales 
from gold.fact_sales;

-- total number of items sold
select sum(quantity) from gold.fact_sales;

-- how many items are sold
select count(distinct product_name) as item_sold 
from gold.dim_products;


-- average selling price per category
select distinct 
	category,
	avg(cost) as average_price_product
from gold.dim_products
group by category


-- average selling price
select 
	avg(price) as average_price 
from gold.fact_sales;

-- total number of orders
select 
	count(order_number) as total_orders
from gold.fact_sales

select 
	count(distinct order_number) as total_orders
from gold.fact_sales

-- total number of products
select 
	count(distinct product_name) as total_products
from gold.dim_products


-- total number of customers
select 
	count(customer_id) as total_customers
from gold.dim_customers

-- total number of customers who have placed order
select count(distinct customer_key) as total_customers from gold.fact_sales


-- report to show all the metrics of the business
select 'Total sales' as measure_name, sum(sales_amount) as measure_value from gold.fact_sales
union all
select 'Total quantity', sum(quantity) from gold.fact_sales
union all
select 'Total Number of orders', count(distinct order_number) from gold.fact_sales
union all
select 'Total number of products', count(product_name) from gold.dim_products
union all
select 'Total number of Customers', count(customer_key) from gold.dim_customers
