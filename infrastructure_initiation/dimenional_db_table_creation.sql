-- Filename: dimensional_db_table_creation.sql
USE ORDERS_DIMENSIONAL_DB;
GO

-- Dimension table for Categories using SCD Type 1
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimCategories' AND type = 'U')
CREATE TABLE DimCategories (
    CategorySK INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT NOT NULL,
    CategoryName VARCHAR(255),
    Description VARCHAR(255)
);

-- Dimension table for Customers using SCD Type 4
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimCustomers' AND type = 'U')
CREATE TABLE DimCustomers (
    CustomerSK INT IDENTITY(1,1) PRIMARY KEY,
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
    Fax VARCHAR(255),
    ActiveFlag BIT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME
);

-- Dimension table for Employees using SCD Type 1
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimEmployees' AND type = 'U')
CREATE TABLE DimEmployees (
    EmployeeSK INT IDENTITY(1,1) PRIMARY KEY,
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
    PostalCode VARCHAR(10),
    Country VARCHAR(255),
    HomePhone VARCHAR(255),
    Extension VARCHAR(255),
    Notes TEXT,
    ReportsTo INT,
    PhotoPath VARCHAR(255)
);

-- Dimension table for Products using SCD Type 4
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimProducts' AND type = 'U')
CREATE TABLE DimProducts (
    ProductSK INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    ProductName VARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(255),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT,
    UnitsOnOrder INT,
    ReorderLevel INT,
    Discontinued BIT,
    ActiveFlag BIT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME
);

-- Dimension table for Region using SCD Type 2
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimRegion' AND type = 'U')
CREATE TABLE DimRegion (
    RegionSK INT IDENTITY(1,1) PRIMARY KEY,
    RegionID INT NOT NULL,
    RegionDescription VARCHAR(255),
    ValidFrom DATETIME NOT NULL,
    ValidTo DATETIME NOT NULL,
    IsCurrent BIT NOT NULL
);

-- Dimension table for Shippers using SCD Type 3
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimShippers' AND type = 'U')
CREATE TABLE DimShippers (
    ShipperSK INT IDENTITY(1,1) PRIMARY KEY,
    ShipperID INT NOT NULL,
    CompanyName VARCHAR(255),
    Phone VARCHAR(255),
    PriorPhone VARCHAR(255)
);

-- Dimension table for Suppliers using SCD Type 3
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimSuppliers' AND type = 'U')
CREATE TABLE DimSuppliers (
    SupplierSK INT IDENTITY(1,1) PRIMARY KEY,
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
    PriorPhone VARCHAR(255),
    Fax VARCHAR(255),
    HomePage VARCHAR(255)
);

-- Dimension table for Territories using SCD Type 2
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DimTerritories' AND type = 'U')
CREATE TABLE DimTerritories (
    TerritorySK INT IDENTITY(1,1) PRIMARY KEY,
    TerritoryID VARCHAR(10) NOT NULL,
    TerritoryDescription VARCHAR(255),
    RegionID INT,
    ValidFrom DATETIME NOT NULL,
    ValidTo DATETIME NOT NULL,
    IsCurrent BIT NOT NULL
);

-- Fact table for Orders
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'FactOrders' AND type = 'U')
CREATE TABLE FactOrders (
    OrderSK INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    CustomerSK INT,
    EmployeeSK INT,
    ProductSK INT,
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
    TerritorySK INT,
    TotalAmount DECIMAL(18,2)
);
