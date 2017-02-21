Use pubs
--SETUP SCRIPT
--==============
--Build two tables a copy of employees and a copy of authors

Select * into authcopy from authors;
Select * into empcopy from employee;

Select * from authcopy;
Select * from empcopy;

-- this way insert two records from employee to authcopy table
INSERT INTO authcopy (au_id,au_lname,au_fname,phone,address,city,state,zip,contract)
SELECT  CAST('' as int),CAST(fname as varchar(40)),CAST(lname as varchar(20)),CAST(minit as char(12))
,CAST(job_id as varchar(40)),CAST(job_lvl as varchar(20)),CAST(pub_id as char(2)),CAST(hire_date as char(5)),CAST('' as bit)
FROM employee
where job_lvl =170;

--OR the way professor shown
-- insert two records from employee to authcopy table
INSERT INTO authcopy(
	au_id,
	au_lname, 
	au_fname,
	phone,
	address,
	city,
	state,
	zip,
	contract) 
SELECT 
	emp_id,
	lname,
	fname,
	'408 496-7223',	
	'10932 Bigge Rd.',
	'Menlo Park',
	'CA',
	'94025',
	'1'
	FROM employee
	WHERE emp_id IN ('PMA42628M','PSA89086M');

--Validation Script
select * from authcopy


--Clean Up Script
drop table authcopy;
drop table empcopy;

 

