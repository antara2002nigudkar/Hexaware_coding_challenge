create database carrentalsystem;
use car_rental_system;
create table Vehicle (
	VehicleID int primary key,
	make varchar(50),
	Model varchar(50),
	Year int,
	DailyRate decimal(5,2),
	status varchar(20),
	passengerCapacity int,
	engineCapacity int,
);
-- Create Customer table
CREATE TABLE Customer (
    customerID INT PRIMARY KEY ,     -- Unique identifier for each customer
    firstName VARCHAR(50) NOT NULL,               -- Customer's first name
    lastName VARCHAR(50) NOT NULL,                -- Customer's last name
    email VARCHAR(100) NOT NULL UNIQUE,           -- Customer's email address (must be unique)
    phoneNumber VARCHAR(15)                       -- Customer's phone number
);
-- Create Lease table
CREATE TABLE Lease (
    leaseID INT PRIMARY KEY ,        -- Unique identifier for each lease
    vehicleID INT NOT NULL,                        -- Foreign key referencing Vehicle table
    customerID INT NOT NULL,                       -- Foreign key referencing Customer table
    startDate DATE NOT NULL,                       -- Lease start date
    endDate DATE NOT NULL,                         -- Lease end date
    type VARCHAR(25) NOT NULL, -- Type of lease
    FOREIGN KEY(vehicleID)  REFERENCES Vehicle, -- Establish relationship with Vehicle
    FOREIGN KEY(customerID)  REFERENCES Customer-- Establish relationship with Customer
);
-- Create Payment table
CREATE TABLE Payment (
    paymentID INT PRIMARY KEY ,      -- Unique identifier for each payment
    leaseID INT NOT NULL,                          -- Foreign key referencing Lease table
    paymentDate DATE NOT NULL,                     -- Date of payment
    amount DECIMAL(10, 2) NOT NULL,               -- Amount paid
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID) -- Establish relationship with Lease
);
INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity) VALUES
(1, 'Toyota', 'Camry', 2022, 50.00, 'available', 4, 1.450),
(2, 'Honda', 'Civic', 2023, 45.00, 'available', 7, 1.500),
(3, 'Ford', 'Focus', 2022, 48.00, 'notAvailable', 4, 1.400),
(4, 'Nissan', 'Altima', 2023, 52.00, 'available', 7, 1.200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 'available', 4, 1.800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 'notAvailable', 7, 1.400),
(7, 'BMW', '3 Series', 2023, 60.00, 'available', 7, 2.499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 'available', 8, 2.599),
(9, 'Audi', 'A4', 2022, 55.00, 'notAvailable', 4, 2.500),
(10, 'Lexus', 'ES', 2023, 54.00, 'available', 4, 2.500);
select*from Vehicle;
INSERT INTO Customer (customerID,firstName, lastName, email, phoneNumber) VALUES
(1,'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2,'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3,'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4,'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5,'David', 'Lee', 'david@example.com', '555-987-6543'),
(6,'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7,'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8,'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9,'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10,'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');
select*from Customer;
INSERT INTO Lease (leaseID,vehicleID, customerID, startDate, endDate, type) VALUES
(1,1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2,2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3,3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4,4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5,5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6,4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7,7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8,8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9,3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10,10, 10, '2023-10-10', '2023-10-31', 'Monthly');
select*from Lease;
INSERT INTO Payment (paymentID, leaseID, paymentDate, amount) VALUES
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);
select*from Payment;
--1. Update the daily rate for a Mercedes car to 68.
UPDATE Vehicle
SET dailyRate = 68.00
WHERE make = 'Mercedes' AND model = 'C-Class';
--2. Delete a specific customer and all associated leases and payments.
DELETE FROM Payment
WHERE leaseID IN (
    SELECT leaseID FROM Lease WHERE customerID = 1
);
DELETE FROM Lease
WHERE customerID = 1;
--3. Rename the "paymentDate" column in the Payment table to "transactionDate".
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';

--4. Find a specific customer by email.
SELECT *
FROM Customer
WHERE email = 'robert@example.com';

--5. Get active leases for a specific customer.
SELECT *
FROM Lease
WHERE customerID = 1
  AND startDate <= GETDATE()
  AND endDate >= GETDATE();
  --6. Find all payments made by a customer with a specific phone number.
 SELECT p.*
FROM Payment p
JOIN Lease l ON p.leaseID = l.leaseID
JOIN Customer c ON l.customerID = c.customerID
WHERE c.phoneNumber = '555-789-1234';

--7. Calculate the average daily rate of all available cars.
SELECT AVG(dailyRate) AS average_daily_rate
FROM Vehicle
WHERE status = 'available';

--8. Find the car with the highest daily rate.
SELECT TOP 1 *
FROM Vehicle
ORDER BY dailyRate DESC;

--9. Retrieve all cars leased by a specific customer.
SELECT v.*
FROM Vehicle v
JOIN Lease l ON v.vehicleID = l.vehicleID
JOIN Customer c ON l.customerID = c.customerID
WHERE c.customerID = 3;

--10. Find the details of the most recent lease.
select top 1 * From Lease
order by endDate desc;

--11. List all payments made in the year 2023.
select * from payment
where year(transactionDate) = 2023;

--12. Retrieve customers who have not made any payments.
select C.*
from Customer C 
left join Lease L on L.customerID = C.CustomerID
left join payment P on P.leaseID = L.leaseID
where P.paymentID is null;

--13.Retrieve Car Details and Their Total Payments.
select V.VehicleID,V.make ,V.Model ,SUM(P.amount) as [Total Payment]
from Vehicle V
join Lease L on V.VehicleID = L.vehicleID
join payment P on P.leaseID = L.leaseID
group by 
V.VehicleID, V.make, V.Model;

--14. Calculate Total Payments for Each Customer.
SELECT C.CustomerID, C.firstName, C.lastName, SUM(P.amount) AS [Total Payments]
FROM Customer C
join Lease L ON C.CustomerID = L.CustomerID
join Payment P ON L.LeaseID = P.LeaseID
GROUP BY C.CustomerID, C.firstName, C.lastName;

--15. List Car Details for Each Lease.
SELECT L.leaseID, L.startDate, L.endDate, L.type, 
       V.VehicleID, V.make, V.Model, V.Year, V.DailyRate, V.status, V.passengerCapacity, V.engineCapacity
FROM Lease L
JOIN Vehicle V ON L.vehicleID = V.VehicleID;

--16. Retrieve Details of Active Leases with Customer and Car Information.
SELECT L.leaseID, L.startDate, L.endDate, L.type, 
       C.CustomerID, C.firstName, C.lastName, C.email, C.phoneNumber,
       V.VehicleID, V.make, V.Model, V.Year, V.DailyRate, V.status
FROM Lease L
JOIN Customer C ON L.customerID = C.CustomerID
JOIN Vehicle V ON L.vehicleID = V.VehicleID
WHERE L.endDate >= GETDATE();  

--17. Find the Customer Who Has Spent the Most on Leases.
SELECT TOP 1 C.CustomerID, C.firstName, C.lastName, SUM(P.amount) AS [Total Payments]
FROM Customer C
JOIN Lease L ON C.CustomerID = L.CustomerID
JOIN Payment P ON L.LeaseID = P.LeaseID
GROUP BY C.CustomerID, C.firstName, C.lastName
ORDER BY [Total Payments] DESC;

--18. List All Cars with Their Current Lease Information.
SELECT V.VehicleID, V.make, V.Model, V.Year, V.DailyRate, V.status, 
       L.leaseID, L.startDate, L.endDate, L.type
FROM Vehicle V
LEFT JOIN Lease L ON V.VehicleID = L.vehicleID
WHERE L.endDate >= GETDATE();


