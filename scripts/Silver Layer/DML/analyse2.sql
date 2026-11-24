-- check unwanted spaces
-- there is 17 last name with space problem and 15 firstname
--0 cst_martial_status with space issue the same for cst_gndr
select cst_lastname from branze.crm_cust_info  where cst_lastname != trim(cst_lastname);

select cst_firstname from branze.crm_cust_info  where cst_firstname != trim(cst_firstname);

select cst_gndr from branze.crm_cust_info  where cst_martial_status != trim(cst_martial_status);