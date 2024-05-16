USE ORDERS_DIMENSIONAL_DB;

-- Perform the MERGE operation
MERGE INTO DimTerritories AS DST
USING (
    SELECT TerritoryID, TerritoryDescription, RegionID
    FROM ORDERS_RELATIONAL_DB.dbo.Territories
) AS SRC
ON (SRC.TerritoryID = DST.TerritoryID AND DST.IsCurrent = 1)

-- Insert new current records for changed territories
WHEN NOT MATCHED BY TARGET THEN
    INSERT (TerritoryID, TerritoryDescription, RegionID, ValidFrom, ValidTo, IsCurrent)
    VALUES (SRC.TerritoryID, SRC.TerritoryDescription, SRC.RegionID, GETDATE(), '9999-12-31', 1)

-- Update existing records to set them as not current
WHEN MATCHED AND (DST.TerritoryDescription <> SRC.TerritoryDescription OR DST.RegionID <> SRC.RegionID) THEN
    UPDATE SET
        DST.ValidTo = GETDATE(),
        DST.IsCurrent = 0;
