USE ORDERS_DIMENSIONAL_DB;
GO

-- Assuming there's a source table or view 'SourceTerritories' with the current data
MERGE DimTerritories AS DST
USING (
    SELECT TerritoryID, TerritoryDescription, RegionID
    FROM SourceTerritories
) AS SRC
ON (SRC.TerritoryID = DST.TerritoryID AND DST.IsCurrent = 1)

WHEN MATCHED AND (DST.TerritoryDescription <> SRC.TerritoryDescription OR DST.RegionID <> SRC.RegionID) THEN
    UPDATE SET
        DST.ValidTo = GETDATE(),
        DST.IsCurrent = 0

WHEN NOT MATCHED BY TARGET THEN
    INSERT (TerritoryID, TerritoryDescription, RegionID, ValidFrom, ValidTo, IsCurrent)
    VALUES (SRC.TerritoryID, SRC.TerritoryDescription, SRC.RegionID, GETDATE(), '9999-12-31', 1);

-- Insert new current records for changed territories
WHEN NOT MATCHED BY SOURCE AND DST.IsCurrent = 1 THEN
    INSERT INTO DimTerritories
    (TerritoryID, TerritoryDescription, RegionID, ValidFrom, ValidTo, IsCurrent)
    VALUES
    (DST.TerritoryID, SRC.TerritoryDescription, SRC.RegionID, GETDATE(), '9999-12-31', 1);
