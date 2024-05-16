-- Description: SQL Script for Creating Tables within the Relational Database
-- Filename: relational_db_table_creation.sql
USE ORDERS_RELATIONAL_DB; 
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Categories' AND type = 'U')
CREATE TABLE Categories (
    CategoryID INT NOT NULL,
    CategoryName VARCHAR(255),
    Description VARCHAR(255)
);

-- Create table for Customers
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Customers' AND type = 'U')
CREATE TABLE Customers (
    CustomerID VARCHAR(10) NOT NULL,
    CompanyName VARCHAR(255),
    ContactName VARCHAR(255),
    ContactTitle VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(10),
    Country VARCHAR(255),
    Phone VARCHAR(255),
    Fax VARCHAR(255)
);


-- Create table for Employees
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Employees' AND type = 'U')
CREATE TABLE Employees (
    EmployeeID INT NOT NULL,
    LastName VARCHAR(255),
    FirstName VARCHAR(255),
    Title VARCHAR(255),
    TitleOfCourtesy VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255),
    HomePhone VARCHAR(255),
    Extension VARCHAR(255),
    Notes TEXT,
    ReportsTo INT,
    PhotoPath TEXT);


-- Create table for Orders
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'OrderDetails' AND type = 'U')
CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(10, 2)
);


-- Create table for OrderDetails
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Orders' AND type = 'U')
CREATE TABLE Orders (
    OrderID INT NOT NULL,
    CustomerID VARCHAR(10),
    EmployeeID INT,
    OrderDate DATE,
    RequiredDate DATE,
    ShippedDate DATE,
    ShipVia INT,
    Freight DECIMAL(10, 2),
    ShipName VARCHAR(255),
    ShipAddress VARCHAR(255),
    ShipCity VARCHAR(255),
    ShipRegion VARCHAR(255),
    ShipPostalCode VARCHAR(10),
    ShipCountry VARCHAR(255),
    TerritoryID VARCHAR(10)
);

-- Create table for Products
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Products' AND type = 'U')
CREATE TABLE Products (
    ProductID INT NOT NULL,
    ProductName VARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(255),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BIT
);

-- Create table for Regions
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Region' AND type = 'U')
CREATE TABLE Region (
    RegionID INT NOT NULL,
    RegionDescription VARCHAR(255)
);


-- Create table for Shippers
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Shippers' AND type = 'U')
CREATE TABLE Shippers (
    ShipperID INT NOT NULL,
    CompanyName VARCHAR(255),
    Phone VARCHAR(255)
);

-- Create table for Suppliers
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Suppliers' AND type = 'U')
CREATE TABLE Suppliers (
    SupplierID INT NOT NULL,
    CompanyName VARCHAR(255),
    ContactName VARCHAR(255),
    ContactTitle VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(255),
    Country VARCHAR(255),
    Phone VARCHAR(255),
    Fax VARCHAR(255),
    HomePage VARCHAR(255)
);


-- Create table for Territories
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Territories' AND type = 'U')
CREATE TABLE Territories (
    TerritoryID VARCHAR(10) NOT NULL,
    TerritoryDescription VARCHAR(255),
    RegionID INT
);