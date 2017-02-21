USE AdventureWorks;
GO
IF OBJECT_ID ( 'HumanResources.usp_GetEmployees', 'P' ) IS NOT NULL 
    DROP PROCEDURE HumanResources.usp_GetEmployees;
GO
CREATE PROCEDURE HumanResources.usp_GetEmployees 
    @lastname varchar(40), 
    @firstname varchar(20) 
AS 
    SELECT LastName, FirstName, JobTitle, Department
    FROM HumanResources.vEmployeeDepartment
    WHERE FirstName = @firstname AND LastName = @lastname;
GO

EXECUTE HumanResources.usp_GetEmployees 'Ackerman', 'Pilar';
EXEC HumanResources.usp_GetEmployees @lastname = 'Ackerman', @firstname = 'Pilar';
EXECUTE HumanResources.usp_GetEmployees @firstname = 'Pilar', @lastname = 'Ackerman';
HumanResources.usp_GetEmployees 'Ackerman', 'Pilar';



use pubs;


select * from employee;


select * from employee where emp_id = 'PMA42628M';


select * from employee where emp_id = 'PMA42628M';

select * from employee where emp_id = 'PMA42628M';

xxx' or 1 = '1


select * from employee where emp_id = 'xxx' or 1 = '1';






USE AdventureWorks
GO
-- Declare the variables to store the values returned by FETCH.
DECLARE @LastName varchar(50), 
		@FirstName varchar(50),
		@PriorLastName varchar(50), 
		@PriorFirstName varchar(50)

SET	@PriorLastName = ''
SET	@PriorFirstName = ''

DECLARE contact_cursor CURSOR FOR
SELECT  LastName, 
		FirstName 
FROM	Person.Contact
WHERE	LastName LIKE 'B%'
ORDER BY
		LastName, 
		FirstName

OPEN	contact_cursor

-- Perform the first fetch and store the values in variables.
-- Note: The variables are in the same order as the columns
-- in the SELECT statement. 

FETCH NEXT FROM contact_cursor
INTO @LastName, @FirstName

-- Check @@FETCH_STATUS to see if there are any more rows to fetch.
WHILE @@FETCH_STATUS = 0
BEGIN

   -- Concatenate and display the current values in the variables.
   PRINT 'Contact Name: ' + @FirstName + ' ' +  @LastName 

   IF (@PriorLastName = @LastName) 
   BEGIN
	   IF (@PriorFirstName = @FirstName) 
	     PRINT '>>>>> Duplicate: ' + @FirstName + ' ' +  @LastName
	   ELSE 
	     IF (soundex(@PriorFirstName) = soundex(@FirstName)) 
           PRINT '>>>>> Possible Duplicate: ' + @FirstName + ' ' +  @LastName 
   END
   SET @PriorLastName = @LastName
   SET @PriorFirstName = @FirstName
			
   -- This is executed as long as the previous fetch succeeds.
   FETCH NEXT FROM contact_cursor
   INTO @LastName, @FirstName
END

CLOSE contact_cursor
GO
DEALLOCATE contact_cursor




select soundex('vin');
select soundex('vinnie');
select soundex('vinnay');
select soundex('vinny');
select soundex('vince');
select soundex('vincent');

use pubs;
select * from stores;

select state from stores;

select distinct state from stores;
select state from stores group by state;


