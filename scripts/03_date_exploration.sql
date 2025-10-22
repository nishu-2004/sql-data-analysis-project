use data_warehouse;

/* 
  ============================================================
   Datetime Analysis
   ============================================================
   Purpose: Analyze date-related information in fact and dimension tables
            to understand order timelines and customer age ranges
   ============================================================ 
*/

/* 
-------------------------
   Fact Sales Table - Order Date Range
------------------------- 
*/
select 
    min(order_date) as first_date,    -- earliest order date
    max(order_date) as last_date,     -- latest order date
    datediff(year, min(order_date), max(order_date)) as range_years  -- span in years
from gold.fact_sales;

/* 
-------------------------
   Dim Customers Table - Customer Birthdate Range
------------------------- 
*/
select 
    min(birthdate) as oldest_customer,  -- earliest birthdate
    datediff(year, min(birthdate), getdate()) as oldest_age,  -- oldest age
    max(birthdate) as youngest_customer, -- latest birthdate
    datediff(year, max(birthdate), getdate()) as youngest_age -- youngest age
from gold.dim_customers;
