USE ORDERS_DIMENSIONAL_DB;
GO

-- Assuming there's a source table or view 'SourceSuppliers' with the current data
MERGE DimSuppliers AS DST
USING (SELECT SupplierID, CompanyName, Phone AS NewPhone FROM SourceSuppliers) AS SRC
ON (SRC.SupplierID = DST.SupplierID)

WHEN MATCHED AND (DST.Phone <> SRC.NewPhone) THEN
    UPDATE SET
        DST.CompanyName = SRC.CompanyName,
        DST.PriorPhone = DST.Phone, -- Move current phone to prior
        DST.Phone = SRC.NewPhone

WHEN NOT MATCHED BY TARGET THEN
    INSERT (SupplierID, CompanyName, Phone, PriorPhone)
    VALUES (SRC.SupplierID, SRC.CompanyName, SRC.NewPhone, NULL);

