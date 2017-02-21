/*
Created		10/2/2009
Modified		10/2/2009
Project		
Model			
Company		
Author		
Version		
Database		MS SQL 2005 
*/


Drop table [Department] 
go
Drop table [Many_students_Many_instructors] 
go
Drop table [instructors_taking_courses] 
go
Drop table [student_taking_courses] 
go
Drop table [Instructor] 
go
Drop table [student] 
go
Drop table [course] 
go


Create table [course]
(
	[course_id] Integer NOT NULL,
	[course_name] Varchar(20) NULL,
	[credits] Integer NULL,
	[dept_id] Integer NOT NULL,
Primary Key ([course_id])
) 
go

Create table [student]
(
	[student_id] Integer NOT NULL,
	[Name] Varchar(20) NULL,
	[Email] Varchar(30) NULL,
	[Phone_No] Varchar(20) NULL,
	[Address] Varchar(1) NULL,
Primary Key ([student_id])
) 
go

Create table [Instructor]
(
	[inst_id] Integer NOT NULL,
	[inst_name] Varchar(20) NULL,
	[dept_id] Integer NOT NULL,
Primary Key ([inst_id])
) 
go

Create table [student_taking_courses]
(
	[course_id] Integer NOT NULL,
	[student_id] Integer NOT NULL,
Primary Key ([course_id],[student_id])
) 
go

Create table [instructors_taking_courses]
(
	[course_id] Integer NOT NULL,
	[inst_id] Integer NOT NULL,
Primary Key ([course_id],[inst_id])
) 
go

Create table [Many_students_Many_instructors]
(
	[student_id] Integer NOT NULL,
	[inst_id] Integer NOT NULL,
Primary Key ([student_id],[inst_id])
) 
go

Create table [Department]
(
	[dept_id] Integer NOT NULL,
	[dept_name] Varchar(20) NULL,
Primary Key ([dept_id])
) 
go


Alter table [student_taking_courses] add  foreign key([course_id]) references [course] ([course_id])  on update no action on delete no action 
go
Alter table [instructors_taking_courses] add  foreign key([course_id]) references [course] ([course_id])  on update no action on delete no action 
go
Alter table [student_taking_courses] add  foreign key([student_id]) references [student] ([student_id])  on update no action on delete no action 
go
Alter table [Many_students_Many_instructors] add  foreign key([student_id]) references [student] ([student_id])  on update no action on delete no action 
go
Alter table [instructors_taking_courses] add  foreign key([inst_id]) references [Instructor] ([inst_id])  on update no action on delete no action 
go
Alter table [Many_students_Many_instructors] add  foreign key([inst_id]) references [Instructor] ([inst_id])  on update no action on delete no action 
go
Alter table [Instructor] add  foreign key([dept_id]) references [Department] ([dept_id])  on update no action on delete no action 
go
Alter table [course] add  foreign key([dept_id]) references [Department] ([dept_id])  on update no action on delete no action 
go


Set quoted_identifier on
go


Set quoted_identifier off
go


/* Roles permissions */


/* Users permissions */


