CREATE TABLE Wine(
NumW INT,
Category VARCHAR(100),
Year INT,
Degree DECIMAL(4,1),
);


CREATE TABLE Producer(
NumP INT,
FirstName VARCHAR(100),
LastName VARCHAR(100),
Region VARCHAR(100)
);

ALTER TABLE Wine
ALTER COLUMN NumW INT NOT NULL;

ALTER TABLE Producer
ALTER COLUMN NumP INT NOT NULL;

ALTER TABLE Wine
ADD CONSTRAINT PK_NumW PRIMARY KEY (NumW);

ALTER TABLE Producer
ADD CONSTRAINT PK_NumP PRIMARY KEY (NumP);


CREATE TABLE Harvest (
   Quantity INT,
   NumW INT,
   NumP INT,
   FOREIGN KEY (NumW) REFERENCES Wine(NumW),
   FOREIGN KEY (NumP) REFERENCES Producer(NumP)
   )


INSERT INTO Wine VALUES(1, 'Red', 2019, 13.5);
INSERT INTO Wine VALUES(2, 'White', 2020, 12.0);
INSERT INTO Wine VALUES(3, 'Rose', 2018, 11.5);
INSERT INTO Wine VALUES(4, 'Red', 2021, 14.0);
INSERT INTO Wine VALUES(5, 'Sparkling', 2017, 10.5);
INSERT INTO Wine VALUES(6, 'White', 2019, 12.5);
INSERT INTO Wine VALUES(7, 'Red', 2022, 13.0);
INSERT INTO Wine VALUES(8, 'Rose', 2020, 11.0);
INSERT INTO Wine VALUES(9, 'Red', 2018, 12.0);
INSERT INTO Wine VALUES(10, 'Sparkling', 2019, 10.0);
INSERT INTO Wine VALUES(11, 'White', 2021, 11.5);
INSERT INTO Wine VALUES(12, 'Red', 2022, 15.0);


INSERT INTO Producer VALUES (1, 'John', 'Smith', 'Sousse');
INSERT INTO Producer VALUES (2, 'Emma', 'Johnson', 'Tunis');
INSERT INTO Producer VALUES (3, 'Michael', 'Williams', 'Sfax');
INSERT INTO Producer VALUES (4, 'Emily', 'Brown', 'Sousse');
INSERT INTO Producer VALUES (5, 'James', 'Jones', 'Sousse');
INSERT INTO Producer VALUES (6, 'Sarah', 'Davis', 'Tunis');
INSERT INTO Producer VALUES (7, 'David', 'Miller', 'Sfax');
INSERT INTO Producer VALUES (8, 'Olivia', 'Wilson', 'Monastir');
INSERT INTO Producer VALUES (9, 'Daniel', 'Moore', 'Sousse');
INSERT INTO Producer VALUES (10, 'Sophia', 'Taylor', 'Tunis');
INSERT INTO Producer VALUES (11, 'Matthew', 'Anderson', 'Sfax');
INSERT INTO Producer VALUES(12, 'Amelia', 'Thomas', 'Sousse');



INSERT INTO Harvest VALUES (1250, 1, 1);
INSERT INTO Harvest VALUES (1200, 2, 2);
INSERT INTO Harvest VALUES (100, 3, 3);
INSERT INTO Harvest VALUES (154, 4, 4);
INSERT INTO Harvest VALUES(500, 5, 5);
INSERT INTO Harvest VALUES(640, 6, 6);
INSERT INTO Harvest VALUES(170, 7, 7);
INSERT INTO Harvest VALUES(150, 8, 8);
INSERT INTO Harvest VALUES(140, 9, 9);
INSERT INTO Harvest VALUES(450, 10, 10);
INSERT INTO Harvest VALUES(530, 11, 11);
INSERT INTO Harvest VALUES(250, 12, 12);

SELECT * FROM Producer
SELECT * FROM Wine
SELECT * FROM Harvest

SELECT ISNULL(FirstName,'')+ ' ' + ISNULL(LastName,'') AS FullName FROM Producer
ORDER BY FirstName

--OR,

SELECT NumP, CONCAT(FirstName,' ', LastName) AS FullName, Region FROM Producer
ORDER BY FullName

SELECT * FROM Producer
WHERE Region = 'Sousse'

-- Creating a consolidated table including details from all tables

SELECT Wine.Category, Wine.Degree, Wine.Year, Harvest.Quantity, Producer.FirstName, Producer.LastName, Producer.Region
INTO New
FROM Harvest
FULL OUTER JOIN Wine
ON Harvest.NumW = Wine.NumW
FULL OUTER JOIN Producer
ON Harvest.NumP = Producer.NumP;

SELECT * NEW

SELECT Wine.NumW, SUM(Quantity) AS Total FROM Wine
JOIN Harvest
ON Wine.NumW = Harvest.NumW
where Wine.NumW = 12
GROUP BY Wine.NumW;



SELECT Wine.Category, SUM(Quantity) AS Total FROM Wine
JOIN Harvest
ON Wine.NumW = Harvest.NumW
GROUP BY Wine.Category

SELECT FirstName, CONCAT(FirstName,' ', LastName) AS Name FROM Producer
JOIN Harvest
ON Producer.NumP = Harvest.NumP
WHERE Producer.Region = 'Sousse' AND Harvest.Quantity > 300
ORDER BY FirstName, Name;


SELECT Wine.NumW, Degree, Producer.NumP
FROM Wine
JOIN Harvest
ON Wine.NumW  = Harvest.NumW
JOIN Producer
ON Harvest.NumP = Producer.NumP
WHERE Degree > 12 AND Producer.NumP = 24;

SELECT COUNT(Degree) AS Count_, Category
FROM Wine
JOIN Harvest
ON Wine.NumW  = Harvest.NumW
GROUP BY Category

SELECT TOP 1 MAX(Quantity) AS HighestQty, CONCAT(FirstName,' ', LastName) AS FullName, FirstName FROM Producer
JOIN Harvest
ON Producer.NumP = Harvest.NumP
GROUP BY FirstName, LastName
ORDER BY HighestQty DESC

SELECT AVG(Degree) AS Avg_Degree
FROM Wine
 
SELECT TOP 1 Year, Category, NumW, Degree 
FROM Wine
ORDER BY Year

SELECT FirstName, LastName, SUM(Quantity) AS TotalQuantityProduced
FROM Producer
JOIN Harvest
ON Producer.NumP = Harvest.NumP
GROUP BY FirstName, LastName
ORDER BY TotalQuantityProduced DESC
 
SELECT Wine.Category, Producer.NumP,Producer.FirstName, Producer.LastName, Producer.Region
FROM Harvest
FULL OUTER JOIN Wine
ON Harvest.NumW = Wine.NumW
FULL OUTER JOIN Producer
ON Harvest.NumP = Producer.NumP;


