CREATE DATABASE FLEET_MGT

USE FLEET_MGT

CREATE TABLE Vehicles(
			LicensePlate VARCHAR(100),
			Make VARCHAR(100),
			Model VARCHAR(100),
			Year INT,
			Color VARCHAR(100),
			VIN VARCHAR(100),
			)

CREATE TABLE Drivers(
			FirstName VARCHAR(200),
			LastName VARCHAR(200),
			LicenseNumber VARCHAR(200),
			Phone VARCHAR(100),
			Address VARCHAR(300),
			City VARCHAR(100),
			State VARCHAR(100),
			ZipCode VARCHAR(100),
			)

CREATE TABLE Trips(
			VehicleID INT,
			DriverID INT,
			StartDate DATE,
			EndDate DATE,
			StartLocation VARCHAR(200),
			EndLocation VARCHAR(200),
			Distance INT,
			)

CREATE TABLE Maintenance(
			VehicleID INT,
			MaintenanceDate DATE,
			Description VARCHAR(100),
			Cost Decimal(7,3),
			)


SELECT * FROM Vehicles
SELECT * FROM Drivers
SELECT * FROM Trips
SELECT * FROM Maintenance

INSERT INTO Vehicles(LicensePlate,Make,Model,Year, Color,VIN)
VALUES('ABC123','Toyota','Corolla',2020,'White','1HGCM82633A004352'),
	  ('XYZ789','Ford','Fusion',2018,'Blue','2HGCM82633A004353');

INSERT INTO Drivers(FirstName,LastName,LicenseNumber,Phone,Address,City,State,ZipCode)
VALUES('Michael','Smith','D1234567','1234567890','123 Main St','Anytown','CA', '12345'),
		('Sarah','Connor','D7654321','0987654321','456 Elm St','Otherville','NY','54321');

INSERT INTO Trips(VehicleID,DriverID,StartDate,EndDate,StartLocation,EndLocation,Distance)
VALUES(1,1,'2024-07-01','2024-07-02','Los Angeles','San Francisco',380),
	(2,2,'2024-07-03','2024-07-04','New York','Washington D.C.',225);

INSERT INTO Maintenance(VehicleID,MaintenanceDate,Description,Cost)
VALUES(1,'2024-06-15','Oil Change',50.00),
		(2,'2024-06-20','Tire replacement',300.00);

UPDATE Maintenance
SET Cost =350.00
WHERE Description ='Tire replacement'

DELETE FROM Vehicles
WHERE make= 'Toyota'

INSERT INTO Trips(VehicleID,DriverID,StartDate,EndDate,StartLocation,EndLocation,Distance)
VALUES(2,1,'2024-07-05','2024-07-06','Boston','Philadelphia',300);


UPDATE Vehicles
SET Color ='Red'
WHERE Make ='Ford'

INSERT INTO Maintenance(VehicleID,MaintenanceDate,Description,Cost)
VALUES(1,'2024-07-10','Brake inspection',100.00);

UPDATE Drivers
SET Phone= '2223334444'
WHERE LastName ='Smith'

DELETE FROM Trips
WHERE VehicleID = 2

