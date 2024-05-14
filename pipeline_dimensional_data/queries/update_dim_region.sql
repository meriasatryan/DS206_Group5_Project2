USE ORDERS_DIMENSIONAL_DB;
GO

-- This assumes there is a source table or view called 'SourceRegion' where updated data comes from
MERGE INTO DimRegion AS DST
USING (SELECT RegionID, RegionDescription FROM SourceRegion) AS SRC
ON (SRC.RegionID = DST.RegionID AND DST.IsCurrent = 1)

WHEN MATCHED THEN
    -- Close the current record
    UPDATE SET
        DST.ValidTo = GETDATE(),
        DST.IsCurrent = 0

WHEN NOT MATCHED BY TARGET THEN
    -- Insert new record if no current version exists
    INSERT (RegionID, RegionDescription, ValidFrom, ValidTo, IsCurrent)
    VALUES (SRC.RegionID, SRC.RegionDescription, GETDATE(), '9999-12-31', 1);

-- Insert the new current record for existing regions
INSERT INTO DimRegion (RegionID, RegionDescription, ValidFrom, ValidTo, IsCurrent)
SELECT SRC.RegionID, SRC.RegionDescription, GETDATE(), '9999-12-31', 1
FROM SourceRegion AS SRC
WHERE EXISTS (
    SELECT 1
    FROM DimRegion AS DST
    WHERE DST.RegionID = SRC.RegionID AND DST.IsCurrent = 0
);

