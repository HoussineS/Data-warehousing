-- the full load clean code 
-- see the analytical file to see how we get this
insert into silver.crm_prd_info
(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
 SELECT  
      [prd_id],
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
      ,[prd_start_dt],
      DATEADD(day,-1,LEAD(prd_start_dt,1,null) over(partition by prd_key order by prd_start_dt)) as prd_end_dt
  FROM [DataWarehouse].[branze].[crm_prd_info]





