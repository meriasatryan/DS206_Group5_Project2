USE ORDERS_DIMENSIONAL_DB;
GO

MERGE DimEmployees AS DST -- Destination table in the dimensional database
USING (SELECT 
           EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
           HireDate, Address, City, Region, PostalCode, Country, HomePhone, 
           Extension, Notes, ReportsTo, PhotoPath 
       FROM SourceEmployees) AS SRC -- Source table in the relational database
ON (SRC.EmployeeID = DST.EmployeeID) -- Join on the natural key

WHEN MATCHED AND (
    ISNULL(DST.LastName, '') <> ISNULL(SRC.LastName, '') OR
    ISNULL(DST.FirstName, '') <> ISNULL(SRC.FirstName, '') OR
    ISNULL(DST.Title, '') <> ISNULL(SRC.Title, '') OR
    ISNULL(DST.TitleOfCourtesy, '') <> ISNULL(SRC.TitleOfCourtesy, '') OR
    DST.BirthDate <> SRC.BirthDate OR
    DST.HireDate <> SRC.HireDate OR
    ISNULL(DST.Address, '') <> ISNULL(SRC.Address, '') OR
    ISNULL(DST.City, '') <> ISNULL(SRC.City, '') OR
    ISNULL(DST.Region, '') <> ISNULL(SRC.Region, '') OR
    ISNULL(DST.PostalCode, '') <> ISNULL(SRC.PostalCode, '') OR
    ISNULL(DST.Country, '') <> ISNULL(SRC.Country, '') OR
    ISNULL(DST.HomePhone, '') <> ISNULL(SRC.HomePhone, '') OR
    ISNULL(DST.Extension, '') <> ISNULL(SRC.Extension, '') OR
    ISNULL(DST.Notes, '') <> ISNULL(SRC.Notes, '') OR
    DST.ReportsTo <> SRC.ReportsTo OR
    ISNULL(DST.PhotoPath, '') <> ISNULL(SRC.PhotoPath, '')
) THEN
    UPDATE SET
        DST.LastName = SRC.LastName,
        DST.FirstName = SRC.FirstName,
        DST.Title = SRC.Title,
        DST.TitleOfCourtesy = SRC.TitleOfCourtesy,
        DST.BirthDate = SRC.BirthDate,
        DST.HireDate = SRC.HireDate,
        DST.Address = SRC.Address,
        DST.City = SRC.City,
        DST.Region = SRC.Region,
        DST.PostalCode = SRC.PostalCode,
        DST.Country = SRC.Country,
        DST.HomePhone = SRC.HomePhone,
        DST.Extension = SRC.Extension,
        DST.Notes = SRC.Notes,
        DST.ReportsTo = SRC.ReportsTo,
        DST.PhotoPath = SRC.PhotoPath

WHEN NOT MATCHED THEN
    INSERT (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
            HireDate, Address, City, Region, PostalCode, Country, HomePhone, 
            Extension, Notes, ReportsTo, PhotoPath)
    VALUES (SRC.EmployeeID, SRC.LastName, SRC.FirstName, SRC.Title, SRC.TitleOfCourtesy, 
            SRC.BirthDate, SRC.HireDate, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, 
            SRC.Country, SRC.HomePhone, SRC.Extension, SRC.Notes, SRC.ReportsTo, SRC.PhotoPath);
