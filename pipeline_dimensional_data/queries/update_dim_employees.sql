USE ORDERS_DIMENSIONAL_DB;

MERGE INTO DimEmployees AS DST
USING (SELECT EmployeeID, LastName, FirstName, BirthDate FROM ORDERS_RELATIONAL_DB.dbo.Employees) AS SRC
ON (SRC.EmployeeID = DST.EmployeeID)

WHEN MATCHED THEN
    UPDATE SET
        LastName = SRC.LastName,
        FirstName = SRC.FirstName,
        BirthDate = SRC.BirthDate

WHEN NOT MATCHED BY TARGET THEN
    INSERT (EmployeeID, LastName, FirstName, BirthDate)
    VALUES (SRC.EmployeeID, SRC.LastName, SRC.FirstName, SRC.BirthDate);

