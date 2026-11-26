-- the full load clean code 
-- see the analytical file to see how we get this

 SELECT  [prd_id]
      ,[prd_key],
      replace(substring(prd_key,1,5),'-','_') as cat_id,
      substring(prd_key,7 ,len(prd_key)) as prd_key
      ,[prd_nm]
      ,isnull(prd_cost,0) as prd_cost,
      case upper(trim(prd_line))
            when 'R' then 'Road'
            when 'M' then 'Mountain'
            when 'S' then 'Other sales'
            else 'n/a' 
       end as prd_line
      ,[prd_start_dt]
      ,[prd_end_dt]
  FROM [DataWarehouse].[branze].[crm_prd_info]





