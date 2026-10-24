# 🏗️ Data Forge — PostgreSQL Data Warehouse
 
A data warehouse built from scratch with PostgreSQL, SQL, and the Medallion Architecture. It transforms raw CRM and ERP data into clean, analytics-ready datasets.
 
> **Project status:** ✅ Bronze, Silver and Gold layers implemented. 🚧 BI reporting and documentation diagrams in progress.
 
## 📌 Table of Contents
 
- [Overview](#-overview)
- [Business Requirements](#-business-requirements)
- [Objectives](#-objectives)
- [Architecture](#-architecture)
- [Data Model](#-data-model)
- [Technology Stack](#-technology-stack)
- [BI & Reporting](#-bi--reporting)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Project Roadmap](#-project-roadmap)
- [License](#-license)
- [About Me](#-about-me)
## 🎯 Overview
 
Data Forge is a hands-on Data Engineering project that designs and builds a SQL-based data warehouse.
 
It integrates data from two source systems, CRM (Customer Relationship Management) and ERP (Enterprise Resource Planning), into one analytical environment. Six CSV files are loaded, cleaned, standardized, and modeled into a star schema for business intelligence and reporting.
 
## 📋 Business Requirements
 
- **Data integration:** Consolidate customer, product, and sales data from CRM and ERP sources.
- **Data quality:** Handle missing values, duplicates, inconsistent formats, and invalid records.
- **Centralized analytics:** Provide one consistent source of data for reporting.
- **Historical tracking:** Product history is rebuilt in Silver, and Gold exposes current products.
- **Documentation:** Document the data model and every Gold object in a data catalog.
## 🎯 Objectives
 
1. Design a data warehouse using the Medallion architecture.
2. Build SQL-based ETL pipelines with PL/pgSQL stored procedures.
3. Implement Bronze, Silver, and Gold layers.
4. Apply data cleansing, standardization, and validation.
5. Build a dimensional model (star schema) with facts and dimensions.
6. Validate each layer with quality-check scripts.
7. Use Git and GitHub for version control and documentation.
## 🏛️ Architecture
 
The project follows the **Medallion Architecture**.
 
### 🥉 Bronze: Raw Data
 
- Raw CSV files loaded as is, with no transformation (full load: `TRUNCATE` + `COPY`).
- 6 tables: 3 from CRM, 3 from ERP.
- Loaded by `CALL bronze.load_bronze();`
### 🥈 Silver: Cleaned Data
 
- Duplicates and NULL keys removed (`ROW_NUMBER()`).
- Text trimmed and coded values standardized (`M` becomes `Male`, `DE` becomes `Germany`, and so on).
- Invalid dates and amounts corrected or set to NULL; `prd_key` split into category ID and product key.
- Product end dates rebuilt with `LEAD()`.
- Loaded by `CALL silver.load_silver();`
### 🥇 Gold: Business-Ready Data
 
- Three SQL views forming a star schema: `gold.dim_customers`, `gold.dim_products`, `gold.fact_sales`.
- Customer data from CRM and ERP is integrated with LEFT JOINs (the CRM is the master source).
- See [`docs/data_catalog.md`](docs/data_catalog.md) for every column.
## 🧩 Data Model
 
```
gold.dim_customers (customer_key) 1 ----< N gold.fact_sales
gold.dim_products  (product_key)  1 ----< N gold.fact_sales
```
 
| Object | Type | Description |
|---|---|---|
| `gold.dim_customers` | Dimension | One row per customer (profile, gender, birth date, country) |
| `gold.dim_products` | Dimension | One row per current product, with category and subcategory |
| `gold.fact_sales` | Fact | One row per sales order line |
 
## 🛠️ Technology Stack
 
| Technology | Purpose |
|---|---|
| PostgreSQL | Relational database and SQL processing |
| SQL | Loading, cleansing, transformation, and analytics |
| PL/pgSQL | Stored procedures for the Bronze and Silver loads |
| Git & GitHub | Version control |
| VS Code | SQL development |
| DBeaver Community | Database client and query execution |
| Draw.io | Architecture and data-flow diagrams |
 
## 📊 BI & Reporting
 
The Gold layer is ready to support reporting. Questions it can answer:
 
- What is the total revenue over a given period?
- Which products and categories generate the most revenue?
- Who are the highest-value customers?
- How do sales evolve over time, and how do they differ by country?
A BI dashboard (Power BI or an alternative) is the next step.
 
## 📁 Project Structure
 
```text
postgres-data-warehouse/
├── datasets/
│   ├── source_crm/
│   └── source_erp/
├── docs/
│   └── data_catalog.md
├── scripts/
│   ├── init_database.sql
│   ├── create_schemas.sql
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   └── proc_load_silver.sql
│   └── gold/
│       └── ddl_gold.sql
├── tests/
│   ├── quality_checks_silver.sql
│   └── quality_checks_gold.sql
├── README.md
└── LICENSE
```
 
## 🚀 Getting Started
 
### Prerequisites
 
- PostgreSQL 13+ installed and running
- Git
- VS Code or another SQL editor
- DBeaver Community Edition or an equivalent database client
### Setup
 
1. Clone the repository:
```bash
   git clone https://github.com/ZnitaMohamed4/postgres-data-warehouse.git
   cd postgres-data-warehouse
```
 
2. Make the CSV files readable by the PostgreSQL server. `COPY` runs as the `postgres` user, which usually cannot read your home folder, so copy the datasets to `/tmp`:
```bash
   cp -r datasets /tmp/datasets
   chmod -R a+rX /tmp/datasets
```
 
   The file paths used by `bronze.load_bronze()` point to `/tmp/datasets/...`. Adjust them in `scripts/bronze/proc_load_bronze.sql` if you use another location.
 
3. Run the scripts in this order (connected to the right database):
   | Order | Script | Connect to |
   |---|---|---|
   | 1 | `scripts/init_database.sql` (drops and recreates the DB) | `postgres` |
   | 2 | `scripts/create_schemas.sql` | `datawarehouse` |
   | 3 | `scripts/bronze/ddl_bronze.sql` | `datawarehouse` |
   | 4 | `scripts/bronze/proc_load_bronze.sql` | `datawarehouse` |
   | 5 | `scripts/silver/ddl_silver.sql` | `datawarehouse` |
   | 6 | `scripts/silver/proc_load_silver.sql` | `datawarehouse` |
   | 7 | `scripts/gold/ddl_gold.sql` | `datawarehouse` |
4. Load the data:
```sql
   CALL bronze.load_bronze();
   CALL silver.load_silver();
```
 
   The Gold views update automatically, since they read from Silver.
 
5. Validate with the scripts in `tests/`. Every check should return no rows.
> Note: `init_database.sql` deletes the `datawarehouse` database. Do not run it on data you want to keep.
 
## 🗺️ Project Roadmap
 
- [x] Initialize the repository and establish naming conventions.
- [x] Analyze the source CRM and ERP datasets.
- [ ] Document the architecture and data flow diagrams.
- [x] Create the database and the Bronze, Silver, and Gold schemas.
- [x] Implement Bronze tables and the load procedure.
- [x] Develop Silver transformations, the load procedure, and quality checks.
- [x] Design the customer and product dimensions.
- [x] Build the sales fact model and star schema.
- [x] Develop Gold views and quality checks.
- [x] Document the data catalog.
- [ ] Add BI reporting and validate business KPIs.
- [ ] Add automated testing and further data engineering tools.
## 📄 License
 
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
 
## 👨‍💻 About Me
 
I'm **Mohamed Znita**, a Master's graduate in Artificial Intelligence and Data Science, interested in building reliable data systems and developing practical Data Engineering skills.
 
This project is part of my journey toward mastering SQL, data warehousing, ETL pipelines, dimensional modeling, and business intelligence. It follows the structure of a public data engineering tutorial, adapted from SQL Server to PostgreSQL.
 
**Connect with me:**
 
- GitHub: [@ZnitaMohamed4](https://github.com/ZnitaMohamed4)
---
 
*Built with PostgreSQL, SQL, and a commitment to learning by building.*
 