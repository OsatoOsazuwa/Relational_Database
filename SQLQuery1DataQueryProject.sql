CREATE DATABASE DataQueryCheckpoint

USE DataQueryCheckpoint

CREATE TABLE Products(
ProductID INT PRIMARY KEY NOT NULL,
ProductName VARCHAR(100),
ProductType VARCHAR(100),
Price DECIMAL(5,2)
);

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY NOT NULL,
CustomerName VARCHAR(100),
Email VARCHAR(150),
Phone VARCHAR(150)
);

CREATE TABLE Orders(
OrderID INT PRIMARY KEY NOT NULL,
CustomerID INT,
OrderDate DATE,
FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
);

CREATE TABLE OrderDetails(
OrderDetailID INT PRIMARY KEY NOT NULL,
OrderID INT,
ProductID INT,
Quantity INT,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
);

CREATE TABLE ProductTypes(
ProductTypeID INT PRIMARY KEY NOT NULL,
ProductTypeName VARCHAR(130)
);

INSERT INTO Products VALUES(1, 'Widget A', 'Widget', 10.00);
INSERT INTO Products VALUES	(2,  'Widget B',  'Widget',  15.00);
INSERT INTO Products VALUES	(3, 'Gadget X', 'Gadget', 20.00);
INSERT INTO Products VALUES	( 4,  'Gadget Y',  'Gadget',  25.00);
INSERT INTO Products VALUES	(5,  'Doohickey Z', 'Doohickey', 30.00);


INSERT INTO Customers VALUES( 1, 'John Smith', 'john@example.com', '123-456-7890');
INSERT INTO Customers VALUES(2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210');
INSERT INTO Customers VALUES(3, 'Alice Brown', 'alice.brown@example.com', '456-789-0123');

INSERT INTO Orders VALUES(101, 1, '2024-05-01');
INSERT INTO Orders VALUES(102, 2, '2024-05-02');
INSERT INTO Orders VALUES(103, 3, '2024-05-01');

INSERT INTO OrderDetails VALUES(1, 101, 1,  2);
INSERT INTO OrderDetails VALUES(2, 101, 3,  1);
INSERT INTO OrderDetails VALUES (3, 102, 2, 3);
INSERT INTO OrderDetails VALUES (4, 102, 4, 2);
INSERT INTO OrderDetails VALUES (5, 103, 5, 1);

INSERT INTO ProductTypes VALUES (1, 'Widget');
INSERT INTO ProductTypes VALUES (2,  'Gadget');
INSERT INTO ProductTypes VALUES (3,  'Doohickey');	

SELECT * FROM Products
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM OrderDetails
SELECT * FROM ProductTypes


SELECT Products.ProductName, Orders.CustomerID, SUM(Quantity) AS Total from Products
JOIN OrderDetails
ON Products.ProductID = OrderDetails.ProductID
JOIN Orders
ON OrderDetails.OrderID = Orders.OrderID
GROUP BY Products.ProductName, Orders.CustomerID;

SELECT Customers.CustomerName, Orders.OrderDate,COUNT(orders.orderid) AS Total from Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName, Orders.OrderDate, orders.OrderID


SELECT Customers.CustomerName, Orders.OrderDate,COUNT(orders.orderid) AS OrderNumber from Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName, Orders.OrderDate, orders.OrderID
ORDER BY OrderNumber DESC

SELECT products.ProductName, SUM(Quantity) AS TotalQty FROM Products
JOIN OrderDetails
ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQty DESC

SELECT Customers.CustomerName, Products.ProductName, Quantity from Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName LIKE 'Widg%' AND Quantity >= 1;

SELECT Customers.CustomerName, (Products.ProductType), Quantity, (Products.Price * OrderDetails.Quantity) AS Total_Cost from Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
ON OrderDetails.ProductID = Products.ProductID
WHERE (Products.ProductType LIKE 'Widg%' OR Products.ProductType LIKE 'Gadg%' ) AND Quantity >= 1;

SELECT Customers.CustomerName, (Products.ProductType), Quantity, (Products.Price * OrderDetails.Quantity) AS Total_Cost from Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
ON OrderDetails.ProductID = Products.ProductID
WHERE  Products.ProductType LIKE 'Gadg%'  AND Quantity >= 1;




SELECT Customers.CustomerName, Orders.OrderDate,COUNT(orders.orderid) AS OrderNumber from Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName, Orders.OrderDate, orders.OrderID
ORDER BY OrderNumber DESC
 

SELECT Customers.CustomerName, Products.ProductType, Quantity,SUM (Products.Price * OrderDetails.Quantity) AS Total_Cost,
SUM(CASE WHEN products.productname like 'wid%' THEN orderdetails.quantity ELSE 0 END) AS total_widgets_ordered,
SUM(CASE WHEN products.productname like 'gad%' THEN orderdetails.quantity ELSE 0 END) AS total_gadgets_ordered,
SUM(CASE WHEN products.productname like 'doo%' THEN orderdetails.quantity ELSE 0 END) AS total_doohickey_ordered
INTO NEW
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
JOIN Products
ON OrderDetails.ProductID = Products.ProductID
GROUP BY Customers.CustomerName, Products.ProductType, Products.Price , OrderDetails.Quantity