/*
-- ####################################################
-- Customer Report
-- ####################################################
Purpose:
	- This report consolidates key customer metrics and behaviors.

Highlights:
	1) Gather essential fields such as names, ages, and transaction details.
	2) Segment customers into:
		- Categories - VIP, Regular, New
		- Age Groups
	3) Aggregate customer-level metrics:
		- Total orders
		- Total sales
		- Total Quantity purchased
		- Total Products
		- Lifespan (in months)
	4) Calculate valuable KPIs:
		- Recency (months since last order)
		- Average order value
		- Average monthly spending
-- ####################################################
*/
USE [DataWarehouseAnalytics];
GO

IF EXISTS (
	SELECT * FROM sys.views
	WHERE name = 'report_customers'
		AND type='v'
)
	DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS
WITH base_customer_data AS
(
	-- ####################################################
	-- 1) Base query: Retrieve core columns from tables
	-- ####################################################
	SELECT
		fs.order_number
		, fs.product_key
		, fs.order_date
		, fs.sales_amount
		, fs.quantity
		, dc.customer_key
		, dc.customer_number
		, CONCAT(dc.first_name, ' ', dc.last_name) AS customer_name
		, DATEDIFF(YEAR, dc.birthdate, GETDATE()) AS customer_age
	FROM gold.fact_sales fs
	LEFT JOIN gold.dim_customers dc
		ON fs.customer_key = dc.customer_key
	WHERE fs.order_date IS NOT NULL
)
, customer_aggregation AS
(
	-- ####################################################
	-- 2) Base query: Summarize key metrics at the customer level
	-- ####################################################
	SELECT
		customer_key
		, customer_number
		, customer_name
		, customer_age
		, COUNT(DISTINCT order_number) AS total_orders
		, SUM(sales_amount) AS total_sales
		, SUM(quantity) AS total_quantity
		, SUM(DISTINCT product_key) AS total_products
		, MAX(order_date) AS last_order_date
		, DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS customer_lifespan
	FROM base_customer_data
	GROUP BY customer_key
		, customer_number
		, customer_name
		, customer_age
	--ORDER BY customer_number
)
SELECT
	customer_key
	, customer_number
	, customer_name
	, customer_age
	, CASE
		WHEN customer_age < 20 THEN 'Under 20'
		WHEN customer_age BETWEEN 20 AND 29 THEN 'Between 20 and 29'		
		WHEN customer_age BETWEEN 30 AND 39 THEN 'Between 30 and 39'
		WHEN customer_age BETWEEN 40 AND 49 THEN 'Between 40 and 49'
		ELSE '50 and above'
	END AS age_group
	, CASE 
		WHEN customer_lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
		WHEN customer_lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment
	, total_orders
	, total_sales
	, total_quantity
	, total_products
	, last_order_date
	, customer_lifespan
	, DATEDIFF(month, last_order_date, GETDATE()) AS KPI_recency
	, CASE
		WHEN total_orders IS NULL OR total_orders = 0 THEN -1
		ELSE total_sales / total_orders
	END AS KPI_avg_order_value		
	, CASE
		WHEN customer_lifespan IS NULL OR customer_lifespan = 0 THEN total_sales
		ELSE total_sales / customer_lifespan
	END AS KPI_avg_monthly_spend	
FROM customer_aggregation



