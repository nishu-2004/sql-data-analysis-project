
# Data Warehouse & Analytics Project (Continuation)

This project is a continuation of my previous work on the [SQL Data Warehouse Project](https://github.com/nishu-2004/SQL-data-warehouse-project), focusing on **advanced reporting, customer and product analytics, and segmentation**.

## 📂 Repository Structure

```

.
├── docs/                   # Contains the diagram of the flow of my project
├── scripts/                # SQL scripts for data warehouse, reports, and analytics          
├── powerbi/                # Power BI reports (to be developed)
└── README.md

```

---

## 🏗️ Project Overview

This project extends the **SQL data warehouse** from the previous repository to provide more **insights and actionable analytics** for both products and customers.

**Key Objectives:**

1. Consolidate essential fields such as product name, category, subcategory, and cost.
2. Segment products by revenue and cost:
   - Low / Mid / Top performers
   - Bottom 30% / 30-70% / Above 70% cost ranges
3. Generate product-level metrics:
   - Total orders, total sales, total quantity, total customers, lifespan, recency
   - Average order revenue, average monthly revenue
4. Generate customer-level metrics:
   - Total orders, total sales, total quantity, total products, lifespan, recency
   - Segmentation based on spending behavior: Important, Regular, New
   - Age groups: Under 20, 20-29, 30-39, 40-49, 50 and above
5. Perform time-series and cumulative analyses:
   - Yearly and monthly sales
   - Running totals and moving averages
   - Year-over-year comparisons
6. Identify contributions of categories and products to overall sales.

---

## 📝 Highlights of the SQL Scripts

- **Product Report (`product_report.sql`)**
  - Aggregates product sales metrics.
  - Computes lifespan, recency, average revenue, and monthly revenue.
  - Segments products based on revenue.

- **Customer Report (`customer_report.sql`)**
  - Aggregates customer transactions.
  - Segments customers into Important, Regular, and New based on spending and history.
  - Calculates age groups, recency, average order value, and average monthly spending.

- **Segmentation (`segmentation.sql`)**
  - Cost-based segmentation of products.
  - Customer segmentation based on total spending and history.

- **Time Analysis (`time_analysis.sql`)**
  - Yearly and monthly aggregation of sales.
  - Cumulative analysis using window functions.
  - Part-to-whole analysis for categories and products.

- **Views (`views.sql`)**
  - Scripts for creating/updating reusable views like `product_report` and `report_customers`.

---

## ⚡ Future Work

- Develop **Power BI reports** for interactive dashboards based on the above SQL outputs.
- Connect SQL views directly to Power BI for **live data visualization**.

---

## 📊 Technologies Used

- SQL Server / T-SQL
- Window functions and CTEs
- Data Warehousing (Bronze/Silver/Gold layers)
- Aggregation, segmentation, and reporting

---

## 📌 Notes

- All scripts are written to be **idempotent** wherever possible (using `CREATE OR ALTER VIEW`).
- SQL scripts assume the database context is `data_warehouse`.
- Power BI folder is currently empty but will contain dashboards connecting to these SQL views.

---

## 📄 License

This repository is licensed under the [MIT License](LICENSE).
