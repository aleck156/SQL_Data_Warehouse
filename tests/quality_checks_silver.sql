-- #####################################################################
-- Checking silver.crm_cust_info
-- #####################################################################
-- Check for NULLs or Duplicates in Primary Key
-- Expected result: No Results
SELECT
  cst_id
  , COUNT(*)
FROM silver.crm_cust_id
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Expected result: No Results
SELECT
  cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardization & Consistency
SELECT DISTINCT
  cst_marital_status
FROM silver.crm_cust_info;

-- #####################################################################
-- Checking 
-- #####################################################################
-- Check for uniqueness of Product Key in gold.dim_products
-- Expected result: No Results

