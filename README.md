# 📦 Data Warehouse & Analytics Project — SQL + Power BI

This project is a continuation of my earlier work on the
👉 **[SQL Data Warehouse Project](https://github.com/nishu-2004/SQL-data-warehouse-project)**

The focus of this extension is on:

* advanced reporting
* customer & product analytics
* segmentation & behavioral insights
* interactive dashboards in Power BI

The solution follows a **modern data-warehouse workflow**:

> ETL → Fact & Dimension Modeling → Gold Views → Analytics Reports → Dashboards

---

## 📂 Repository Structure

```
.
├── docs/                     # Architecture & workflow diagrams
├── scripts/                  # SQL scripts for warehouse, reporting & analytics
├── powerbi/
│   ├── dashboards/           # Power BI .pbix files (to be added later)
│   └── screenshots/          # Exported dashboard images
└── README.md
```

---

## 🏗️ Project Overview

This project builds on top of the SQL data warehouse and extends it into:

* customer-level analytics
* product-level analytics
* segmentation logic
* time-series reporting
* business intelligence dashboards

The reporting layer consumes curated Gold-layer warehouse views and produces **actionable insights** for decision-making.

---

## 🎯 Key Objectives

### ✔ Product-Level Analytics

* total orders, sales, quantity, customers
* lifespan & recency
* average order revenue
* average monthly revenue
* revenue-based segmentation
* cost-range segmentation

### ✔ Customer-Level Analytics

* total sales, orders, quantity, products interacted with
* lifespan & recency
* spending-based segmentation:

  * New
  * Regular
  * Important
* age-band grouping

### ✔ Time-Series & Cumulative Analysis

* yearly & monthly trends
* running totals
* moving averages
* YoY comparisons

### ✔ Part-to-Whole Contribution

* category contribution
* product-line contribution

---

## 📝 Highlights of the SQL Layer

### 🧾 Product Report (`product_report.sql`)

* aggregates product-level metrics
* computes lifespan, recency, avg revenue
* derives monthly revenue signals
* classifies products by performance

---

### 🧾 Customer Report (`customer_report.sql`)

* aggregates customer transaction metrics
* builds spend-based segmentation
* calculates AOV & recency
* assigns age group distribution

---

### 🧾 Segmentation (`segmentation.sql`)

* revenue-tiered product segmentation
* cost-bucket classification
* behavioral customer segmentation

---

### 🧾 Time Analysis (`time_analysis.sql`)

* yearly & monthly aggregations
* cumulative window functions
* contribution breakdowns

---

### 🧾 Reusable Analytics Views (`views.sql`)

Creates warehouse-ready Gold views such as:

* `gold.product_report`
* `gold.report_customers`

These views serve as the **semantic layer for BI tools**.

---

# 📊 Power BI Reporting & Dashboard Layer

Power BI connects directly to the curated Gold views:

* `gold.fact_sales`
* `gold.dim_products`
* `gold.dim_customers`
* `gold.product_report`
* `gold.report_customers`

This enables:

* live query connectivity
* reusable metric definitions
* dimensional drill-down across customer, product & time

---

## 🧭 Index / Navigation Page

Serves as the entry point into the analytics experience and routes users to each dashboard module.

📸 Screenshot
`![Index Page](powerbi/screenshots/index_page.png)`

---

## 📈 KPI & Summary Dashboard

High-level executive reporting:

* Total Sales
* Number of Customers
* Total Quantity
* Top-10 Best Selling Products
* Sales by Category
* Sales vs Quantity (trend over time)
* Gender-wise sales contribution

📸 Screenshot
`![KPI Dashboard](powerbi/screenshots/kpi_dashboard.png)`

---

## 🧑‍🤝‍🧑 Customer Insight Dashboard

Focuses on demographic, behavioral & spending analytics:

* Customers by Age Group
* Average Order Value by Age Group
* Sales contribution by Age Group
* Gender-based customer distribution
* Country-wise customer distribution (map)

📸 Screenshot
`![Customer Insights](powerbi/screenshots/customer_insights.png)`

---

## 🏷️ Product Performance Dashboard

Designed for portfolio & category analysis:

* Sales by Product Line
* Product Category Contribution (treemap)
* Top Product Lines by Quantity Sold
* Maintenance Cost vs Sales (scatter plot)

Helps identify:

* high-volume vs high-revenue products
* underperforming segments
* cost-to-revenue relationships

📸 Screenshot
`![Product Performance](powerbi/screenshots/product_performance.png)`

---

## 🚚 Sales Operations & Order Insights

Covers operational performance & order trends:

* Orders over Time
* Shipping Performance Trend
* Sales vs Price vs Quantity (bubble scatter)
* Interactive slicers for:

  * date range
  * product category
  * product line

📸 Screenshot
`![Sales Operations](powerbi/screenshots/sales_operations.png)`

---

## 🧠 Insights Enabled

The platform helps answer:

* Which product lines generate the most revenue?
* Which age segments spend the most?
* How do order volumes trend across years?
* Which regions contain most customers?
* How does price relate to quantity & sales?
* Which categories dominate contribution share?
* Which product lines need optimization focus?

---

## 🔮 Planned Enhancements

* Product & Customer drill-through navigation
* Bookmark-based storytelling dashboards
* Deployment to Power BI Service
* Scheduled data refresh
* Role-based Row-Level Security

---

## 🛠️ Technologies Used

* SQL Server / T-SQL
* Window Functions & CTEs
* Data Warehouse Layering (Bronze → Silver → Gold)
* Segmentation & Aggregation pipelines
* Power BI (Analytics & Visualization)

---

## 📌 Notes

* SQL scripts follow idempotent patterns (`CREATE OR ALTER`)
* Database context:

  ```
  data_warehouse
  ```
* Power BI connects to SQL views rather than raw tables

---

## 📄 License

This project is licensed under the **MIT License**.

