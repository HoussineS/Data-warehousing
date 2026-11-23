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


CREATE OR ALTER PROCEDURE branze.load_branze
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @CurrentStep NVARCHAR(100) ,@start_time datetime,@end_time datetime,@LoadStartTime datetime;

    BEGIN TRY

        PRINT '======================================';
        PRINT 'STARTING BRONZE LAYER FULL LOAD';
        PRINT '======================================';


        -- STEP 1
        SET @CurrentStep = 'crm_cust_info';

        PRINT 'STEP 1: Loading crm_cust_info...';
        set @LoadStartTime = getdate();
        set @start_time = GETDATE();
        TRUNCATE TABLE branze.crm_cust_info;

        BULK INSERT branze.crm_cust_info
        FROM 'C:\Users\Lenovo\Documents\data warehousing\data source\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = GETDATE();
        PRINT 'STEP 1 COMPLETED SUCCESSFULLY.';
        PRINT 'STEP 1 excecution time: '+ cast(datediff(second,@start_time ,@end_time) as NVARCHAR)+ 'seconds';


        -- STEP 2
        SET @CurrentStep = 'crm_prd_info';
        set @start_time = getdate();
        PRINT 'STEP 2: Loading crm_prd_info...';

        TRUNCATE TABLE branze.crm_prd_info;

        BULK INSERT branze.crm_prd_info
        FROM 'C:\Users\Lenovo\Documents\data warehousing\data source\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = getdate();
        PRINT 'STEP 2 COMPLETED SUCCESSFULLY.';
        PRINT 'STEP 2 excecution time: '+ cast(datediff(second,@start_time ,@end_time) as NVARCHAR)+ 'seconds';

        -- STEP 3
        SET @CurrentStep = 'crm_sales_details';
        set @start_time = getdate();
        PRINT 'STEP 3: Loading crm_sales_details...';

        TRUNCATE TABLE branze.crm_sales_details;

        BULK INSERT branze.crm_sales_details
        FROM 'C:\Users\Lenovo\Documents\data warehousing\data source\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = getdate();
        PRINT 'STEP 3 COMPLETED SUCCESSFULLY.';
        PRINT 'STEP 3 excecution time: '+ cast(datediff(second,@start_time ,@end_time) as NVARCHAR)+ 'seconds';

        -- STEP 4
        SET @CurrentStep = 'erp_cust_az12';

        PRINT 'STEP 4: Loading erp_cust_az12...';
        set @start_time = getdate();
        TRUNCATE TABLE branze.erp_cust_az12;

        BULK INSERT branze.erp_cust_az12
        FROM 'C:\Users\Lenovo\Documents\data warehousing\data source\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = getdate();
        PRINT 'STEP 4 COMPLETED SUCCESSFULLY.';
        PRINT 'STEP 4 excecution time: '+ cast(datediff(second,@start_time ,@end_time) as NVARCHAR)+ 'seconds';


        -- STEP 5
        SET @CurrentStep = 'erp_loc_a101';

        PRINT 'STEP 5: Loading erp_loc_a101...';
        set @start_time = getdate();
        TRUNCATE TABLE branze.erp_loc_a101;

        BULK INSERT branze.erp_loc_a101
        FROM 'C:\Users\Lenovo\Documents\data warehousing\data source\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = getdate();
        PRINT 'STEP 5 COMPLETED SUCCESSFULLY.';
        PRINT 'STEP 5 excecution time: '+ cast(datediff(second,@start_time ,@end_time) as NVARCHAR)+ 'seconds';

        -- STEP 6
        SET @CurrentStep = 'erp_px_cat_g1v2';

        PRINT 'STEP 6: Loading erp_px_cat_g1v2...';
        set @start_time = getdate();
        TRUNCATE TABLE branze.erp_px_cat_g1v2;

        BULK INSERT branze.erp_px_cat_g1v2
        FROM 'C:\Users\Lenovo\Documents\data warehousing\data source\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        set @end_time = getdate();
        PRINT 'STEP 6 COMPLETED SUCCESSFULLY.';
        PRINT 'STEP 6 excecution time: '+ cast(datediff(second,@start_time ,@end_time) as NVARCHAR)+ 'seconds';

        PRINT '======================================';
        PRINT 'BRONZE LAYER LOAD COMPLETED SUCCESSFULLY';
        PRINT '======================================';
        PRINT 'TOTAL EXECUTION TIME: ' +
      CAST(DATEDIFF(SECOND, @LoadStartTime, @end_time) AS NVARCHAR(20))
      + ' seconds';

    END TRY

    BEGIN CATCH

        PRINT '======================================';
        PRINT 'ERROR DURING BRONZE LAYER LOAD!';
        PRINT '======================================';

        PRINT 'Failed Table: ' + @CurrentStep;
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR(10));

        THROW;

    END CATCH

END;
GO ;

