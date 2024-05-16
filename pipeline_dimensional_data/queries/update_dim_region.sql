USE ORDERS_DIMENSIONAL_DB;

MERGE INTO DimRegion AS DST
USING (SELECT RegionID, RegionDescription FROM ORDERS_RELATIONAL_DB.dbo.Region) AS SRC
ON (SRC.RegionID = DST.RegionID AND DST.IsCurrent = 1)

WHEN MATCHED THEN
    UPDATE SET
        ValidTo = GETDATE(),
        IsCurrent = 0

WHEN NOT MATCHED BY TARGET THEN
    INSERT (RegionID, RegionDescription, ValidFrom, ValidTo, IsCurrent)
    VALUES (SRC.RegionID, SRC.RegionDescription, GETDATE(), NULL, 1);


