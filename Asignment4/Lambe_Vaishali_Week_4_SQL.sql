--1)Using AdventureWorks - List all the employees show name and department
select p.FirstName,p.LastName,d.Name
from Person.Person p,HumanResources.Department d
inner join
HumanResources.EmployeeDepartmentHistory as h on h.DepartmentID=d.DepartmentID
where p.BusinessEntityID=h.BusinessEntityID;

--2)List the employee and manager show name and department for both (the manger is either the manager id from older installs or organization level)
select p.FirstName,p.LastName,d.Name,t.JobTitle
from Person.Person p,HumanResources.Department d
left outer join
HumanResources.EmployeeDepartmentHistory as h on h.DepartmentID=d.DepartmentID
left outer join
HumanResources.Employee_Temporal as t on t.BusinessEntityID=h.BusinessEntityID
where p.BusinessEntityID=h.BusinessEntityID
and h.EndDate is NULL
and t.JobTitle like '%Manager';

--3) Using AdventureWorks - Show the employees and their current and prior departments
select p.FirstName,p.LastName,d.Name as CurrentDepartment
from Person.Person p,HumanResources.Department d
left outer join
HumanResources.EmployeeDepartmentHistory as h on h.DepartmentID=d.DepartmentID
left outer join
HumanResources.Employee_Temporal as t on t.BusinessEntityID=h.BusinessEntityID
where p.BusinessEntityID=h.BusinessEntityID
and h.EndDate is NULL;

select p.FirstName,p.LastName,d.Name as PriorDepartment
from Person.Person p,HumanResources.Department d
left outer join
HumanResources.EmployeeDepartmentHistory as h on h.DepartmentID=d.DepartmentID
left outer join
HumanResources.Employee_Temporal as t on t.BusinessEntityID=h.BusinessEntityID
where p.BusinessEntityID=h.BusinessEntityID
and h.EndDate is Not NULL;

 --4) Using AdventureWorks - Break apart the employee login id so that you have the domain (before the /) in one column and the login id (after the /) in two columns
SELECT p.FirstName,p.LastName,
       LEFT(e.LoginID, CHARINDEX('\', e.LoginID) - 1) AS Domain,
       RIGHT(e.LoginID, LEN(LoginID) - CHARINDEX('\', e.LoginID)) AS Login_ID
FROM Person.Person p,HumanResources.Employee e
where p.BusinessEntityID=e.BusinessEntityID;

 --5) Using AdventureWorks - Build a new column that is the employee email address in the form login_id@domain.com 
 SELECT p.FirstName,p.LastName,
       concat(RIGHT(e.LoginID, LEN(LoginID) - CHARINDEX('\', e.LoginID)),'@',LEFT(e.LoginID, CHARINDEX('\', e.LoginID) - 1)) AS Email_ID
FROM Person.Person p,HumanResources.Employee e
where p.BusinessEntityID=e.BusinessEntityID;

 --6) Using AdventureWorks - Calculate the age of an employee in years
 SELECT p.FirstName,p.LastName,
 (Year(GetDate()) - (Year(e.BirthDate))) AS AgeInYears
 from HumanResources.Employee e,Person.Person p
 where p.BusinessEntityID=e.BusinessEntityID
 order by BirthDate;

 --7) Using AdventureWorks - Does it work if the birthday hasn't happened yet if not fix it
select e.LoginID, e.BirthDate,
CASE WHEN DATEADD(YY,DATEDIFF(yy,e.BirthDate,GETDATE()),e.BirthDate)<GETDATE() THEN DATEDIFF(yy,e.BirthDate,GETDATE())
ELSE DATEDIFF(yy,e.BirthDate,GETDATE())-1 END AS AgeInYears
from HumanResources.Employee e
order by BirthDate;

-- 8) Using Pubs - List a titles prior year sales, define the current year as the max year in sales.

select t.title_id, ord_date, (s.qty*t.price) as PriorSales ,title  from sales s
join titles t on (t.title_id=s.title_id)
where year(ord_date) =
	( select (max(year(ord_date))-1) from sales)

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

IF OBJECT_ID('dbo.ProperCase_Change') IS NOT NULL
    DROP FUNCTION dbo.ProperCase_Change
GO
create function ProperCase_Change(@Text as varchar(8000))
returns varchar(8000)
as
begin
   declare @Reset bit;
   declare @Ret varchar(8000);
   declare @i int;
   declare @c char(1);

   select @Reset = 1, @i=1, @Ret = ''; 

   while (@i <= len(@Text))
    select @c= substring(@Text,@i,1),
               @Ret = @Ret + case when @Reset=1 then UPPER(@c) else LOWER(@c) end,
			   @Reset = case when @c like '[a-z]' then 0 else 1 end,
               @i = @i +1
   return @Ret
end
GO

Select dbo.ProperCase_Change('This is a TEST String')


--12) Write a function to calculate age in years (like #7)
GO
IF OBJECT_ID('dbo.F_CalAgeEmp') IS NOT NULL
    DROP FUNCTION dbo.F_CalAgeEmp
GO

CREATE FUNCTION F_CalAgeEmp
(
      -- Add the parameters for the function here
      @dayOfBirth Datetime
)
RETURNS varchar(50)
AS
BEGIN
      -- Declare the return variable here
      DECLARE @Age varchar(50)
      SET @Age = '';     
      DECLARE @today datetime, @thisYearBirthDay datetime
      DECLARE @years int, @months int, @days int 
      SELECT @today = GETDATE() 
      SELECT @thisYearBirthDay = DATEADD(year, DATEDIFF(year, @dayOfBirth, @today), @dayOfBirth) 
      SELECT @years = DATEDIFF(year, @dayOfBirth, @today) - (CASE WHEN @thisYearBirthDay > @today THEN 1 ELSE 0 END)    
      SET @Age = convert(varchar(3),@years) + ' Years '
	  -- Return the result of the function
     RETURN @Age
END

select dbo.F_CalAgeEmp('12-20-2000')

