-- #####################################################################
-- Checking gold.dim_customers
-- #####################################################################
-- Check for uniqueness of Customer Key in gold.dim_customers
-- Expected result: No rows
SELECT
    customer_key
    , COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1




