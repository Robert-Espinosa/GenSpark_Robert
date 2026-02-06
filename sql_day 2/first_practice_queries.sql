/*
	select everything from a table
*/
select *
from employees;


/*
	select specific col
*/
select employees.EmployeeID
from employees;

/*
	selecting based off a where clause so get people born before 1950
*/
select employees.BirthDate
from employees
where employees.BirthDate < '1950-01-01';

/*
	selecting based on sort
*/
select employees.FirstName
from employees
order by employees.FirstName asc;

/*
	used limit to limit output to 3 results
*/
select employees.LastName
from employees
order by employees.lastName
limit 3;
