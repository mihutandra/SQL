use Pharmacy
go

-- a)

--  user-defined function for parameter validation
CREATE FUNCTION dbo.IsValidYearOfBirth(@YearOfBirth int)
RETURNS bit
AS
BEGIN
    DECLARE @CurrentYear int = YEAR(GETDATE());

    -- Validate that the year of birth is within a reasonable range
    RETURN CASE WHEN @YearOfBirth BETWEEN 1900 AND @CurrentYear THEN 1 ELSE 0 END;
END;


--  stored procedure for INSERT operation on Pharmacy and Clients tables
CREATE OR ALTER PROCEDURE InsertPharmacyAndClient
    @PharmacyName varchar(50),
    @City varchar(50),
    @NoOfShops int,
    @NoOfClients int,
    @ClientName varchar(20),
    @ClientSurname varchar(20),
    @YearOfBirth int
AS
BEGIN
    -- Check if the year of birth is valid using the user-defined function
    IF dbo.IsValidYearOfBirth(@YearOfBirth) = 0
    BEGIN
        PRINT 'Invalid Year of Birth. Please provide a valid year.';
        RETURN;
    END

    -- Insert into Pharmacy table
    INSERT INTO Pharmacy (NameS, City, NoOfShops, NoOfClients)
    VALUES (@PharmacyName, @City, @NoOfShops, @NoOfClients);

    -- Get the generated PharmacyID
    DECLARE @PharmacyID INT = SCOPE_IDENTITY();

    -- Insert into Clients table with a reference to the Pharmacy
    INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID)
    VALUES (@ClientName, @ClientSurname, @YearOfBirth, @PharmacyID);

    PRINT 'Insert operation completed successfully.';
END;

EXEC InsertPharmacyAndClient
    @PharmacyName = 'Pharmacy1',
    @City = 'City2',
    @NoOfShops = 3,
    @NoOfClients = 10,
    @ClientName = 'John',
    @ClientSurname = 'Doe',
    @YearOfBirth = 1990;

	-- Query the Pharmacy and Clients tables to verify the data
SELECT * FROM Pharmacy;
SELECT * FROM Clients;
GO

-- b)
-- Create a view that extracts data from Pharmacy, Clients, and Inventory tables
-- The view will join these tables to provide useful information about clients and the medications available in a pharmacy.
CREATE VIEW PharmacyClientInventoryView
AS
SELECT
    P.PharmacyID,
    P.NameS AS PharmacyName,
    P.City,
    C.ClientID,
    C.NameC AS ClientName,
    C.SurnameC AS ClientSurname,
    C.YearOfBirth,
    I.MedID,
    M.MedDescription,
    I.Quantity AS InventoryQuantity,
    I.ExpiryDate
FROM
    Pharmacy P
JOIN
    Clients C ON P.PharmacyID = C.PharmacyID
LEFT JOIN
    Inventory I ON P.PharmacyID = I.PharmacyID
LEFT JOIN
    Meds M ON I.MedID = M.MedID;

	-- SELECT query on the view to return useful information
SELECT
    PharmacyID,
    PharmacyName,
    City,
    ClientID,
    ClientName,
    ClientSurname,
    YearOfBirth,
    MedID,
    MedDescription,
    InventoryQuantity,
    ExpiryDate
FROM
    PharmacyClientInventoryView;


-- c)
CREATE TABLE ChangeLog (
    ChangeLogID INT PRIMARY KEY IDENTITY, -- Auto-incremented identifier for each log entry
    ChangeDate DATETIME, --Date and time of the change.
    TriggerType NVARCHAR(10), --Indicates whether the change was an INSERT, UPDATE, or DELETE.
    TableName VARCHAR(50), --The name of the table where the change occurred.
    RecordsCount INT -- Number of records affected by the change.
);
GO
-- Create or alter the trigger
CREATE TRIGGER LogChanges
ON Pharmacy
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @TriggerType VARCHAR(10);

    -- Determine the trigger type
    IF EXISTS (SELECT * FROM inserted) 
    BEGIN
        IF EXISTS (SELECT * FROM deleted)
            SET @TriggerType = 'UPDATE';
        ELSE
            SET @TriggerType = 'INSERT';
    END
    ELSE
 
        SET @TriggerType = 'DELETE';
	
	DECLARE @RecordsCount INT;

	IF @TriggerType = 'UPDATE'
        SET @RecordsCount = (SELECT COUNT(*) FROM inserted);
    ELSE
        SET @RecordsCount = (SELECT ISNULL(COUNT(*), 0) FROM inserted) + (SELECT ISNULL(COUNT(*), 0) FROM deleted);

    

    -- Insert into the log table
    INSERT INTO ChangeLog (ChangeDate, TriggerType, TableName, RecordsCount)
    VALUES (GETDATE(), @TriggerType,'Pharmacy', @RecordsCount);
END;

UPDATE Pharmacy
SET NameS = NameS
WHERE NoOfShops >= 100

GO --This triggers the LogChanges trigger, and a log entry is added to the ChangeLog table.

SELECT * FROM ChangeLog

GO 

DELETE FROM Pharmacy
WHERE PharmacyID = 1

GO

DELETE FROM Clients
WHERE PharmacyID = 1

GO


--d)
-- Create a query with a clustered index seek and a nonclustered index scan
-- Sample Query with JOINs and WHERE conditions
SELECT
    P.NameS AS PharmacyName,
    C.NameC AS ClientName,
    M.MedDescription,
    B.BrandName,
    I.Quantity
FROM
    Pharmacy P
JOIN
    Clients C ON P.PharmacyID = C.PharmacyID
JOIN
    Inventory I ON P.PharmacyID = I.PharmacyID
JOIN
    Meds M ON I.MedID = M.MedID
JOIN
    MedsBrand MB ON M.MedID = MB.MedID
JOIN
    Brand B ON MB.BrandID = B.BrandID
WHERE
    P.City = 'City3'  
    AND C.YearOfBirth > 1990
    AND M.Quantity > 50
ORDER BY
    P.NameS, C.NameC, M.MedDescription;

 
