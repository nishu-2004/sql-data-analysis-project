/*
=========================================================
Database Schema Exploration
=========================================================
The following queries help understand the structure of the database:
1. Check which tables exist.
2. Explore columns of all tables.
3. Inspect specific tables like dim_customers, dim_products, and fact_sales to see column names, data types, and structure.
This is useful before writing queries for analytics or building reports.
===============================================================================================================================
*/
-- List all tables present in the current database
select * from INFORMATION_SCHEMA.tables;

-- List all columns for all tables in the current database
select * from INFORMATION_SCHEMA.columns;

-- List columns for a specific table: dim_customers
select * from INFORMATION_SCHEMA.columns
where TABLE_NAME = 'dim_customers';

-- List columns for a specific table: dim_products
select * from INFORMATION_SCHEMA.columns
where TABLE_NAME = 'dim_products';

-- List columns for a specific table: fact_sales
select * from INFORMATION_SCHEMA.columns
where TABLE_NAME = 'fact_sales';
