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
| customer_key | INT | Surrogate key that uniquely identifies each customer records in the dimension table. |
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


---

```gold.fact_sales```



