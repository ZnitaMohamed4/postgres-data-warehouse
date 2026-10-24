# Data Catalog: Gold Layer
 
The Gold layer is the business-ready layer of the data warehouse. It is organized as a **star schema**: one fact view surrounded by two dimension views. All objects are SQL views built from the Silver layer.
 
---
 
## 1. `gold.dim_customers`
 
**Purpose:** One row per customer, combining customer data from the CRM and the ERP (profile, gender, birth date, country).
 
**Sources:** `silver.crm_cust_info` (master), `silver.erp_cust_az12`, `silver.erp_loc_a101`. Joined with LEFT JOINs on the customer key.
 
| Column | Data type | Description | Example |
|---|---|---|---|
| `customer_key` | BIGINT | Surrogate key, generated with `ROW_NUMBER()`. Used to join with the fact table. | `1` |
| `customer_id` | INT | Customer ID from the CRM. | `11000` |
| `customer_number` | VARCHAR | Business customer code, used to link CRM and ERP data. | `AW00011000` |
| `first_name` | VARCHAR | Customer first name, trimmed. | `Jon` |
| `last_name` | VARCHAR | Customer last name, trimmed. | `Yang` |
| `country` | VARCHAR | Country of residence (from the ERP). `n/a` if unknown. | `Australia`, `Germany`, `United States`, `n/a` |
| `marital_status` | VARCHAR | Marital status. | `Single`, `Married`, `n/a` |
| `gender` | VARCHAR | Gender. The CRM is the master source; if the CRM value is `n/a`, the ERP value is used. | `Male`, `Female`, `n/a` |
| `birthdate` | DATE | Birth date (from the ERP). NULL if missing or invalid (future dates removed). | `1971-10-06` |
| `create_date` | DATE | Date the customer record was created in the CRM. | `2025-10-06` |
 
---
 
## 2. `gold.dim_products`
 
**Purpose:** One row per **current** product, enriched with category information.
 
**Sources:** `silver.crm_prd_info`, `silver.erp_px_cat_g1v2`. Historical rows (those with an end date) are filtered out.
 
| Column | Data type | Description | Example |
|---|---|---|---|
| `product_key` | BIGINT | Surrogate key, generated with `ROW_NUMBER()`. Used to join with the fact table. | `1` |
| `product_id` | INT | Product ID from the CRM. | `210` |
| `product_number` | VARCHAR | Product code, used to link with sales. | `FR-R92B-58` |
| `product_name` | VARCHAR | Product name. | `HL Road Frame - Black- 58` |
| `category_id` | VARCHAR | Category code, linked to the ERP category table. | `CO_RF` |
| `category` | VARCHAR | Product category. | `Accessories`, `Bikes`, `Clothing`, `Components` |
| `subcategory` | VARCHAR | Product subcategory. | `Road Frames`, `Mountain Bikes`, `Helmets` |
| `maintenance` | VARCHAR | Whether the product requires maintenance. | `Yes`, `No` |
| `cost` | INT | Product cost. NULL costs were replaced with 0. | `1898`, `0` |
| `product_line` | VARCHAR | Product line. | `Mountain`, `Road`, `Other Sales`, `Touring`, `n/a` |
| `start_date` | DATE | Date the product became available. | `2003-07-01` |
 
---
 
## 3. `gold.fact_sales`
 
**Purpose:** One row per sales order line. Holds the sales transactions and links to the two dimensions through surrogate keys.
 
**Source:** `silver.crm_sales_details`, joined to `gold.dim_products` and `gold.dim_customers`.
 
| Column | Data type | Description | Example |
|---|---|---|---|
| `order_number` | VARCHAR | Sales order number. | `SO43697` |
| `product_key` | BIGINT | Foreign key to `gold.dim_products.product_key`. | `20` |
| `customer_key` | BIGINT | Foreign key to `gold.dim_customers.customer_key`. | `10769` |
| `order_date` | DATE | Date the order was placed. NULL if the source date was invalid. | `2010-12-29` |
| `shipping_date` | DATE | Date the order was shipped. | `2011-01-05` |
| `due_date` | DATE | Date payment was due. | `2011-01-10` |
| `sales_amount` | INT | Total sales amount for the line (quantity x price). | `3578` |
| `quantity` | INT | Number of units ordered. | `1` |
| `price` | INT | Price per unit. | `3578` |
 
---
 
## Relationships
 
```
gold.dim_customers (customer_key) 1 ----< N gold.fact_sales
gold.dim_products  (product_key)  1 ----< N gold.fact_sales
```
 
## Data quality notes
 
- Duplicate and NULL customer IDs were removed in Silver.
- `n/a` means the value was missing or unrecognized in the source.
- Sales amounts, quantities and prices were corrected in Silver when they were NULL, negative, or inconsistent.
- Quality checks for this layer are in `tests/quality_checks_gold.sql`.
 