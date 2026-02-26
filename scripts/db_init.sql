/*
Create Database and Schemas

Script Purpose:
	Create a new database named 'DataWarehouse' after checking if it already exists.
	If the database exists, it is dropped and recreated.
	The script sets up three schemas within the database:
		- 'bronze'
		- 'silver'
		- 'gold'

WARNING:
	Running this script will drop the DataWarehouse database if it exists.
	All data in the database will be permamently deleted.
	Proceed with caution and ensure you have proper backups before running this script.
*/

USE master;

-- Drop and recreate the DataWarehouse DB

IF EXISTS(SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END;
GO

-- Create the 'DataWarehouse' DB
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
