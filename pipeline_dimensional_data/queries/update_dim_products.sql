
CREATE TABLE DimProductsHistory (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
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
    EffectiveDate DATETIME NOT NULL,
    IsCurrent BIT NOT NULL
);

USE ORDERS_DIMENSIONAL_DB;
GO

MERGE DimProducts AS DST
USING (SELECT ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued FROM SourceProducts) AS SRC
ON (SRC.ProductID = DST.ProductID)

WHEN MATCHED THEN
    UPDATE SET
        DST.ProductName = SRC.ProductName,
        DST.SupplierID = SRC.SupplierID,
        DST.CategoryID = SRC.CategoryID,
        DST.QuantityPerUnit = SRC.QuantityPerUnit,
        DST.UnitPrice = SRC.UnitPrice,
        DST.UnitsInStock = SRC.UnitsInStock,
        DST.UnitsOnOrder = SRC.UnitsOnOrder,
        DST.ReorderLevel = SRC.ReorderLevel,
        DST.Discontinued = SRC.Discontinued

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
    VALUES (SRC.ProductID, SRC.ProductName, SRC.SupplierID, SRC.CategoryID, SRC.QuantityPerUnit, SRC.UnitPrice, SRC.UnitsInStock, SRC.UnitsOnOrder, SRC.ReorderLevel, SRC.Discontinued);
