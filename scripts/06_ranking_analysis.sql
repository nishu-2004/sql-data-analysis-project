/* 
  ============================================================
   Top & Bottom Performers Analysis
   ============================================================
   Purpose: Identify the best and worst performing products 
            and customers based on sales and order metrics.
   ============================================================ 
*/
-- which 5 products generate the highest revenue?
select top 5
	p.product_name,
	sum(sales_amount) as total_sales_product
from gold.fact_sales as s
left join gold.dim_products as p
on s.product_key = p.product_key
group by p.product_name
order by total_sales_product desc

-- which are the top 5 worst performing products in terms of sales?
select top 5
	p.product_name,
	sum(sales_amount) as total_sales_product
from gold.fact_sales as s
left join gold.dim_products as p
on s.product_key = p.product_key
group by p.product_name
order by total_sales_product 

-- category
select top 5
	p.subcategory,
	sum(sales_amount) as total_sales_product
from gold.fact_sales as s
left join gold.dim_products as p
on s.product_key = p.product_key
group by p.subcategory
order by total_sales_product desc


select * from(
select 
	p.product_name,
	sum(s.sales_amount) as total_sales_product,
	ROW_NUMBER() over(order by sum(s.sales_amount) desc) as rank_product
from gold.fact_sales as s
left join gold.dim_products as p
on s.product_key = p.product_key
group by p.product_name
)t
where rank_product<= 5

-- the 5 customers with the fewest orders
SELECT TOP 5
    customer_key,
    full_name,
    total_orders,
    ROW_NUMBER() OVER (ORDER BY total_orders DESC) AS rank_orders
FROM (
    SELECT
        c.customer_key,
        CONCAT(COALESCE(c.first_name, ''), ' ', COALESCE(c.last_name, '')) AS full_name,
        COUNT(DISTINCT s.order_number) AS total_orders
    FROM gold.dim_customers c
    LEFT JOIN gold.fact_sales s
        ON c.customer_key = s.customer_key
    GROUP BY c.customer_key, c.first_name, c.last_name
) AS sub
ORDER BY total_orders;

-- the 5 customers with the highest orders
select * from(
	select
		customer_key,
		full_name,
		total_orders,
		row_number() over(order by total_orders desc) as rank_customer_orders
	from(
		select
			c.customer_key,
			CONCAT(COALESCE(c.first_name, ''), ' ', COALESCE(c.last_name, '')) AS full_name,
			count(s.order_number) as total_orders
		from gold.fact_sales as s
		left join gold.dim_customers as c
		on s.customer_key = c.customer_key
		group by c.customer_key,c.first_name,c.last_name
	) t 
) ranked
where rank_customer_orders<=5
order by total_orders desc
