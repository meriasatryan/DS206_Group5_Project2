USE ORDERS_DIMENSIONAL_DB;

-- Insert data into FactOrders
INSERT INTO FactOrders (OrderID, CustomerSK, EmployeeSK, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry, TerritorySK)
SELECT 
    O.OrderID,
    DC.CustomerSK,
    DE.EmployeeSK,
    O.OrderDate,
    O.RequiredDate,
    O.ShippedDate,
    O.ShipVia,
    O.Freight,
    O.ShipName,
    O.ShipAddress,
    O.ShipCity,
    O.ShipRegion,
    O.ShipPostalCode,
    O.ShipCountry,
    DT.TerritorySK
FROM 
    ORDERS_RELATIONAL_DB.dbo.Orders AS O
    LEFT JOIN DimCustomers AS DC ON O.CustomerID = DC.CustomerID
    LEFT JOIN DimEmployees AS DE ON O.EmployeeID = DE.EmployeeID
    LEFT JOIN DimTerritories AS DT ON O.TerritoryID = DT.TerritoryID;

