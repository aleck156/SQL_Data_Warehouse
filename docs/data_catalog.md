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
| subcategory | NVARCHAR(50) | A more detailed classification of the productwithin the category, such as product type. |
| maintenance | NVARCHAR(50) | Indicates whether the product requires regular maintenance. Allowed values: 'Yes', 'No'. |
| cost | INT | The cost or base price of the product. Measured in monetary unit. |
| product_line | NVARCHAR(50) | The specific product line or series to which the product belongs. |
| start_date | DATE | The date when the product became available for sale or use. |

---

```gold.fact_sales```
 - Purpose
   - Stores transactional sales data for analytical purposes.
 - Columns

|  Column Name  |  Data Type  |  Description  |
| --- | --- | --- |
| order_number | NVARCHAR(50) | desc1 |
| product_key | BIGINT | desc1 |
| customer_key | NVARCHAR(50) | desc1 |
| order_date | NVARCHAR(50) | desc1 |
| shipping_date | NVARCHAR(50) | desc1 |
| due_date | NVARCHAR(50) | desc1 |
| sales_amount | NVARCHAR(50) | desc1 |
| sales_quantity | NVARCHAR(50) | desc1 |
| price | NVARCHAR(50) | desc1 |







