
/*
Create the tables from the csv for the first layer silver
***Format***
silver.sourse_table_name
and crate with 
we have add a dw_create_date column to esay detecte change

*/
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_cust_info
GO

CREATE TABLE silver.crm_cust_info(
	cst_id int,
	cst_key varchar(50),
	cst_firstname varchar(50),
	cst_lastname varchar(50),
	cst_martial_status varchar(50),
	cst_gndr char,
	cst_create_date date,
	dw_create_date datetime default getdate(),

);
GO

IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info
GO
CREATE TABLE silver.crm_prd_info(
	prd_id int,
	cat_id varchar(50),
	prd_key varchar(50),
	prd_nm varchar(50),
	prd_cost float,
	prd_line varchar(20),
	prd_start_dt date,
	prd_end_dt date,
	dw_create_date datetime default getdate(),
);
GO

IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE silver.crm_sales_details
GO
CREATE TABLE silver.crm_sales_details(
	sls_ord_num varchar(50),
	sls_prd_key varchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_due_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int,
	dw_create_date datetime default getdate(),
);
GO

------------ERP---------------

IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE silver.erp_cust_az12
GO
CREATE TABLE silver.erp_cust_az12(
	CID varchar(50),
	BDATE date,
	GEN varchar(10),
	dw_create_date datetime default getdate(),
);
GO

IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE silver.erp_loc_a101
GO
CREATE TABLE silver.erp_loc_a101(
	CID varchar(50),
	CNTRY varchar(50),
	dw_create_date datetime default getdate(),
);
GO

IF OBJECT_ID('silver.px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE silver.px_cat_g1v2
GO
CREATE TABLE silver.erp_px_cat_g1v2(
	ID varchar(20),
	CAT varchar(25),
	SUBCAT varchar(30),
	MAINTENANCE varchar(10) check (MAINTENANCE in ('Yes','No')) default null,
	dw_create_date datetime default getdate(),
);
GO