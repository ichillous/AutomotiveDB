CREATE DATABASE AutomotiveDB;

USE AutomotiveDB;

CREATE TABLE UnnormalizedCars (
	CarID INT,
    CarModel VARCHAR(100),
    OwnerName VARCHAR(100),
    OwnerAddress VARCHAR(255),
    OwnerPhone VARCHAR(20),
    ServiceDates VARCHAR(255),
    ServiceDescriptions VARCHAR(255),
    TotalServiceCost DECIMAL(10, 2)
);

INSERT INTO UnnormalizedCars VALUES
(1, 'Toyota Camry', 'John Doe', '123 Elm St', '555-1234', '2021-01-10,2021-06-15', 'Oil Change,Tire Rotation', 150.00),
(2, 'Honda Accord', 'Alice Johnson', '456 Oak St', '555-8765', '2021-02-20,2021-08-30', 'Brake Inspection,Battery Replacement', 200.00),
(3, 'Ford Focus', 'Chris Evans', '789 Pine St', '555-6789', '2021-03-15', 'Transmission Repair', 500.00),
(4, 'Chevrolet Malibu', 'Emily Davis', '101 Maple St', '555-9876', '2021-04-25,2021-09-10', 'Engine Tune-Up,Alignment', 300.00),
(5, 'Nissan Altima', 'David Wilson', '202 Birch St', '555-2468', '2021-05-05,2021-11-20', 'Oil Change,Brake Replacement', 250.00),
(6, 'Hyundai Elantra', 'Susan Clark', '304 Cherry St', '555-3322', '2021-04-20,2021-10-10', 'Oil Change,Air Filter', 130.00),
(7, 'BMW 320i', 'Michael Brown', '987 Walnut St', '555-7788', '2021-02-28,2021-08-05', 'Brake Inspection,Transmission Repair', 650.00),
(8, 'Audi A4', 'Jennifer Lopez', '402 Cedar St', '555-9988', '2021-03-22,2021-09-12', 'Battery Replacement,Tire Rotation', 200.00),
(9, 'Mercedes C-Class', 'Robert King', '123 Oak St', '555-5544', '2021-05-18,2021-12-01', 'Engine Tune-Up,Alignment', 450.00),
(10, 'Volkswagen Passat', 'Emily Johnson', '456 Pine St', '555-1239', '2021-06-10,2021-11-20', 'Oil Change,Brake Replacement', 300.00);

SELECT * FROM UnnormalizedCars;

CREATE TABLE Cars1NF (
	CarID INT,
    CarModel VARCHAR(100),
    OwnerName VARCHAR(100),
    OwnerAddress VARCHAR(255),
    OwnerPhone VARCHAR(20),
	PRIMARY KEY (CarID)
);
SELECT * FROM Cars1NF;

CREATE TABLE Services1NF (
	ServiceID INT,
    CarID INT,
    ServiceDates VARCHAR(255),
    ServiceDescription VARCHAR(255),
    ServiceCost DECIMAL(10,2),
    PRIMARY KEY (ServiceID),
    FOREIGN KEY (CarID) REFERENCES Cars1NF(CarID)
);
SELECT * FROM Service1NF;

CREATE TABLE Owners (
	OwnerID INT,
    OwnerName VARCHAR(255),
    OwnerAddress VARCHAR(255),
    OwnerPhone VARCHAR(20),
    PRIMARY KEY (OwnerId)
);
SELECT * FROM Owners;

CREATE TABLE Cars2NF (
	CarId INT,
    OwnerID INT,
	PRIMARY KEY (CarID),
    CarModel VARCHAR(100),
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

CREATE TABLE Services2NF (
	ServiceID INT,
    CarID INT,
    PRIMARY KEY (ServiceID),
    ServiceDate VARCHAR(255),
    ServiceDescription VARCHAR(255),
    ServiceCost DECIMAL(10,2),
    FOREIGN KEY (CarID) REFERENCES Cars2NF(CarID)
);

CREATE TABLE ServiceTypes (
	ServiceTypeID INT,
    ServiceDescription VARCHAR(255),
    ServiceCost DECIMAL(10,2),
    PRIMARY KEY (ServiceTypeID)
);

CREATE TABLE Services3NF (
	ServiceID INT,
    CarID INT,
    ServiceDate VARCHAR(255),
    ServiceTypeID INT,
    PRIMARY KEY (ServiceID),
    FOREIGN KEY(CarID) REFERENCES Cars2NF(CarID),
    FOREIGN KEY (ServiceTypeID) REFERENCES ServiceTypes(ServiceTypeID)
);


-- Insert data into Owners table
INSERT INTO Owners (OwnerID, OwnerName, OwnerAddress, OwnerPhone) VALUES
(1, 'John Doe', '123 Elm St', '555-1234'),
(2, 'Alice Johnson', '456 Oak St', '555-8765'),
(3, 'Chris Evans', '789 Pine St', '555-6789'),
(4, 'Emily Davis', '101 Maple St', '555-9876'),
(5, 'David Wilson', '202 Birch St', '555-2468'),
(6, 'Susan Clark', '304 Cherry St', '555-3322'),
(7, 'Michael Brown', '987 Walnut St', '555-7788'),
(8, 'Jennifer Lopez', '402 Cedar St', '555-9988'),
(9, 'Robert King', '123 Oak St', '555-5544'),
(10, 'Emily Johnson', '456 Pine St', '555-1239');

-- Insert data into Cars2NF table
INSERT INTO Cars2NF (CarID, CarModel, OwnerID) VALUES
(1, 'Toyota Camry', 1),
(2, 'Honda Accord', 2),
(3, 'Ford Focus', 3),
(4, 'Chevrolet Malibu', 4),
(5, 'Nissan Altima', 5),
(6, 'Hyundai Elantra', 6),
(7, 'BMW 320i', 7),
(8, 'Audi A4', 8),
(9, 'Mercedes C-Class', 9),
(10, 'Volkswagen Passat', 10);

-- Insert data into ServiceTypes table
INSERT INTO ServiceTypes (ServiceTypeID, ServiceDescription, ServiceCost) VALUES
(1, 'Oil Change', 50.00),
(2, 'Tire Rotation', 100.00),
(3, 'Brake Inspection', 100.00),
(4, 'Battery Replacement', 100.00),
(5, 'Transmission Repair', 500.00),
(6, 'Engine Tune-Up', 150.00),
(7, 'Alignment', 150.00),
(8, 'Brake Replacement', 200.00);

-- Insert data into Services3NF table
INSERT INTO Services3NF (ServiceID, CarID, ServiceDate, ServiceTypeID) VALUES
(1, 1, '2021-01-10', 1),
(2, 1, '2021-06-15', 2),
(3, 2, '2021-02-20', 3),
(4, 2, '2021-08-30', 4),
(5, 3, '2021-03-15', 5),
(6, 4, '2021-04-25', 6),
(7, 4, '2021-09-10', 7),
(8, 5, '2021-05-05', 1),
(9, 5, '2021-11-20', 8),
(10, 6, '2021-04-20', 1),
(11, 6, '2021-10-10', 6),
(12, 7, '2021-02-28', 3),
(13, 7, '2021-08-05', 5),
(14, 8, '2021-03-22', 4),
(15, 8, '2021-09-12', 2),
(16, 9, '2021-05-18', 6),
(17, 9, '2021-12-01', 7),
(18, 10, '2021-06-10', 1),
(19, 10, '2021-11-20', 8);


-- Query the Cars2NF table to retrieve car information
SELECT * FROM Cars2NF;

-- Query the Owners table to retrieve owner information
SELECT * FROM Owners;

-- Query the Services3NF table to retrieve service history
SELECT * FROM Services3NF;

-- Query the ServiceTypes table to retrieve service type information
SELECT * FROM ServiceTypes;