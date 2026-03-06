-- make a section for each table in gold layer

## Data Dictinary for GOLD Layer

### Overview

---

The GOLD layer is the business-level data representation, structured to support analytical and reporting use-cases.

It is built on:
 - Dimension Tables
 - Fact Tables

---

```gold.dim_customers```
 - Purpose
   - Store customer details
   - Enrich with demographic and geographic data
 - Columns

|  Column Name  |  Data Type  |  Description  |
| --- | --- | --- |
| customer_key | INT | Surrogate key that uniquely identifies each customer record in the dimension table. |
| customer_id | INT | Unique numerical identifier assigned to each customer. |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name | NVARCHAR(50) | The customer's first name. |
| last_name | NVARCHAR(50) | The customer's last name or family name. | 
| country | NVARCHAR(50) | Country of residence for the customer. Example: 'United States' |
| marital_status | NVARCHAR(50) | Marital status of the customer. Allowed values: 'Married', 'Single'. |
| gender | NVARCHAR(50) | The gender of the customer. Allowed values: 'Male', 'Female', 'n/a'. |
| birthdate | DATE | Date of birth of the customer. Formatted as YYYY-MM-DD, 1971-07-29 |
| create_date | DATE | The date and time when the customer record was created in the system. |

---

```gold.dim_products```
 - Purpose
   - Provides information about products and their attributes.
 - Columns

|  Column Name  |  Data Type  |  Description  |
| --- | --- | --- |
| product_key | INT | Surrogate key that uniquely identifies each product record in the dimension table. |
| product_id | INT | Unique numerical identifier assigned to each product for internal tracking and referencing. |
| product_number | NVARCHAR(50) | A structured alphanumeric code representing the product, used for categorization or inventory.  |
| product_name | NVARCHAR(50) | Descriptive name of the product, including key details such as color, type and size. |
| category_id | NVARCHAR(50) | A unique identifier for the product's category, linking to its high-level classification.  |
| category | NVARCHAR(50) | The broader classification of the product (e.g. Bike, Components, et c.) to group related items. |
| subcategory | NVARCHAR(50) | desc_1 |
| maintenance | NVARCHAR(50) | desc_1 |
| cost | INT | desc_1 |
| product_line | NVARCHAR(50) | desc_1 |
| start_date | DATE | desc_1 |

---

```gold.fact_sales```
 - Purpose
   - 
 - Columns



