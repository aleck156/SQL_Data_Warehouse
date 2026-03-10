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
-- Checking silver.crm_prd_info
-- #####################################################################
-- Check for NULLs or Duplicates in Primary Key
-- Expected result: No Results
SELECT
  prd_id
  , COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for Unwanted Spaces
-- Expected result: No Results
SELECT
  prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLs or NEgative Values in cost
-- Expected result: No Results
SELECT
  prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Check for Invalid Date Orders ( Start Date > End Date)
-- Expected result: no Results
SELECT
  *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_date

-- Data Standardization & Consistency
SELECT DISTINCT
  prd_line
FROM silver.crm_prd_info;

