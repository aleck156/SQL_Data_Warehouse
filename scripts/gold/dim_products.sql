/*

USAGE
  SELECT * FROM gold.dim_products

*/

CREATE VIEW gold.dim_products AS
	SELECT
		ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key
		, pn.prd_id		  AS product_id
		, pn.prd_key	  AS product_number
		, pn.prd_nm		  AS product_name
		, pn.cat_id		  AS category_id
		, pc.CAT		  AS category
		, pc.SUBCAT		  AS subcategory
		, pc.MAINTENANCE
		, pn.prd_cost	  AS cost
		, pn.prd_line	  AS product_line
		, pn.prd_start_dt AS start_date
	FROM silver.crm_prd_info AS pn
	LEFT JOIN silver.erp_PX_CAT_G1V2 AS pc
		ON pn.cat_id = pc.ID
	-- FILTER, show products only currently in production
	WHERE pn.prd_end_dt IS NULL
