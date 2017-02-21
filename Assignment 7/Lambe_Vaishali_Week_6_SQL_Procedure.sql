USE pubs
--check if object of procedure already exists or not if exists drop a procedure
IF ( OBJECT_ID('dbo.insert_reord_jobs') IS NOT NULL ) 
DROP PROCEDURE dbo.insert_reord_jobs;  

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_reord_jobs]
  @job_id smallInt,
  @job_desc varchar(50),
  @min_lvl tinyInt,
  @max_lvl tinyInt   
AS 
BEGIN 

 SET NOCOUNT ON; 

BEGIN 
		-- validation for @job_id data type and its value
		if ((@job_id < 0 or @job_id =0) or (@job_id is null or @job_id = '')) 
		begin
			raiserror('Invalid parameter: job_id.Please insert value of data type smallint except null, zero, negative or empty string.', 1,1)
			return
		end
		-- validation for @job_desc data type and its value
		else if (@job_desc is null or @job_desc = '')
		begin
			raiserror('Invalid parameter: job_desc.Please insert value of data type varchar except null or empty string.', 1,1)
		    return
		end
		-- validation for @min_lvl data type and its value
	    else if (@min_lvl = 0 or (@min_lvl is null or @min_lvl = ''))
		begin
			raiserror('Invalid parameter: min_lvl.Please insert value of date type tinyint except null, zero  or empty string.', 1,1)
			return
		end
		-- validation for @max_lvl data type and its value
	    else if ( @max_lvl = 0 or (@max_lvl is null or @max_lvl = ''))
		begin
			 raiserror('Invalid parameter: max_lvl.Please insert value of data type tinyint except null, zero or empty string.', 1,1)
			 return
		end
		--validate for min_lvl is less than max_lvl
		else if (@min_lvl>=@max_lvl)
		begin
			 raiserror('Invalid parameters: min_lvl should be smaller than max_lvl.', 1,1)
		     return
		end
		else 
		--display message validation successful 	
		print 'Validation Succeeded!'
		begin
		--set identity insert on to insert value in jobs table
		SET IDENTITY_INSERT dbo.jobs ON
		    --insert record in jobs table
			insert into dbo.jobs(job_id, job_desc, min_lvl, max_lvl)
			values(@job_id, @job_desc, @min_lvl, @max_lvl)
			
	    SET IDENTITY_INSERT dbo.jobs OFF
			--display message on successful insert of data
			print 'Values inserted successfully in jobs table of pubs database.'
        end
END
END
GO

EXEC dbo.insert_reord_jobs 21,'Publisher',25,100;

EXEC dbo.insert_reord_jobs -18,'Publisher',25,100;

EXEC dbo.insert_reord_jobs 0,'Publisher',25,100;

EXEC dbo.insert_reord_jobs null,'Publisher',25,100;

EXEC dbo.insert_reord_jobs '','Publisher',25,100;

EXEC dbo.insert_reord_jobs 21,'',25,100;

EXEC dbo.insert_reord_jobs 21,null,25,100;

EXEC dbo.insert_reord_jobs 16,'Publisher','',100;

EXEC dbo.insert_reord_jobs 17,'Publisher',null,100;

EXEC dbo.insert_reord_jobs 18,'Publisher',0,100;

EXEC dbo.insert_reord_jobs 17,'Publisher',5,null;

EXEC dbo.insert_reord_jobs 18,'Publisher',25,'';

EXEC dbo.insert_reord_jobs 18,'Publisher',25,0;

EXEC dbo.insert_reord_jobs 18,'Publisher',100,15;



select * from jobs;