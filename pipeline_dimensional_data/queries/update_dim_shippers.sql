-- USE ORDERS_DIMENSIONAL_DB;

-- ALTER TABLE DimShippers ADD StartDate DATE, CurrentPhone VARCHAR(255), PriorPhone VARCHAR(255), EndDate DATE, IsCurrent BIT DEFAULT 1;

-- MERGE INTO DimShippers AS DST
-- USING (SELECT ShipperID, CompanyName, Phone FROM ORDERS_RELATIONAL_DB.dbo.Shippers) AS SRC
-- ON (SRC.ShipperID = DST.ShipperID)

-- WHEN MATCHED THEN
--     UPDATE SET
--         CurrentPhone = SRC.Phone,
--         PriorPhone = DST.CurrentPhone

-- WHEN NOT MATCHED BY TARGET THEN
--     INSERT (ShipperID, CompanyName, CurrentPhone, PriorPhone, StartDate, EndDate, IsCurrent)
--     VALUES (SRC.ShipperID, SRC.CompanyName, SRC.Phone, NULL, GETDATE(), NULL, 1);

-- Alter the table to add necessary columns

-- MERGE statement
MERGE INTO DimShippers AS DST
USING (SELECT ShipperID, CompanyName, Phone FROM ORDERS_RELATIONAL_DB.dbo.Shippers) AS SRC
ON (SRC.ShipperID = DST.ShipperID)

WHEN MATCHED THEN
    UPDATE SET
        CurrentPhone = SRC.Phone,
        PriorPhone = DST.CurrentPhone

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ShipperID, CompanyName, CurrentPhone, PriorPhone, StartDate, EndDate, IsCurrent)
    VALUES (SRC.ShipperID, SRC.CompanyName, SRC.Phone, NULL, GETDATE(), NULL, 1);
