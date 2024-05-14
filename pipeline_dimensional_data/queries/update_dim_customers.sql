USE ORDERS_DIMENSIONAL_DB;
GO

-- Assuming DimCustomersHistory is the history table
BEGIN TRANSACTION;

-- Insert new changes into the history table
INSERT INTO DimCustomersHistory (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, EffectiveDate, IsCurrent)
SELECT SRC.CustomerID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax, GETDATE(), 1
FROM IncomingCustomerData AS SRC
JOIN DimCustomers AS DST ON SRC.CustomerID = DST.CustomerID
WHERE NOT (
    SRC.CompanyName = DST.CompanyName AND
    SRC.ContactName = DST.ContactName AND
    SRC.ContactTitle = DST.ContactTitle AND
    SRC.Address = DST.Address AND
    SRC.City = DST.City AND
    SRC.Region = DST.Region AND
    SRC.PostalCode = DST.PostalCode AND
    SRC.Country = DST.Country AND
    SRC.Phone = DST.Phone AND
    SRC.Fax = DST.Fax
);

-- Update the current flag for old records
UPDATE DimCustomersHistory
SET IsCurrent = 0
WHERE CustomerID IN (
    SELECT CustomerID FROM DimCustomersHistory WHERE IsCurrent = 1
)
AND EffectiveDate <> (SELECT MAX(EffectiveDate) FROM DimCustomersHistory WHERE CustomerID = DimCustomersHistory.CustomerID);

-- Update or Insert into the main table
MERGE DimCustomers AS DST
USING IncomingCustomerData AS SRC
ON (DST.CustomerID = SRC.CustomerID)
WHEN MATCHED THEN
    UPDATE SET
        DST.CompanyName = SRC.CompanyName,
        DST.ContactName = SRC.ContactName,
        DST.ContactTitle = SRC.ContactTitle,
        DST.Address = SRC.Address,
        DST.City = SRC.City,
        DST.Region = SRC.Region,
        DST.PostalCode = SRC.PostalCode,
        DST.Country = SRC.Country,
        DST.Phone = SRC.Phone,
        DST.Fax = SRC.Fax
WHEN NOT MATCHED THEN
    INSERT (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
    VALUES (SRC.CustomerID, SRC.CompanyName, SRC.ContactName, SRC.ContactTitle, SRC.Address, SRC.City, SRC.Region, SRC.PostalCode, SRC.Country, SRC.Phone, SRC.Fax);

COMMIT TRANSACTION;
