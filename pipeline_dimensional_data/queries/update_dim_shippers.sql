USE ORDERS_DIMENSIONAL_DB;
GO

-- Assuming there's a source table or view 'SourceShippers' with updated data
MERGE DimShippers AS DST
USING (SELECT ShipperID, CompanyName, Phone AS NewPhone FROM SourceShippers) AS SRC
ON (SRC.ShipperID = DST.ShipperID)

WHEN MATCHED AND (DST.Phone <> SRC.NewPhone) THEN
    UPDATE SET
        DST.CompanyName = SRC.CompanyName,
        DST.PriorPhone = DST.Phone, -- Move current phone to prior
        DST.Phone = SRC.NewPhone

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ShipperID, CompanyName, Phone, PriorPhone)
    VALUES (SRC.ShipperID, SRC.CompanyName, SRC.NewPhone, NULL);

