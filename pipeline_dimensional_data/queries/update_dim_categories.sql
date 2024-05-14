USE ORDERS_DIMENSIONAL_DB;
GO

MERGE DimCategories AS DST
USING (SELECT CategoryID, CategoryName, Description FROM SourceCategories) AS SRC
ON (SRC.CategoryID = DST.CategoryID)

WHEN MATCHED THEN
    UPDATE SET
        DST.CategoryName = SRC.CategoryName,
        DST.Description = SRC.Description

WHEN NOT MATCHED BY TARGET THEN
    INSERT (CategoryID, CategoryName, Description)
    VALUES (SRC.CategoryID, SRC.CategoryName, SRC.Description)

-- Optional: Handle deletions if relevant to SCD Type 1 in this context
-- WHEN NOT MATCHED BY SOURCE THEN
--     DELETE;
