USE ORDERS_DIMENSIONAL_DB;

MERGE INTO DimProducts AS DST
USING (SELECT ProductID, ProductName, SupplierID, CategoryID, UnitPrice FROM ORDERS_RELATIONAL_DB.dbo.Products) AS SRC
ON (SRC.ProductID = DST.ProductID AND DST.ActiveFlag = 1)

WHEN MATCHED THEN
    UPDATE SET
        EndDate = GETDATE(),
        ActiveFlag = 0

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, SupplierID, CategoryID, UnitPrice, StartDate, EndDate, ActiveFlag)
    VALUES (SRC.ProductID, SRC.ProductName, SRC.SupplierID, SRC.CategoryID, SRC.UnitPrice, GETDATE(), NULL, 1);
