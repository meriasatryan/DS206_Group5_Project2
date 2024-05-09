-- Description: SQL Script for Creating Tables within the Relational Database
-- Filename: relational_db_table_creation.sql
USE ORDERS_RELATIONAL_DB; -- Make sure to select your database
GO

CREATE TABLE Categories (
    CategoryID INT,
    CategoryName VARCHAR(255),
    Description VARCHAR(255)
);

-- Create table for Customers
CREATE TABLE Customers (
    CustomerID VARCHAR(10),
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
CREATE TABLE Employees (
    EmployeeID INT,
    LastName VARCHAR(255),
    FirstName VARCHAR(255),
    Title VARCHAR(255),
    TitleOfCourtesy VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(255),
    City VARCHAR(255),
    Region VARCHAR(255),
    PostalCode VARCHAR(10),
    Country VARCHAR(255),
    HomePhone VARCHAR(255),
    Extension VARCHAR(255),
    Notes TEXT,
    ReportsTo INT,
    PhotoPath VARCHAR(255)
);


-- Create table for Orders
CREATE TABLE Orders (
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(10, 2)
);


-- Create table for OrderDetails
CREATE TABLE OrderDetails (
    OrderID INT,
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
CREATE TABLE Products (
    ProductID INT,
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
CREATE TABLE Regions (
    RegionID INT,
    RegionDescription VARCHAR(255)
);


-- Create table for Shippers
CREATE TABLE Shippers (
    ShipperID INT,
    CompanyName VARCHAR(255),
    Phone VARCHAR(255)
);

-- Create table for Suppliers
CREATE TABLE Suppliers (
    SupplierID INT,
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
CREATE TABLE Territories (
    TerritoryID VARCHAR(10),
    TerritoryDescription VARCHAR(255),
    RegionID INT
);