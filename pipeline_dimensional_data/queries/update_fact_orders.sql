-- Upsert data into FactOrders using MERGE
USE ORDERS_DIMENSIONAL_DB;
GO

MERGE INTO FactOrders AS target
USING
    (SELECT
        r.OrderID,
        dc.CustomerSK,
        de.EmployeeSK,
        r.OrderDate,
        r.RequiredDate,
        r.ShippedDate,
        ds.ShipperSK,
        r.Freight,
        dp.ProductSK,
        rd.UnitPrice,
        rd.Quantity,
        rd.Discount
     FROM Orders AS r
     JOIN OrderDetails AS rd ON r.OrderID = rd.OrderID
     JOIN DimCustomers AS dc ON r.CustomerID = dc.CustomerID
     JOIN DimEmployees AS de ON r.EmployeeID = de.EmployeeID
     JOIN DimShippers AS ds ON r.ShipVia = ds.ShipperID
     JOIN DimProducts AS dp ON rd.ProductID = dp.ProductID
    ) AS source
ON (target.OrderID = source.OrderID AND target.ProductSK = source.ProductSK)
WHEN MATCHED THEN
    UPDATE SET
        target.CustomerSK = source.CustomerSK,
        target.EmployeeSK = source.EmployeeSK,
        target.OrderDate = source.OrderDate,
        target.RequiredDate = source.RequiredDate,
        target.ShippedDate = source.ShippedDate,
        target.ShipperSK = source.ShipperSK,
        target.Freight = source.Freight,
        target.UnitPrice = source.UnitPrice,
        target.Quantity = source.Quantity,
        target.Discount = source.Discount
WHEN NOT MATCHED BY TARGET THEN
    INSERT (OrderID, CustomerSK, EmployeeSK, OrderDate, RequiredDate, ShippedDate, ShipperSK, Freight, ProductSK, UnitPrice, Quantity, Discount)
    VALUES (source.OrderID, source.CustomerSK, source.EmployeeSK, source.OrderDate, source.RequiredDate, source.ShippedDate, source.ShipperSK, source.Freight, source.ProductSK, source.UnitPrice, source.Quantity, source.Discount);
