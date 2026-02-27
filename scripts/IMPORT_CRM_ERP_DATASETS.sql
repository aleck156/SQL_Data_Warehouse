CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME
	DECLARE @end_time	DATETIME

	DECLARE @start_full_time	DATETIME
	DECLARE @end_full_time		DATETIME

	BEGIN TRY
		SET @start_full_time = GETDATE()
		PRINT '------------------------------------------------------------------------'
		PRINT '| Loading Bronze Layer data sets from CRM and ERP systems via csv files'
		PRINT '------------------------------------------------------------------------'

		PRINT '| 1/2 Loading CRM tables'	

		SET @start_time = GETDATE();
		PRINT '------------------------------------------------------------------------'
		PRINT '>> Truncating Table: bronze.crm_cust_info'	
		-- Truncate bronze.crm_cust_info before importing any data
		TRUNCATE TABLE bronze.crm_cust_info

		-- BULK IMPORT operation for CRM system and cust_info.csv
		PRINT '>> Inserting Data into Table: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE();
		PRINT '------------------------------------------------------------------------'
		PRINT '>> Truncating Table: bronze.crm_prd_info'
		-- Truncate bronze.crm_prd_info before importing any data
		TRUNCATE TABLE bronze.crm_prd_info

		-- BULK IMPORT operation for CRM system and prd_info.csv
	
		PRINT '>> Inserting Data into Table: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE();
		PRINT '------------------------------------------------------------------------'
		PRINT '>> Truncating Table: bronze.crm_sales_details'
		-- Truncate bronze.crm_sales_details before importing any data
		TRUNCATE TABLE bronze.crm_sales_details

		-- BULK IMPORT operation for CRM system and sales_details.csv	
		PRINT '>> Inserting Data into Table: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
	
		PRINT '------------------------------------------------------------------------'
		PRINT '| 2/2 Loading ERP tables'	

		SET @start_time = GETDATE();
		PRINT '------------------------------------------------------------------------'
		PRINT '>> Truncating Table: bronze.erp_CUST_AZ12'
		-- Truncate bronze.erp_CUST_AZ12 before importing any data
		TRUNCATE TABLE bronze.erp_CUST_AZ12

		-- BULK IMPORT operation for ERP system and sales_details.csv	
		PRINT '>> Inserting Data into Table: bronze.erp_CUST_AZ12'
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE();
		PRINT '------------------------------------------------------------------------'
		PRINT '>> Truncating Table: bronze.erp_LOC_A101'
		-- Truncate bronze.erp_LOC_A101 before importing any data
		TRUNCATE TABLE bronze.erp_LOC_A101

		-- BULK IMPORT operation for ERP system and LOC_A101.csv
		PRINT '>> Inserting Data into Table: bronze.erp_LOC_A101'
		BULK INSERT bronze.erp_LOC_A101
		FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @start_time = GETDATE();
		PRINT '------------------------------------------------------------------------'
		PRINT '>> Truncating Table: bronze.erp_PX_CAT_G1V2'
		-- Truncate bronze.erp_PX_CAT_G1V2 before importing any data
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2

		-- BULK IMPORT operation for ERP system and PX_CAT_G1V2.csv
		PRINT '>> Inserting Data into Table: bronze.erp_PX_CAT_G1V2'
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'Y:\[SQL]\[SQL_DATA_WAREHOUSE]\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		
		SET @end_full_time = GETDATE()
		PRINT '------------------------------------------------------------------------'
		PRINT '>> Bronze Layer Loading Duration: ' + CAST(DATEDIFF(second, @start_full_time, @end_full_time) AS NVARCHAR) + ' seconds'
		PRINT '------------------------------------------------------------------------'
		END TRY
	BEGIN CATCH
		PRINT '------------------------------------------------------------------------'
		PRINT '| Error occured during loading bronze layer'
		PRINT '| Error Message: ' + ERROR_MESSAGE()
		PRINT '| Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT '| Error State: ' + CAST(ERROR_STATE() AS NVARCHAR)
		PRINT '------------------------------------------------------------------------'
	END CATCH
END
