/*
Two querys that each have to do with counting on counts rows, the other counts how many employees born beofre date
*/
Select count(*)
from employees;

select count(employees.EmployeeID)
from employees
where employees.BirthDate < '1950-01-01';

/*
	simply calcualted the sum of all the products price and then also the avg price of items
*/
select sum(products.Price)
from products;

select avg(products.price)
from products;

/*
	MIN and MAX products that are in the Databse
*/
Select min(products.Price)
from products;

select max(products.Price)
from products;

/*
	count how mnay employees are in differnt countries and display as Country : count
*/
Select customers.Country, count(customers.Country) 
from customers
group by customers.Country;

/*
	using having to find which countries have more than 5 customers in them. having works after the grouping
*/
Select customers.Country, count(customers.Country) as c
from customers
group by customers.Country
having c > 5;

/*
	putting it all together
*/

