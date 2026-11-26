-- analyse crm_pro_info
-- we need to make a cat_id that a sub string of prd_key that represent the category id
-- and in the table erp_px_cat_g1v2  we have ab_xx and in the substring we got yy-xx so we use it replace to change it
-- we got about 36 categorie from the join bettween when we have a 37 categories in erp_px_cat_g1v2 so it mean there
-- is a category don't have any product THIS CATEGORIE CO_PD
-- we have error when we create tha table for the silver with 5 char in prd_line 

  alter table silver.crm_prd_info
  alter column prd_line nvarchar(20);



select distinct cat.id from
(SELECT  [prd_id]
      ,[prd_key],
      replace(substring(prd_key,1,5),'-','_') as cat_id
      ,[prd_nm]
      ,[prd_cost]
      ,[prd_line]
      ,[prd_start_dt]
      ,[prd_end_dt]
  FROM [DataWarehouse].[branze].[crm_prd_info] ) as t right join branze.erp_px_cat_g1v2 cat on t.cat_id = cat.id
  where T.CAT_id is null;
  ;



  SELECT  [prd_id]
      ,[prd_key],
      replace(substring(prd_key,1,5),'-','_') as cat_id,
      substring(prd_key,7 ,len(prd_key)) as prd_key
      ,[prd_nm]
      ,[prd_cost]
      ,[prd_line]
      ,[prd_start_dt]
      ,[prd_end_dt]
  FROM [DataWarehouse].[branze].[crm_prd_info]


  -- check negative numbers or null
  -- we have only two prd_cost with null and nor negative value so we need to replcae it with 0 in loading to silver

  select * from branze.crm_prd_info where prd_cost is null or  prd_cost<0 ;

-- check the prd_line
-- NULL
-- M 
-- R 
-- S 
-- T 
  select distinct prd_line from branze.crm_prd_info;



  
  
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM DataWarehouse.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'silver'
  AND TABLE_NAME = 'crm_prd_info'
  AND COLUMN_NAME IN ('prd_line', 'cst_martial_status');




