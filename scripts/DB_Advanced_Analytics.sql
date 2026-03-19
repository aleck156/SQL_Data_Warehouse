USE DataWarehouseAnalytics

-- ###############################################
-- Change-Over-Time
-- ###############################################
-- Aggregate [Measure] By [Date Dimension]
-- How a measure evolves over time
-- Track trends, identify seasonality
-- total sales by year, average cost by month, 

-- Analyze Sales Performance over Time
SELECT
	YEAR(order_date) AS order_year
	, SUM(YEAR(sales_amount)) AS total_sales
	, COUNT(DISTINCT customer_key) AS customers
	, SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

SELECT
	MONTH(order_date) AS order_year
	, SUM(sales_amount) AS total_sales
	, COUNT(DISTINCT customer_key) AS customers
	, SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)

-- Find the data with monthly granularity
SELECT
	DATETRUNC(MONTH, order_date) AS order_year
	, SUM(sales_amount) AS total_sales
	, COUNT(DISTINCT customer_key) AS customers
	, SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY DATETRUNC(MONTH, order_date)


SELECT
	YEAR(order_date) AS order_year
	, MONTH(order_date) AS order_month
	, SUM(sales_amount) AS total_sales
	, COUNT(DISTINCT customer_key) AS customers
	, SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
	YEAR(order_date)
	, MONTH(order_date)
ORDER BY 
	YEAR(order_date) 
	, MONTH(order_date) 

-- ###############################################
-- Cumulative Analysis
-- ###############################################
-- Aggregate [Cumulative Measure] by [Date Dimension]

-- Calculate the total sales per month and the running total of sales over time

SELECT
	t.order_date
	, t.total_sales
	, SUM(t.total_sales) OVER (PARTITION BY t.order_date ORDER BY t.order_date ROWS UNBOUNDED PRECEDING) AS running_sales
	, AVG(t.avg_price) OVER (PARTITION BY t.order_date ORDER BY t.order_date ROWS UNBOUNDED PRECEDING) AS running_avg_price
FROM (
	SELECT
		DATETRUNC(MONTH, order_date) AS order_date
		, SUM(sales_amount) AS total_sales
		, AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH, order_date)
) AS t
ORDER BY t.order_date

-- ###############################################
-- Performance Analysis
-- ###############################################
-- Current [Measure] - Target [Measure]
-- Compare current value to a target value

-- Analyze the yearly perfomance of products by comparing each product's sales to both its average
-- sales performance and the previous year's sales
WITH yearly_product_sales AS (
	SELECT
		YEAR(s.order_date) AS order_year
		, p.product_name
		, SUM(s.sales_amount) AS current_sales
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
		ON s.product_key = p.product_key
	WHERE YEAR(s.order_date) IS NOT NULL
	GROUP BY 
		YEAR(s.order_date)
		, p.product_name
)
SELECT
	order_year
	, product_name
	, current_sales
	, AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales
	, current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_to_avg
	, CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
			WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
			ELSE 'Equilibrium'
	END AS avg_change
	-- Year-over-Year Analysis
	, LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_year_sales
	, current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_previous_year
	, CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
			WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
			ELSE 'No Change'
	END AS py_change
FROM yearly_product_sales
ORDER BY 
	product_name
	, order_year


-- ###############################################
-- Part-To-Whole
-- ###############################################
-- Analyze how an individual part is performing compared to the overall.
-- Allows us to understand which category has the greatest impact on the business
-- ([Measure] / Total [Measure]) * 100 By [Dimension]

-- Which categories contribute the most to overall sales?
WITH category_sales AS
(
	SELECT
		p.category
		, SUM(s.sales_amount) AS total_sales
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
		ON s.product_key = p.product_key
	GROUP BY p.category
)
SELECT
	category
	, total_sales
	, SUM(total_sales) OVER () overall_sales
	, ROUND(CAST(total_sales AS FLOAT) / ( SUM(total_sales) OVER ()) * 100, 2) AS partial_sales
FROM category_sales
ORDER BY partial_sales DESC

-- ###############################################
-- Data Segmentation
-- ###############################################
-- Group data based on specific range
-- Helps understand the correlation between two measures.
-- [Measure] by [Measure]

-- Segment products into cost ranges and count how may products fall into each segment
WITH product_segments AS
(
	SELECT
		product_key
		, product_name
		, cost
		, CASE WHEN cost < 100 THEN 'Below 100'
			WHEN cost BETWEEN 100 AND 500 THEN '100-500'
			WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
			ELSE 'Above 1000'
		END AS price_segment
	FROM gold.dim_products
)
SELECT
	price_segment
	, COUNT(*) AS segment_elements
FROM product_segments
GROUP BY price_segment
ORDER BY segment_elements DESC;

-- Group customers into three segments based on their spending behavior
-- Count number of customers for each segment

WITH customer_spending AS
(
	SELECT
		dc.customer_key
		, COUNT(dc.customer_key) AS no_of_orders
		, SUM(fs.sales_amount) AS total_spending
		, MIN(fs.order_date) AS first_order
		, MAX(fs.order_date) AS last_order
		, DATEDIFF(month, MIN(fs.order_date), MAX(fs.order_date)) AS customer_lifespan
	FROM gold.fact_sales fs
	LEFT JOIN gold.dim_customers dc
		ON fs.customer_key = dc.customer_key
	GROUP BY dc.customer_key
	--ORDER BY customer_lifespan DESC
)
SELECT 
	customer_segments
	, COUNT(customer_key) AS total_customers
FROM
(
	SELECT
		customer_key
		,CASE
			WHEN total_spending > 5000 AND customer_lifespan >= 12 THEN 'VIP'
			WHEN total_spending <= 5000 AND customer_lifespan >= 12 THEN 'Regular'
			ELSE 'New'
		END AS customer_segments
	FROM customer_spending
) AS t
GROUP BY customer_segments
ORDER BY total_customers DESC
