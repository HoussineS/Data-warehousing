/*
Here we going to do a full load for the data from the csv file to Tables for the bronze layer

***The architecture we use it is Bulk load with is do a full load for the data set not row by row wich is fatser******

*************But before we need to Truncate the tables to be empty*******

***Warring may you need to give access to the fiel to be read it from the use for that run this query:
SELECT 
    servicename,
    service_account
FROM sys.dm_server_services;

copy the service_account for the first row
1/Navigate to your folder:that contain data source
2/Right-click the folder → Properties
3/Open Security → Edit → Add
4/Enter the SQL Server service account you found in Step 1.
5/Click Check Names
6/Give it Read and Read & execute permissions.
7/Apply.

*/

create or alter procedure branze.load_branze as
BEGIN
		--Table 1**********

		Truncate Table branze.crm_cust_info ;

		Bulk insert branze.crm_cust_info 
		from 'C:\Users\Lenovo\Documents\data warehousing\data source\source_crm\cust_info.csv'
		with(
			firstrow=2,--because the first row is columns name
			fieldterminator = ',' ,
			tablock -- load all file
		)

		--Table 2**********

		Truncate Table branze.crm_cust_info ;

		Bulk insert branze.crm_prd_info 
		from 'C:\Users\Lenovo\Documents\data warehousing\data source\source_crm\prd_info.csv'
		with(
			firstrow=2,--because the first row is columns name
			fieldterminator = ',' ,
			tablock -- load all file
		)

		--Table 3**********

		Truncate table branze.crm_sales_details;

		Bulk insert branze.crm_sales_details
		from 'C:\Users\Lenovo\Documents\data warehousing\data source\source_crm\sales_details.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		)

		-- Table 4 ********
		Truncate table [branze].[erp_cust_az12];

		Bulk insert [branze].[erp_cust_az12] 
		from 'C:\Users\Lenovo\Documents\data warehousing\data source\source_erp\CUST_AZ12.csv'
		with(
		firstrow = 2,
		fieldterminator = ',',
		tablock
		)

		--Table 5 *************

		Truncate table branze.erp_loc_a101;

		Bulk insert branze.erp_loc_a101
		from 'C:\Users\Lenovo\Documents\data warehousing\data source\source_erp\LOC_A101.csv'
		with(
		firstrow = 2,
		fieldterminator = ',',
		tablock
		)

		--Table 6 *************

		Truncate table [branze].[erp_px_cat_g1v2];

		Bulk insert [branze].[erp_px_cat_g1v2]
		from 'C:\Users\Lenovo\Documents\data warehousing\data source\source_erp\PX_CAT_G1V2.csv'
		with(
		firstrow = 2,
		fieldterminator = ',',
		tablock
		)
end ;