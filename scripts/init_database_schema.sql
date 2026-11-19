use master;
go
/*
Objective:
	create database and make our three schema for more Organize tabels
	with is  'branze' 'silver' and  'gold' .
Warring :
	If you run this code immediatly this gonna delete you database if 
	it exist so be careful
*/
-- check if the database is alreday exist or not 
if EXISTS (select 1 from sys.databases where name = 'DataWarehouse')
Begin
	--set the database access by one user wich is me admin and rollback the change of others users
	Alter Database DataWarehouse set SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
end;

go

-- create database 'DataWarehouse'

create database DataWarehouse;
go

use DataWarehouse;

go
-- create the three layers schema 
create SCHEMA branze;
go
create SCHEMA silver;
go
create SCHEMA gold;
go



