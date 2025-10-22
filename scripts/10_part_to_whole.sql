/*
================================================================
 Part to whole analysis

Analyze how an individual part is performing compared to the overall,
allowing us to understand which category has the greatest impact on the business
================================================================
*/

-- category of product that impacts business the most

select 
	p.category,
	sum(s.sales_amount) as total_sales,
	round(
		100.0*sum(s.sales_amount)/sum(sum(s.sales_amount)) over(),
		2
	) as percentage_o_total
from gold.fact_sales s
left join gold.dim_products p 
on s.product_key = p.product_key
group by p.category
order by percentage_o_total desc
;
-- or

with category_sales as
(
select 
category,
sum(sales_amount) as total_sales
from gold.fact_sales f
left join gold.dim_products p
on p.product_key = f.product_key
group by category)
select category,
total_sales,
sum(total_sales) over() overall_sales,
concat(round((cast(total_sales as float)/sum(cast(total_sales as float)) over() )*100,2),'%') as percentage_of_total
from category_sales
order by total_sales desc



-- contribution by product name
select top 5
	p.product_name,
	sum(sales_amount) as total_sales_per_product,
	round(
		100.0*sum(s.sales_amount)/sum(sum(s.sales_amount)) over(),
		2
	) as percentage_o_total
from gold.fact_sales s
left join gold.dim_products p 
on s.product_key = p.product_key 
group by p.product_name
order by percentage_o_total desc


-- contributions of products partitioning by category
WITH category_sales AS (
    SELECT 
        p.product_name,
        p.category,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.category, p.product_name
),
ranked_sales AS (
    SELECT 
        product_name,
        category,
        total_sales,
        SUM(total_sales) OVER() AS overall_sales,
        CONCAT(
            ROUND(
                (CAST(total_sales AS FLOAT) /
                SUM(CAST(total_sales AS FLOAT)) OVER(PARTITION BY category)) * 100, 2
            ), '%'
        ) AS percentage_of_total,
        ROW_NUMBER() OVER(PARTITION BY category ORDER BY total_sales DESC) AS rnk
    FROM category_sales
)
SELECT 
    category,
    product_name,
    total_sales,
    percentage_of_total
FROM ranked_sales
WHERE rnk <= 5
ORDER BY category, total_sales DESC;

