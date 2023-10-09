use vishudb;
drop table EmployeeInfo;
select * from EmployeeInfo;
create table EmployeeInfo (EmpID int, EmpFnam varchar(50),EmpLnam varchar(50),Department varchar(50),Project varchar(50),
Address varchar(50),DOB varchar(50),gender varchar(5));
insert into EmployeeInfo (EmpID,EmpFnam,EmpLnam,Department,Project,Address,DOB,gender)
values(101,'Tim','David','HR','P1','Hyderabad (HYD)','01/12/1976','M');

insert into EmployeeInfo (EmpID,EmpFnam,EmpLnam,Department,Project,Address,DOB,gender)
values(102,'Teresa','Macdonald','Admin','P2','Delhi(DEL)','02/05/1968','F');

insert into EmployeeInfo (EmpID,EmpFnam,EmpLnam,Department,Project,Address,DOB,gender)
values(103,'Sydnee','Lewis','Account','P3','Mumbai(BOM)','01/01/1980','M');

insert into EmployeeInfo (EmpID,EmpFnam,EmpLnam,Department,Project,Address,DOB,gender)
values(104,'Jaelynn','Hahn','HR','P1','Hyderabad (HYD)','02/05/1992','F');

insert into EmployeeInfo (EmpID,EmpFnam,EmpLnam,Department,Project,Address,DOB,gender)
values(105,'Deandre','Simmons','Admin','P2','Delhi(DEL)','03/07/1994','M');
select * from EmployeeInfo;

create table EmployeePosition (EmpId int,EmpPosition varchar(50),DateOfJoining varchar(50),Salary int);
insert into EmployeePosition (EmpId,EmpPosition,DateOfJoining,Salary)
values(101,'Manager','01/05/2022',500000);

insert into EmployeePosition (EmpId,EmpPosition,DateOfJoining,Salary)
values(102,'Executive','02/05/2022',75000);

insert into EmployeePosition (EmpId,EmpPosition,DateOfJoining,Salary)
values(103,'Manager','01/05/2022',90000);

insert into EmployeePosition (EmpId,EmpPosition,DateOfJoining,Salary)
values(102,'Lead','02/05/2022',85000);

insert into EmployeePosition (EmpId,EmpPosition,DateOfJoining,Salary)
values(101,'Executive','01/05/2022',300000);

select * from EmployeePosition;
select * from employeeinfo;

-- Q.Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 and 
-- are grouped according to gender.
with cte as(
select * , row_number() over(partition by gender) as gr_gendr from employeeinfo)
select EmpFnam from cte where DOB between'02/05/1970' and '31/12/1975';

select EmpFnam from employeeinfo where DOB between'02/05/1970' and '31/12/1975';

--  Q.Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order
-- and Department in the ascending order.


select * from EmployeeInfo order by EmpLnam desc,Department asc ;

-- Q.Write a query to fetch details of employees 
-- whose EmpLname ends with an alphabet ‘S’ and contains five alphabets.
select * from employeeinfo where EmpLnam like '%S' and length(EmpLnam) = 5;

-- Q.Write a query to fetch details of all employees excluding the employees with 
-- firstnames, “Teresa” and “Jaelynn” from the EmployeeInfo table.
select * from employeeinfo where EmpFnam not in ('Teresa' , 'Jaelynn');

-- Q.Write a query to fetch details of employees with the address as “DELHI(DEL)”.
select * from employeeinfo where Address = 'DELHI(DEL)';

-- Q.Write a query to fetch all employees who also hold the manager  position.
select * from employeeposition where EmpPosition = 'Manager'; 
select * from EmployeePosition;


-- Q.Write a query to fetch the department-wise count of employees 
-- sorted by department’s count in ascending order.
select department, row_number() over(partition by department order by department ) as dep_no from employeeinfo;

-- Q.Write a query to calculate the even and odd records from a table.
select * from employeeinfo where mod(EmpId,2)=0;

select * from employeeinfo where mod(EmpId,2)!=0;

-- Q.Write a SQL query to retrieve employee details from EmployeeInfo table who have a 
-- dateofjoining in the EmployeePosition table.
select EmployeeInfo.*,EmployeePosition.* from EmployeeInfo
   join EmployeePosition
on EmployeeInfo.EmpID=EmployeePosition.EmpID ;


-- Q.Write a query to retrieve two minimum and maximum salaries from the Employee Positiontable.
with cte as (
select *,rank() over(order by salary) as min_salary ,
 rank()over(order by salary desc) as max_salary from employeeposition)
 select * from cte where min_salary=1 or max_salary=1
 order by salary;

-- Q.Write a query to find the Nth highest salary from the table with out using TOP/limit keyword.
select *, row_number() over(partition by EmpPosition order by salary) as nth_sal from employeeposition;

select * from employeeinfo;
-- Q.Write a query to retrieve the last 3 records from the EmployeeInfo table.
select * from EmployeeInfo order by EmpID desc limit 3;

select *, last_value(EmpID)over(partition by department order by EmpID desc) as las_val from employeeinfo limit 3;

-- Q.Write a query to find the third-highest salary from the EmpPosition table.
with cte as (
select *, rank() over(order by salary desc ) as rnk_sal from employeeposition)
select * from cte where rnk_sal=3;

-- Q.Write a query to display the first and the last record from the EmployeeInfo table.
(select * from employeeInfo order by empid limit 1)
union
(select * from employeeInfo order by empid desc limit 1);

-- Q.Write a query to retrieve Departments who have less than 2 employees working in it.

with cte as(
select *,row_number()over(partition by department order by department) as rank_dept from employeeInfo)
select * from cte where rank_dept <=1 ;

-- Q.Write a query to retrieve EmpPostion along with total salaries paid for each of them.
select *,sum(salary) from employeeposition;

-- Q.Write a query to fetch 50% records from the EmployeeInfo table
select  Top 50 PERCENT row_number()over( order by empid) as rw_no,* from EmployeeInfo;








