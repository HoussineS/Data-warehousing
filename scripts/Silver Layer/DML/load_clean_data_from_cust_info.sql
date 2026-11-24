


SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM DataWarehouse.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'silver'
  AND TABLE_NAME = 'crm_cust_info'
  AND COLUMN_NAME IN ('cst_gndr', 'cst_martial_status');

--COLUMN_NAME	DATA_TYPE	CHARACTER_MAXIMUM_LENGTH
--cst_martial_status	varchar	50
--cst_gndr	char	1
-- we got char in cst_gndr so we need to alter
Alter table silver.crm_cust_info
alter column cst_gndr varchar(20)

insert into silver.crm_cust_info
(cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_martial_status,
cst_gndr,
cst_create_date
)
select cst_id,cst_key,
trim(cst_firstname) as  cst_firstname,
trim(cst_lastname)as cst_lastname,
case when upper(trim(cst_martial_status))  = 'S' then 'Single'
	 when upper(trim(cst_martial_status)) = 'M' then 'Married'
	 else 'n/a'
end cst_martial_status ,

case when upper(trim(cst_gndr))  = 'F' then 'Female'
	 when upper(trim(cst_gndr)) = 'M' then 'Male'
	 else 'n/a'
end cst_gndr ,
cst_create_date

from (
select  *, 
row_number() over(partition by cst_id order by cst_create_date desc) as rn 
from branze.crm_cust_info ) as last_fig
where rn =1 and cst_id is not null;

