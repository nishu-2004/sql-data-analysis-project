/* 
===================================================

Data Segmentation
Create new category and aggregate the data based on new category
======================================================
*/
-- segmenting products into cost ranges and counr how many products fall in each range
WITH cost_stats AS (
    SELECT
        product_name,
        cost,
        MAX(cost) OVER() AS max_cost,
        MIN(cost) OVER() AS min_cost
    FROM gold.dim_products
)
,segmented_cost as(
	SELECT
		product_name,
		cost,
		max_cost,
		CASE
			WHEN cost < 0.3 * max_cost THEN 'Bottom 30%'
			WHEN cost >= 0.3 * max_cost AND cost < 0.7 * max_cost THEN 'Between 30-70%'
			ELSE 'Above 70%'
		END AS segmented_cost
	FROM cost_stats
)
SELECT
    segmented_cost,
    COUNT(*) AS num_products,
    ROUND((100.0 * COUNT(*) / SUM(COUNT(*)) OVER()), 2) AS percentage_of_total
FROM segmented_cost
GROUP BY segmented_cost
ORDER BY segmented_cost



with cte_cost_range as(
select 
	product_key,
	product_name,
	cost,
	case
		when cost<100 then 'Below 100'
		when cost between 100 and 500 then '100-500'
		when cost between 500 and 1000 then '500-1000'
		else
			'Above 1000'
	end as cost_range
from gold.dim_products
)
select 
	cost_range,
	count(product_key) as total_products
from cte_cost_range
group by cost_range
order by total_products  desc

/*
Customers based on speding behaviour 
1) important: 12 months of history and total spent>5000
2) regular: 12 months of historu and total spent<5000
3) new: less than 12 months
*/
with cte_customer_info as (
	select 
		c.customer_key,
		sum(s.sales_amount) as total_spending,
		min(order_date) as first_order,
		max(order_date) as last_order
	from gold.dim_customers c
	left join gold.fact_sales s
	on c.customer_key = s.customer_key
	group by c.customer_key
),
cte_partition_info as
(
	select 
		customer_key,
		case 
			when DATEDIFF(month,first_order,last_order) >=12 and total_spending>5000 then 'Important'
			when datediff(month,first_order,last_order)<12 and total_spending<5000 then 'Regular'
			else	
				'New Customer'
		end as partition 
	from cte_customer_info
)
select 
	partition,
	count(customer_key) 
from cte_partition_info
group by partition
