-- Truncate bronze.crm_cust_info before importing any data
TRUNCATE TABLE bronze.crm_cust_info

-- BULK IMPORT operation for CRM system and cust_info.csv
BULK INSERT bronze.crm_cust_info
FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Truncate bronze.crm_prd_info before importing any data
TRUNCATE TABLE bronze.crm_prd_info

-- BULK IMPORT operation for CRM system and prd_info.csv
BULK INSERT bronze.crm_prd_info
FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Truncate bronze.crm_sales_details before importing any data
TRUNCATE TABLE bronze.crm_sales_details

-- BULK IMPORT operation for CRM system and sales_details.csv
BULK INSERT bronze.crm_sales_details
FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Truncate bronze.erp_CUST_AZ12 before importing any data
TRUNCATE TABLE bronze.erp_CUST_AZ12

-- BULK IMPORT operation for ERP system and sales_details.csv
BULK INSERT bronze.erp_CUST_AZ12
FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Truncate bronze.erp_LOC_A101 before importing any data
TRUNCATE TABLE bronze.erp_LOC_A101

-- BULK IMPORT operation for ERP system and LOC_A101.csv
BULK INSERT bronze.erp_LOC_A101
FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Truncate bronze.erp_PX_CAT_G1V2 before importing any data
TRUNCATE TABLE bronze.erp_PX_CAT_G1V2

-- BULK IMPORT operation for ERP system and PX_CAT_G1V2.csv
BULK INSERT bronze.erp_PX_CAT_G1V2
FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
