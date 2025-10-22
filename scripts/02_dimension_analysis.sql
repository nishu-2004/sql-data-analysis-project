USE data_warehouse;

/* 
===============================================================
   Dimension Analysis
===============================================================
   Purpose:
       This script provides a comprehensive analysis of dimension tables
       including distinct values, counts, null checks, and frequency distribution.

   Tables analyzed:
       - dim_customers
       - dim_products
================================================================= 
*/

/*
----------------------------------
1. Customers Dimension Analysis
-----------------------------------
*/

-- List distinct countries 
SELECT DISTINCT country
FROM gold.dim_customers
ORDER BY country;

--  Count of unique countries 
SELECT COUNT(DISTINCT country) AS total_countries
FROM gold.dim_customers;

/* Check for missing values in key columns */
SELECT 
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS null_countries,
    SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS null_first_names,
    SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS null_last_names
FROM gold.dim_customers;

/* 
---------------------------------
2️. Products Dimension Analysis
---------------------------------- 
*/

-- List distinct categories, subcategories, and product names 
SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM gold.dim_products
ORDER BY category, subcategory, product_name;

-- Count of unique categories, subcategories, and products 
SELECT 
    COUNT(DISTINCT category) AS total_categories,
    COUNT(DISTINCT subcategory) AS total_subcategories,
    COUNT(DISTINCT product_name) AS total_products
FROM gold.dim_products;

-- Check for missing/null values in key product columns */
SELECT 
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN subcategory IS NULL THEN 1 ELSE 0 END) AS null_subcategory,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS null_product_name
FROM gold.dim_products;

-- Frequency: Number of products per category and subcategory */
SELECT 
    category,
    subcategory,
    COUNT(product_name) AS products_count
FROM gold.dim_products
GROUP BY category, subcategory
ORDER BY category, subcategory;
