-- check the primary key null and duplicated  for crm_cust_info



select top 10 * from branze.crm_cust_info;

select cst_id ,count(*) from branze.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null

-- we got this so this the problems
--29449	2
--29473	2
--29433	2
--NULL	3
--29483	2
--29466	3