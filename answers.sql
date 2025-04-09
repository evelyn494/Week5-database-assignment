-- Create the database
CREATE DATABASE salesDB;
USE salesDB;

-- Create tables with proper structure and indexes
CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(100) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    addressLine1 VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    creditLimit DECIMAL(10,2),
    INDEX IdxPhone (phone),  -- Index to be dropped in Q1
    INDEX IdxCountry (country)
);

CREATE TABLE payments (
    paymentID INT AUTO_INCREMENT PRIMARY KEY,
    customerNumber INT,
    checkNumber VARCHAR(50),
    paymentDate DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber),
    INDEX IdxPaymentDate (paymentDate)
);

CREATE TABLE orderdetails (
    orderNumber INT,
    productCode VARCHAR(15),
    quantityOrdered INT,
    priceEach DECIMAL(10,2),
    orderLineNumber INT,
    PRIMARY KEY (orderNumber, productCode),
    INDEX IdxProduct (productCode)
);

-- Insert sample data
INSERT INTO customers VALUES 
(103, 'AutoShop Ltd', 'Smith', 'John', '555-1234', '123 Main St', 'Nairobi', 'Kenya', 50000.00),
(104, 'SpeedParts Inc', 'Gray', 'Jane', '555-5678', '456 Elm St', 'Kampala', 'Uganda', 60000.00),
(105, 'MotoWorld', 'Brown', 'Mike', '555-9012', '789 Oak St', 'Dar es Salaam', 'Tanzania', 45000.00),
(106, 'AutoSpare Co', 'Ali', 'Samir', '555-7890', '321 Pine St', 'Addis Ababa', 'Ethiopia', 55000.00);

INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount) VALUES 
(103, 'AB123', '2023-12-01', 1500.00),
(103, 'AB124', '2023-12-02', 1800.00),
(104, 'AB125', '2023-12-03', 2000.00),
(104, 'AB126', '2023-12-01', 1200.00),
(105, 'AB127', '2023-12-04', 2500.00);

INSERT INTO orderdetails VALUES
(1001, 'S10_1678', 30, 100.00, 1),
(1002, 'S10_1678', 20, 100.00, 2),
(1003, 'S12_1099', 50, 150.00, 1),
(1004, 'S12_1099', 10, 150.00, 2),
(1005, 'S18_1589', 40, 120.00, 1);

-- Create a view for security purposes
CREATE VIEW customer_payments AS
SELECT c.customerName, p.paymentDate, p.amount
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber;

-- Create a stored procedure
DELIMITER //
CREATE PROCEDURE GetCustomerPayments(IN custNumber INT)
BEGIN
    SELECT * FROM payments WHERE customerNumber = custNumber;
END //
DELIMITER ;

-- Question 1: Drop an index named IdxPhone from customers table
ALTER TABLE customers DROP INDEX IdxPhone;

-- Question 2: Create a user named bob with password 'S$cu3r3!', restricted to localhost
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'S$cu3r3!';

-- Question 3: Grant INSERT privilege to bob on salesDB database
GRANT INSERT ON salesDB.* TO 'bob'@'localhost';

-- Question 4: Change password for user bob to 'P$55!23'
ALTER USER 'bob'@'localhost' IDENTIFIED BY 'P$55!23';