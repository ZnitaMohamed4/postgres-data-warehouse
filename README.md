# 🏗️ Data Forge — PostgreSQL Data Warehouse

Building a modern data warehouse from scratch using PostgreSQL, SQL, and the Medallion Architecture to transform raw CRM and ERP data into clean, analytics-ready datasets.

> **Project status:** 🚧 In development

## 📌 Table of Contents

- [Overview](#-overview)
- [Business Requirements](#-business-requirements)
- [Objectives](#-objectives)
- [Technical Specifications](#-technical-specifications)
- [Architecture](#-architecture)
- [Technology Stack](#-technology-stack)
- [BI & Reporting](#-bi--reporting)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Project Roadmap](#-project-roadmap)
- [License](#-license)
- [About Me](#-about-me)

## 🎯 Overview

Data Forge is a hands-on Data Engineering project focused on designing and building a SQL-based data warehouse from scratch.

The project integrates data from CRM (Customer Relationship Management) and ERP (Enterprise Resource Planning) source systems into a centralized analytical environment.

Using a layered architecture, raw data will be loaded, cleaned, standardized, and modeled to support business intelligence and analytical reporting.

The project follows the concepts demonstrated in the tutorial [SQL Data Warehouse from Scratch | Full Hands-On Data Engineering Project](https://www.youtube.com/watch?v=9GVqKuTVANE), with PostgreSQL used as the database engine.

## 📋 Business Requirements

The data warehouse aims to address the following business needs:

- **Data integration:** Consolidate customer, product, and sales data from multiple CRM and ERP sources.
- **Data quality:** Identify and handle missing values, duplicates, inconsistent formats, and invalid records.
- **Centralized analytics:** Provide a consistent source of data for business reporting.
- **Historical tracking:** Structure customer and product data to support historical analysis where required.
- **Analytical performance:** Organize data for efficient business queries and aggregations.
- **Documentation:** Maintain clear technical documentation of the architecture, transformations, and data flows.

## 🎯 Objectives

The primary objectives are to:

1. Design a data warehouse architecture using the Medallion approach.
2. Develop SQL-based ETL pipelines for data extraction, transformation, and loading.
3. Implement Bronze, Silver, and Gold data layers.
4. Apply data cleansing, standardization, and validation techniques.
5. Build a dimensional data model using facts, dimensions, and a star schema.
6. Create reusable SQL scripts, views, and stored procedures where appropriate.
7. Develop analytical queries and prepare datasets for BI reporting.
8. Use Git and GitHub for version control and project documentation.

## ⚙️ Technical Specifications

### Functional requirements

- Load raw CRM and ERP datasets into the warehouse.
- Preserve source data in the Bronze layer.
- Clean and standardize data in the Silver layer.
- Expose business-ready analytical datasets in the Gold layer.
- Integrate customer, product, and sales information.
- Support aggregations, joins, filtering, and business KPI calculations.
- Document the warehouse schema and data lineage.

### Non-functional requirements

- **Data integrity:** Maintain consistency and enforce appropriate constraints.
- **Maintainability:** Organize SQL scripts into clear, modular components.
- **Reproducibility:** Provide documented setup and execution instructions.
- **Traceability:** Record relevant load metadata and data sources where appropriate.
- **Performance:** Use appropriate data types, indexes, and query optimization techniques when needed.

## 🏛️ Architecture

The project follows the **Medallion Architecture**, with three logical layers.

### 🥉 Bronze — Raw Data

The ingestion layer.

- Store source data with minimal transformations.
- Preserve source structure and traceability.
- Create tables and SQL scripts for loading source files.
- Record relevant ingestion metadata.

### 🥈 Silver — Cleaned Data

The data quality and standardization layer.

- Handle missing and invalid values.
- Remove unwanted spaces and standardize formats.
- Identify and manage duplicate records.
- Apply data type conversions and business validation rules.
- Integrate related source data when appropriate.

### 🥇 Gold — Business-Ready Data

The analytical consumption layer.

- Create customer and product dimensions.
- Create a sales fact model.
- Implement a star schema.
- Expose business-ready datasets through SQL views where appropriate.
- Support analytical queries and BI reporting.

Views will be used where virtual, reusable transformations are suitable. Materialized results or tables may be considered when performance or workload requirements justify them.

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| PostgreSQL | Relational database and SQL processing |
| SQL | Data loading, cleansing, transformation, and analytics |
| PL/pgSQL | Stored procedures and procedural database logic, where needed |
| Git & GitHub | Version control and project collaboration |
| VS Code | SQL development and project organization |
| DBeaver Community | Database connection and visual query execution |
| Draw.io | Architecture and data-flow diagrams |
| Power BI / alternative BI tool | Potential dashboarding and reporting layer |

## 📊 BI & Reporting

The Gold layer is intended to support business intelligence and analytical reporting.

Potential analytical questions include:

- What is the total revenue over a given period?
- Which products generate the most revenue?
- Who are the highest-value customers?
- How do sales evolve over time?
- Which product categories perform best?
- What patterns can be identified across customer locations?

Potential KPIs:

- Total sales revenue
- Number of orders or sales transactions
- Average order value, if the source data supports it
- Revenue by product and category
- Revenue by customer
- Sales trends over time

A BI dashboard may be added once the analytical data model is implemented and validated.

## 📁 Project Structure

The repository is organized around the main development stages.

```text
postgres-data-warehouse/
├── datasets/
│   ├── source_crm/
│   └── source_erp/
├── docs/
│   ├── architecture/
│   ├── data_catalog.md
│   └── data_flow.md
├── scripts/
│   ├── bronze/
│   ├── silver/
│   └── gold/
├── tests/
├── README.md
└── LICENSE
```

*The structure may evolve as implementation progresses. Empty folders and planned files may not yet contain implemented functionality.*

## 🚀 Getting Started

### Prerequisites

- PostgreSQL installed and running
- Git
- VS Code or another SQL editor
- DBeaver Community Edition or an equivalent database client

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/ZnitaMohamed4/postgres-data-warehouse.git
   cd postgres-data-warehouse
   ```

2. Create a PostgreSQL database for the project.

3. Configure your database connection using your local PostgreSQL credentials.

4. Follow the SQL scripts and setup instructions as they become available in the repository.

> Detailed installation, database initialization, and pipeline execution instructions will be added as the project develops.

## 🗺️ Project Roadmap

- [ ] Initialize the repository and establish naming conventions.
- [ ] Analyze the source CRM and ERP datasets.
- [ ] Design the data architecture and document data flows.
- [ ] Create the database and Bronze, Silver, and Gold schemas.
- [ ] Implement Bronze tables and raw-data loading scripts.
- [ ] Develop Silver transformations and data quality checks.
- [ ] Create reusable loading procedures where appropriate.
- [ ] Design customer and product dimensions.
- [ ] Build the sales fact model and star schema.
- [ ] Develop Gold views and analytical SQL queries.
- [ ] Document the data catalog and lineage.
- [ ] Add BI reporting and validate business KPIs.
- [ ] Improve the project with automated testing and further data engineering tools.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 👨‍💻 About Me

I'm **Mohamed Znita**, a Master's graduate in Artificial Intelligence and Data Science, interested in building reliable data systems and developing practical Data Engineering skills.

This project is part of my journey toward mastering SQL, data warehousing, ETL pipelines, dimensional modeling, and business intelligence.

**Connect with me:**

- GitHub: [@ZnitaMohamed4](https://github.com/ZnitaMohamed4)

---

*Built with PostgreSQL, SQL, and a commitment to learning by building.*
