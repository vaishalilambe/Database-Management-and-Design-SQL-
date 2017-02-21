--1)Using AdventureWorks - List all the employees show name and department
select p.FirstName,p.LastName,d.Name
from Person.Person p,HumanResources.Department d
inner join
HumanResources.EmployeeDepartmentHistory as h on h.DepartmentID=d.DepartmentID
where p.BusinessEntityID=h.BusinessEntityID;


--2)List the employee and manager show name and department for both (the manger is either the manager id from older installs or organization level)
--employees and managers
select 
		o.Employee,
		CONCAT(p1.FirstName,' ',p1.MiddleName,' ',p1.LastName) as Manager,
		o.Department
from(
select 	
		e.BusinessEntityID,
		CONCAT(p.FirstName,' ',p.MiddleName,' ',p.LastName) as Employee,
		d.Name as Department,
		e.OrganizationLevel
from HumanResources.Employee e
left join HumanResources.EmployeeDepartmentHistory h on (e.BusinessEntityID = h.BusinessEntityID)
left join Person.Person p on (e.BusinessEntityID = p.BusinessEntityID)
left join HumanResources.Department d on (h.DepartmentID = d.DepartmentID)
where e.OrganizationLevel is not null) as o
left join Person.Person p1 on (o.OrganizationLevel = p1.BusinessEntityID)

--only mangers
select p.FirstName,p.LastName,d.Name,t.JobTitle
from Person.Person p,HumanResources.Department d
left outer join
HumanResources.EmployeeDepartmentHistory as h on h.DepartmentID=d.DepartmentID
left outer join
HumanResources.Employee_Temporal as t on t.BusinessEntityID=h.BusinessEntityID
where p.BusinessEntityID=h.BusinessEntityID
and t.JobTitle like '%Manager';


--3) Using AdventureWorks - Show the employees and their current and prior departments
--Current departments
select p.FirstName,p.LastName,d.Name as CurrentDepartment
from Person.Person p,HumanResources.Department d
left outer join
HumanResources.EmployeeDepartmentHistory as h on h.DepartmentID=d.DepartmentID
left outer join
HumanResources.Employee_Temporal as t on t.BusinessEntityID=h.BusinessEntityID
where p.BusinessEntityID=h.BusinessEntityID
and h.EndDate is NULL;

--Prior department
select p.FirstName,p.LastName,d.Name as PriorDepartment
from Person.Person p,HumanResources.Department d
left outer join
HumanResources.EmployeeDepartmentHistory as h on h.DepartmentID=d.DepartmentID
left outer join
HumanResources.Employee_Temporal as t on t.BusinessEntityID=h.BusinessEntityID
where p.BusinessEntityID=h.BusinessEntityID
and h.EndDate is Not NULL;

 --4) Using AdventureWorks - Break apart the employee login id so that you have the domain (before the /) in one column and the login id (after the /) in two columns
select p.FirstName,p.LastName,
       LEFT(e.LoginID, CHARINDEX('\', e.LoginID) - 1) as Domain,
       RIGHT(e.LoginID, LEN(LoginID) - CHARINDEX('\', e.LoginID)) as Login_ID
from Person.Person p,HumanResources.Employee e
where p.BusinessEntityID=e.BusinessEntityID;

 --5) Using AdventureWorks - Build a new column that is the employee email address in the form login_id@domain.com 
select p.FirstName,p.LastName,
       concat(RIGHT(e.LoginID, LEN(LoginID) - CHARINDEX('\', e.LoginID)),'@',LEFT(e.LoginID, CHARINDEX('\', e.LoginID) - 1)) 
	   as Email_ID
from Person.Person p,HumanResources.Employee e
where p.BusinessEntityID=e.BusinessEntityID;

 --6) Using AdventureWorks - Calculate the age of an employee in years
select p.FirstName,p.LastName,
	(Year(GetDate()) - (Year(e.BirthDate))) as AgeInYears
from HumanResources.Employee e,Person.Person p
where p.BusinessEntityID=e.BusinessEntityID
order by BirthDate;

 --7) Using AdventureWorks - Does it work if the birthday hasn't happened yet if not fix it
select e.LoginID, e.BirthDate,
	case when DATEADD(YY,DATEDIFF(yy,e.BirthDate,GETDATE()),e.BirthDate)<GETDATE() 
		then DATEDIFF(yy,e.BirthDate,GETDATE())
		else DATEDIFF(yy,e.BirthDate,GETDATE())-1 
	end 
	as AgeInYears
from HumanResources.Employee e
order by BirthDate;

-- 8) Using Pubs - List a titles prior year sales, define the current year as the max year in sales.
select t.title_id, year(ord_date) as PriorYear, (s.qty*t.price) as PriorSales ,title  from sales s
join titles t on (t.title_id=s.title_id)
where year(ord_date) =
	(select (max(year(ord_date))-1) from sales)

-- 9) Using Pubs - What titles have no sales 
select t.title
from titles t
where t.title_id 
not in
	(select title_id 
	 from sales);

--10) Using Pubs - What titles have no sales (use a correlated subquery)
select t.title
from titles t
where not exists                        
	(select s.title_id 
	 from sales s
	 where t.title_id=s.title_id);

--11) Create a function to change the case of a string. As Follows.
 --This is A TEST String
 -- becomes
 -- tHIS IS a test sTRING

if OBJECT_ID('dbo.F_CaseChange') IS NOT NULL
   drop function dbo.F_CaseChange
go
create function dbo.F_CaseChange(@input varchar(250))
returns varchar (250)
as
begin
declare @i int,
		@res varchar(250),
		@char char

		set @i=1
		set @res=''
		while @i<= LEN(@input)
			begin
				set @char = substring (@input,@i,1)
				if @char = upper(@char) collate Latin1_General_CS_AS
					begin
					set @res=concat(@res,lower(@char))
				end
				else
					begin
					set @res = concat (@res,upper(@char))
				end
		set @i = @i+1
		end
return @res
end
go

--execute function to change string case
select dbo.F_CaseChange('This is A TEST String')


--12) Write a function to calculate age in years (like #7)

go
if OBJECT_ID('dbo.F_CalAgeEmp') IS NOT NULL
    drop function dbo.F_CalAgeEmp
go

create function F_CalAgeEmp
(
      -- Add the parameters for the function here
      @dayOfBirth Datetime
)
returns varchar(50)
as
begin     
     return(--returns employee age
	 select 
		case when DATEADD(YY,DATEDIFF(yy,@dayOfBirth,GETDATE()),@dayOfBirth)<GETDATE() 
		then DATEDIFF(yy,@dayOfBirth,GETDATE())
		else DATEDIFF(yy,@dayOfBirth,GETDATE())-1 
	    end )
end
go
--execute function pass parameters
select dbo.F_CalAgeEmp('12-20-2000')

