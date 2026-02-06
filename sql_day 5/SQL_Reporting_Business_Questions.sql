/*
	ROBERT ESPINOSA -- SQL DAY 5
    
	TASK 1:
	
	there are many problems that SQL can solve in this database, to list a couple:
    1. what orders have the most quanity and what customers ordered this?
		Would require the orderDetails, orders, and customers. Where you join customerID between customers and orders. 
        Then join order deatials to orders using the orderID. metrics would be 
    
    2. What shippers have most orders?
		would require the Orders, and Shippers tables and would need to be joined with ShipperID. Metrics would be ShipperName and OrderCount
        
	3.What shippers ship the most quantity?
		would require the orders, order Details, and shippers tables. 
        Would joing orders to order details with the OrderID and then join orders to the shipper with shipperID.alter.
        Metrics would be Quanatity and Shipper name
        
*/
/*

	TASK 2:
    
	Question: what orders have the most quanity and what customers ordered this?
	query to find the order ID and the quanity assoiated along with the customerName
    
    This query joins mutiple tables selects only relevent information and uses Aliases
    
    This is a good query becasue it shows you who your best costomers are based on quantity (could also do prices)
*/
SELECT o.OrderID as OID, sum(od.Quantity) as quantity, c.CustomerName as CN
FROM orderdetails od
JOIN orders o on od.OrderID = o.OrderID
JOIN customers c on o.CustomerID = c.CustomerID
group by o.OrderID
order by quantity desc;

/*
		TASK 2: 
		get the ORDER and what customer order them 
        
        This query joins the orders table to the customer and gives an order ID along with the customer and contact name of who orderd it.
        
        This is good query if you want to fill information out for what a customer ordered you have have the order and the customer name.
    */
    
SELECT o.OrderID as ID, c.CustomerName as CustomerName, c.ContactName as Contact
FROM Orders o
JOIN customers c ON o.CustomerID = c.CustomerID;

/*
		TASK 2:
        Get a product and its Suplier
        
        this query joings the products and supplies class off the supplierID, It then outputs the supplier name and the product name

		This is good query in case of an issue with a product you can reach out to the supplier and get infromation.
*/
SELECT p.ProductName as Product, S.SupplierName as Supplier
FROM products p
JOIN suppliers S on p.SupplierID = S.SupplierID;

/*
		TASK 3 (same as task 2 but task 3 asks for all reporting questions): 
            1. what orders have the most quanity and what customers ordered this?
            
            See task 2
*/
SELECT o.OrderID as OID, sum(od.Quantity) as quantity, c.CustomerName as CN
FROM orderdetails od
JOIN orders o on od.OrderID = o.OrderID
JOIN customers c on o.CustomerID = c.CustomerID
GROUP BY o.OrderID
ORDER BY quantity desc;


/*
		TASK 3 B: 
            2. What shippers have most orders and how many orders?
            
            This query shows us which shipper have the most orders and then you could check if they show up on time and are reliable. 
			Its also good to not put all your shipments with the same shipper in case of issues
*/
SELECT count(*) as numOrders, s.ShipperName as Shipper
FROM orders o
JOIN shippers s on o.ShipperID = s.ShipperID
GROUP BY s.ShipperName
ORDER BY numOrders DESC
LIMIT 1;

/*
		TASK 3 C: 
        	3.What shippers ship the most quantity?
            
            This query is good becasue it shows how much quantity a shipper is able to ship and what they are doing already.
            So if you have alot of quanitty going throuhg one shipper you can choose an alternative
*/
SELECT sum(od.Quantity) as totalQuantity, s.ShipperName as Shipper
FROM orders o
join shippers s on o.ShipperID = s.ShipperID
join orderdetails od on o.OrderID = od.OrderID
group by Shipper
order by totalQuantity DESC
limit 1;


/*
	Task 4 A: customers with 5 or more orders inside the USA 
    
	good query for showing whos ordering alot (i choose 5 but could choose whatever) inside the USA. 
*/
SELECT C.CustomerName as CN, count(*) as totalOrders 
FROM customers C 
JOIN orders on orders.CustomerID = C.CustomerID
WHERE  C.Country = 'USA'
group by CN
having totalOrders > 5
Order by totalOrders desc;

/*
	Task 4 B: customers with less than 3 orders in london ordered by descending orders
    
    This is good query becasue it shows us whos ording a littler(less than 3 i choose) and you can market better towards them or try to sell more.
*/
SELECT C.CustomerName as CN, Count(*) as totalOrders
FROM customers C
JOIN orders on orders.CustomerID = C.CustomerID
WHERE C.City = 'London'
GROUP BY C.CustomerName
HAVING totalOrders < 3
ORDER BY totalOrders DESC;


/*
	Task 5 A, Question: who are the top selling Employees selling more than 35000, limited to 10 and ordered by totalSale.
    Works by selecting the first name and 
    
    this is good query becasue it shows you all the employees total sales and you can see who is selling well.
*/
SELECT E.FirstName as firstName, Sum(od.Quantity * P.price) as totalSales
FROM employees E
JOIN orders O on O.EmployeeID = E.EmployeeID
JOIN orderdetails od ON O.OrderID = od.OrderID
JOIN products P ON od.ProductID = P.ProductID
GROUP BY E.EmployeeID, firstName
Having totalSales > 35000
Order By totalSales desc
LIMIT 10;

/*
	Task 5 A, Question: who was the top selling employee in 1996?
    
    This works by joining orders, orderDetails,and products. Then uses a where clasue in order to filter dates out that irrelavent. then we group by employeeID becasue 
    emplyees can have the same name but if its by ID then each will get its own row and finally order it by the sales.
    
    This is a good query becasue it shows whos the best performing employee for a date rannge. You could either give raise or promote.
*/
SELECT E.FirstName as firstName, Sum(od.Quantity * P.price) as totalSales
FROM employees E
JOIN orders O on O.EmployeeID = E.EmployeeID
JOIN orderdetails od ON O.OrderID = od.OrderID
JOIN products P ON od.ProductID = P.ProductID
WHERE O.OrderDate BETWEEN '1996-01-01' AND '1996-12-31'
GROUP BY E.EmployeeID, firstName
Order By totalSales desc
LIMIT 1;

