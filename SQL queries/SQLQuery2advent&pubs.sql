
--Q1> Using AdventureWorks - List all the employees show name and department
select	
		a.BusinessEntityID,
		CONCAT(c.FirstName,' ',c.MiddleName,' ',c.LastName) as Employee,
		d.Name as Department
from HumanResources.Employee a
left join HumanResources.EmployeeDepartmentHistory b on (a.BusinessEntityID = b.BusinessEntityID)
left join Person.Person c on (a.BusinessEntityID = c.BusinessEntityID)
left join HumanResources.Department d on (b.DepartmentID = d.DepartmentID)
order by 1
-----------------------------------------------------------------------------------------------------

--Q2> List the employee and manager show name and department for both (the manger is either the manager id from older installs or organization level)

select 
		Nop.Employee,
		CONCAT(E.FirstName,' ',E.MiddleName,' ',E.LastName) as Manager,
		Nop.Department
from(
select 	
		a.BusinessEntityID,
		CONCAT(c.FirstName,' ',c.MiddleName,' ',c.LastName) as Employee,
		d.Name as Department,
		a.OrganizationLevel
from HumanResources.Employee a
left join HumanResources.EmployeeDepartmentHistory b on (a.BusinessEntityID = b.BusinessEntityID)
left join Person.Person c on (a.BusinessEntityID = c.BusinessEntityID)
left join HumanResources.Department d on (b.DepartmentID = d.DepartmentID)
where a.OrganizationLevel is not null) as Nop
left join Person.Person E on (NOP.OrganizationLevel = E.BusinessEntityID)

-------------------------------------------------------------------------------------------------------

--Q3> Show the employees and their current and prior departments


select 
		b.BusinessEntityID,
		STUFF((	SELECT ', '	 + c.Name
			FROM HumanResources.EmployeeDepartmentHistory A
			left join HumanResources.Department c on (a.DepartmentID = c.DepartmentID)
			Where A.BusinessEntityID=B.BusinessEntityID FOR XML PATH('')),1,1,'') As "Departments(Previous, Current)"
From HumanResources.EmployeeDepartmentHistory B
left join Person.Person c on (b.BusinessEntityID = c.BusinessEntityID)
Group By b.BusinessEntityID


--Q4> Break apart the employee login id so that you have the domain (before the /) in one column and the login id (after the /) in two columns

select
		a.BusinessEntityID,
		concat (b.FirstName,' ',b.MiddleName,' ',b.LastName) as Employee,
		substring ( a.LoginID, 1, CHARINDEX('\', a.LoginID) -1) as Domain,
		substring ( a.LoginID, CHARINDEX('\', a.LoginID) +1, LEN (a.LoginID)) as "login ID"
from HumanResources.Employee a
inner join Person.Person b on (a.BusinessEntityID = b.BusinessEntityID)
order by 1

--Q5> Build a new column that is the employee email address in the form login_id@domain.com 

select
		Nop.BusinessEntityID,
		Nop.Employee,
		Nop.Domain,
		Nop.[login ID],
		concat (Nop.[login ID],'@',Nop.Domain,'.com') as "Email Address"
from(
select
		a.BusinessEntityID,
		concat (b.FirstName,' ',b.MiddleName,' ',b.LastName) as Employee,
		substring ( a.LoginID, 1, CHARINDEX('\', a.LoginID) -1) as Domain,
		substring ( a.LoginID, CHARINDEX('\', a.LoginID) +1, LEN (a.LoginID)) as "login ID"
from HumanResources.Employee a
inner join Person.Person b on (a.BusinessEntityID = b.BusinessEntityID)) as Nop
order by 1

--Q6> Calculate the age of an employee in years


Select
		c.BusinessEntityID,
		CONCAT(c.FirstName,' ',c.MiddleName,' ',c.LastName) as Employee,
		nop.Age
from
(select CASE
		WHEN dateadd  (year, datediff (year, a.BirthDate, GETDATE()), a.BirthDate) > getdate()
		THEN datediff (year, a.BirthDate, getdate()) - 1
		ELSE datediff (year, a.BirthDate, getdate())
		END as Age,
		a.BusinessEntityID
from HumanResources.Employee a) as nop
inner join person.Person c on (c.BusinessEntityID = nop.BusinessEntityID)
order by c.BusinessEntityID


--Q7> Does it work if the birthday hasn't happened yet if not fix it  


Select
		c.BusinessEntityID,
		CONCAT(c.FirstName,' ',c.MiddleName,' ',c.LastName) as Employee,
		nop.Age
from
(select CASE
		WHEN dateadd  (year, datediff (year, a.BirthDate, GETDATE()), a.BirthDate) > getdate()
		THEN datediff (year, a.BirthDate, getdate()) - 1
		ELSE datediff (year, a.BirthDate, getdate())
		END as Age,
		a.BusinessEntityID
from HumanResources.Employee a) as nop
inner join person.Person c on (c.BusinessEntityID = nop.BusinessEntityID)
order by c.BusinessEntityID

--Q8> List a titles prior year sales, define the current year as the max year in sales.
--Not sure
use Pubs;
select 
	a.title_id,
	b.title,
	year(a.ord_date),
	a.ord_num,
	a.qty
from sales a
inner join titles b on (a.title_id = b.title_id)
group by year ( a.ord_date)
having (year (a.ord_date) = (year (max (a.ord_date )) - 1))


select
	max(a.ord_date)
from sales a

--Q9> What titles have no sales
use Pubs
Select 
	t.title
from titles t
full join sales s on (t.title_id = s.title_id)
where ytd_sales is null

--Q10> What titles have no sales (use a correlated subquery)

use Pubs
select 
	t.title
from
(Select
	s.title_id,
	sum(s.qty) as qunatity
from sales s
group by s.title_id) as nop
full outer join titles t on (t.title_id = nop.title_id)
where nop.title_id is null


--Q11> Create a function to change the case of a string. As Follows.
--  This is A TEST String                                                       NOT SURE
--  becomes
--  tHIS IS a test sTRING


DROP FUNCTION dbo.StringChange

CREATE FUNCTION dbo.StringChange
(
	@String Varchar (max)
)	RETURNS Varchar (max) 
As
Begin
declare @Index int,
		@letter char(1),
		@Returnstring varchar (max)
set @Index = 1
set @Returnstring = ''
WHILE @Index <=LEN(@string)
Begin
	set @letter = (SUBSTRING(@string,@Index, 1))
	IF @letter =    UPPER(SUBSTRING(@string,@Index, 1))
	begin 
	set @Returnstring = concat(@Returnstring,LOWER(SUBSTRING(@string,@Index, 1)))
	end
	else 
	IF @letter = LOWER(SUBSTRING(@string,@Index, 1)) 
 	begin 
	set @Returnstring =concat(@Returnstring,UPPER(SUBSTRING(@string,@Index, 1)))
	end
	SET @Index = @Index +1
	end 
IF (@@ERROR	<> 0)
BEGIN
SET
@Returnstring = @string
END

RETURN @ReturnString
END

select dbo.StringChange ('This is A TEST String')

--Q12> Write a function to calculate age in years 


DROP FUNCTION dbo.AgeCalculator

CREATE FUNCTION dbo.AgeCalculator
(
	@BirthDate date
)	RETURNS numeric(2)  
AS
BEGIN
   RETURN ( 
   select case 
		WHEN dateadd  (year, datediff (year, @BirthDate, GETDATE()), @BirthDate) > getdate()
		THEN datediff (year, @BirthDate, getdate()) - 1
		ELSE datediff (year, @BirthDate, getdate())
		END) 
END

select dbo.AgeCalculator ('1993-01-29')


