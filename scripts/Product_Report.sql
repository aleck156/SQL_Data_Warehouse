/*
-- ####################################################
-- Product Report
-- ####################################################
Purpose:
	- This report consolidates key product metrics and behaviors.

Highlights:
	1) Gather essential fields such as product name, category, subcategory and cost.
	2) Segment products by revenue to identify
		- High-Performers
		- Mid-Range
		- Low-Performers
	3) Aggregate product-level metrics:
		- Total orders
		- Total sales
		- Total quantity sold
		- Total customers (unique)
		- Lifespan (in months)
	4) Calculate valuable KPIs:
		- Recency (months since last order)
		- Average order value
		- Average monthly revenue
Usage:
	1) Execute the script to create new View gold.report_customers
	2) Use the following query to retrieve information
		SELECT * FROM gold.report_products 
-- ####################################################
*/
USE [DataWarehouseAnalytics];
GO

-- ####################################################
-- Create Report: gold.report_products
-- ####################################################

IF EXISTS
(
	SELECT 1 FROM sys.views
	WHERE name LIKE 'report_products'
		AND type = 'V'
)
	DROP VIEW gold.report_products;
GO


CREATE VIEW gold.report_products AS
WITH base_product_data AS
(
	-- ####################################################
	-- 1) Base query: Retrieve base columns from fact_sales and dim_products
	-- ####################################################
	SELECT
		fs.order_number
		, fs.order_date
		, fs.customer_key
		, fs.sales_amount
		, fs.quantity
		, dp.product_key
		, dp.product_name
		, dp.category
		, dp.subcategory
		, dp.cost
	FROM gold.fact_sales fs
	LEFT JOIN gold.dim_products dp
		ON fs.product_key = dp.product_key
	WHERE order_date IS NOT NULL -- limit results to valid sales dates only
),

product_aggregation AS
(
	-- ####################################################
	-- 2) Base query: Summarize key metrics at the product level
	-- ####################################################
	SELECT
		product_key
		, product_name
		, category
		, subcategory
		, cost
		, DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
		, MAX(order_date) AS last_sale_date
		, COUNT(DISTINCT order_number) AS total_orders
		, COUNT(DISTINCT customer_key) AS total_customers
		, SUM(sales_amount) AS total_sales
		, SUM(quantity) AS total_quantity
		, ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
	FROM base_product_data
	GROUP BY 
		product_key
		, product_name
		, category
		, subcategory
		, cost
)
-- ####################################################
-- 3) Main query: Combine all product results into one output
-- ####################################################
SELECT
	product_key
	, product_name
	, category
	, subcategory
	, cost
	, last_sale_date
	, DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months
	, CASE
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment
	, lifespan
	, total_orders
	, total_sales
	, total_quantity
	, total_customers
	, avg_selling_price

	, CASE -- Average Order Revenue (AOR)
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue

	, CASE -- Average Monthly Revenue (AMR)
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregation
