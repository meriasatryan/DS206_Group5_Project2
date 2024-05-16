USE ORDERS_DIMENSIONAL_DB;

MERGE INTO DimCustomers AS DST
USING (SELECT CustomerID, CompanyName, ContactName, Country, ContactTitle, Address, City, Region, PostalCode, Phone, Fax FROM ORDERS_RELATIONAL_DB.dbo.Customers) AS SRC
ON (SRC.CustomerID = DST.CustomerID AND DST.ActiveFlag = 1)

WHEN MATCHED THEN
    UPDATE SET
        EndDate = GETDATE(),
        ActiveFlag = 0

WHEN NOT MATCHED BY TARGET THEN
    INSERT (CustomerID, CompanyName, ContactName, Country, ContactTitle, Address, City, Region, PostalCode, Phone, Fax, StartDate, EndDate, ActiveFlag)
    VALUES (SRC.CustomerID, SRC.CompanyName, SRC.ContactName, SRC.Country, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Phone, SRC.Fax, GETDATE(), NULL, 1);



