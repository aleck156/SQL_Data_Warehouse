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

---

|  Column Name  |  Data Type  |  Description  |
| --- | --- | --- |
| customer_key | INT | Surrogate key that uniquely identifies each customer records in the dimension table. |
| customer_id | INT | Unique numerical identifier assigned to each customer. |
| customer_number | NVARCHAR(50) | desc 2 |
| first_name | NVARCHAR(50) | desc 2 |
| last_name | NVARCHAR(50) | desc 2 |
| country | NVARCHAR(50) | desc 2 |
| marital_status | NVARCHAR(50) | desc 2 |
| gender | NVARCHAR(50) | desc 2 |
| birthdate | DATE | desc 2 |
| create_date | DATE | desc 2 |




