/*
	Query to show the orderID, returns only the matching record
*/
Select orders.OrderID
from orders
inner join orderdetails on
orders.OrderID = orderdetails.OrderID;

/*
	query to show the orderID and then productID, and order date
*/
select orders.OrderID, orderdetails.ProductID, orders.OrderDate
from orders
inner join orderdetails on
orders.OrderID = orderdetails.OrderID;


/*
	select all the orders and join the desciption if it has on, if not it still shows the orderDetialID
    estially this query shows you what orderDetailId have categories and shows desciptions if they do have category or null if nothing
*/
Select orderdetails.OrderDetailID ,categories.Description
from orderdetails
Left join categories on
orderdetails.ProductID = categories.CategoryID;

/*
	finds the shipper name and the date that it was shipped, but then filters it to only get the dates after 1997-01-01
*/
Select orders.OrderDate, shippers.ShipperName
from orders
left join shippers
on orders.ShipperID = shippers.ShipperID
where orders.OrderDate > '1997-01-01';

/*
	finds the shipper name and the date that it was shipped, but then filters it to only get the dates after 1997-01-01, then sorts them by most recent shipment
*/
Select orders.OrderDate, shippers.ShipperName
from orders
left join shippers
on orders.ShipperID = shippers.ShipperID
where orders.OrderDate > '1997-01-01'
order by orders.OrderDate desc;


