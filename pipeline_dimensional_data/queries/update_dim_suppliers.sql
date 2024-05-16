USE ORDERS_DIMENSIONAL_DB;
-- Perform the MERGE operation
MERGE INTO DimSuppliers AS DST
USING (
    SELECT SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage
    FROM ORDERS_RELATIONAL_DB.dbo.Suppliers
) AS SRC
ON (SRC.SupplierID = DST.SupplierID)

WHEN MATCHED THEN
    UPDATE SET
        CompanyName = SRC.CompanyName,
        ContactName = SRC.ContactName,
        ContactTitle = SRC.ContactTitle,
        Address = SRC.Address,
        City = SRC.City,
        Region = SRC.Region,
        PostalCode = SRC.PostalCode,
        Country = SRC.Country,
        Phone = SRC.Phone,
        PriorPhone = DST.Phone,  -- SCD Type 3 logic: Update prior phone
        Fax = SRC.Fax,
        HomePage = SRC.HomePage

WHEN NOT MATCHED BY TARGET THEN
    INSERT (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, PriorPhone, Fax, HomePage, StartDate, EndDate, IsCurrent)
    VALUES (SRC.SupplierID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, NULL, SRC.Fax, SRC.HomePage, GETDATE(), NULL, 1);