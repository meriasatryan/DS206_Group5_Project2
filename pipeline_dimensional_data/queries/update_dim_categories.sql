USE ORDERS_DIMENSIONAL_DB;

MERGE INTO DimCategories AS DST
USING (SELECT CategoryID, CategoryName, Description FROM ORDERS_RELATIONAL_DB.dbo.Categories) AS SRC
ON (SRC.CategoryID = DST.CategoryID)

WHEN MATCHED THEN
    UPDATE SET
        CategoryName = SRC.CategoryName,
        Description = SRC.Description

WHEN NOT MATCHED BY TARGET THEN
    INSERT (CategoryID, CategoryName, Description)
    VALUES (SRC.CategoryID, SRC.CategoryName, SRC.Description);

