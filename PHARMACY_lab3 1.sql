use Pharmacy
go

CREATE TABLE DatabaseVersion(
	 Version INT NOT NULL);
GO

INSERT INTO DatabaseVersion
VALUES (3)

GO

-- Create or alter procedure
CREATE OR ALTER PROCEDURE do_1
AS
BEGIN
    -- Check if the column already exists
    IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Pharmacy' AND COLUMN_NAME = 'Rating')
    BEGIN
        -- Add the new column
        ALTER TABLE Pharmacy
        ADD Rating int;

        -- Log version
        UPDATE DatabaseVersion SET Version = 2;

        PRINT 'Column Rating added successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Column Rating already exists.';
    END
END;

EXEC do_1
GO

CREATE OR ALTER PROCEDURE undo_1  -- DELETE COLUMN
AS
BEGIN
	ALTER TABLE	Pharmacy
	DROP COLUMN Rating;

	-- Log version
	UPDATE DatabaseVersion SET Version=1;
END;

EXEC undo_1
GO
-------------------------------

CREATE OR ALTER PROCEDURE do_1_2
AS
BEGIN
    ALTER TABLE	Pharmacy
	DROP COLUMN NoOfClients  -- DELETE COLUMN

	-- Log version
	UPDATE DatabaseVersion SET Version=2;
END;

EXEC do_1
GO

CREATE OR ALTER PROCEDURE undo_1_2  
AS
BEGIN
	ALTER TABLE	Pharmacy
	ADD NoOfClients int --REVERT DELETE COLUMN

	-- Log version
	UPDATE DatabaseVersion SET Version=2;
END;

GO

EXEC undo_1_2
GO
---------------------------------------------------------

CREATE OR ALTER PROCEDURE do_2  -- ADD DEFAULT CONSTRAINT
AS
BEGIN
	ALTER TABLE Pharmacy
	ADD CONSTRAINT DF_NAME DEFAULT 'NAME' FOR NameS

	-- Log version
	UPDATE DatabaseVersion SET Version=3;
END;

GO

EXEC do_2

GO

CREATE PROCEDURE undo_2  -- DELETE DEFAULT CONSTRAINT
AS
BEGIN
	ALTER TABLE Pharmacy
	DROP CONSTRAINT DF_NAME;

	-- Log version
	UPDATE DatabaseVersion SET Version=2;
END;

GO

EXEC undo_2

GO
--------------------------------------------------------
CREATE PROCEDURE do_2_2  -- DELETE DEFAULT CONSTRAINT
AS
BEGIN
	ALTER TABLE Pharmacy
	DROP CONSTRAINT DF_Pharmacy_NameS;

	-- Log version
	UPDATE DatabaseVersion SET Version=3;
END;

GO

EXEC do_2_2

GO

CREATE OR ALTER PROCEDURE undo_2_2  -- DELETE DEFAULT CONSTRAINT
AS
BEGIN
	ALTER TABLE Pharmacy
	ADD CONSTRAINT DF_Pharmacy_NameS DEFAULT 'NAME' FOR NameS

	-- Log version
	UPDATE DatabaseVersion SET Version=2;
END;

GO

EXEC undo_2_2

GO
---------------------------------------------------------

CREATE OR ALTER PROCEDURE do_3  -- ADD TABLE
AS
BEGIN
	CREATE TABLE Sponsors 
	(
	  SponsorsID INT PRIMARY KEY IDENTITY,
	  SponsorName VARCHAR(50) NOT NULL,
	  PharmacyID INT NOT NULL
	);

	-- Log version
	UPDATE DatabaseVersion SET Version=4;
END;

GO 

EXEC do_3

GO

CREATE OR ALTER PROCEDURE undo_3  -- DELETE TABLE
AS
BEGIN
	DROP TABLE Sponsors;

	-- Log version
	UPDATE DatabaseVersion SET Version=3;
END;

GO

---------------------------------------------------------

CREATE OR ALTER  PROCEDURE do_4  -- ADD FOREIGN KEY
AS
BEGIN
	ALTER TABLE Meds
	ADD CONSTRAINT nr_Type
	FOREIGN KEY (TypeID) REFERENCES TypeOfMeds(TypeID)

	-- Log version
	UPDATE DatabaseVersion SET Version=5;
END;

GO

EXEC do_4

GO

CREATE OR ALTER PROCEDURE undo_4  -- DELETE FOREIGN KEY
AS
BEGIN
	ALTER TABLE Meds
	DROP CONSTRAINT nr_Type;

	-- Log version
	UPDATE DatabaseVersion SET Version=4;
END;

GO

EXEC undo_4

GO
---------------------------------------------------------

CREATE OR ALTER  PROCEDURE do_4_2  -- ADD FOREIGN KEY
AS
BEGIN
	ALTER TABLE Meds
	DROP CONSTRAINT nr_Type
	

	-- Log version
	UPDATE DatabaseVersion SET Version=5;
END;

GO

EXEC do_4_2

GO

CREATE OR ALTER PROCEDURE undo_4_2  -- DELETE FOREIGN KEY
AS
BEGIN
	ALTER TABLE Meds
	ADD CONSTRAINT nr_Type FOREIGN KEY (TypeID) REFERENCES TypeOfMeds(TypeID)

	-- Log version
	UPDATE DatabaseVersion SET Version=4;
END;

GO

EXEC undo_4_2

GO
-------------------------------------------------------

-- Create a stored procedure to update the database to a specific version
CREATE PROCEDURE revertToVersion @TargetVersion INT
AS
BEGIN
	DECLARE @CurrentVersion INT;

	-- Get current version
	SELECT @CurrentVersion = Version FROM DatabaseVersion;

		-- Apply each operation
		WHILE @CurrentVersion < @TargetVersion
		BEGIN 
			SELECT @CurrentVersion = Version FROM DatabaseVersion;

			IF @CurrentVersion = 1
			BEGIN
				EXEC do_1;
			END
			ELSE IF @CurrentVersion = 2
			BEGIN
				EXEC do_2;
			END
			ELSE IF @CurrentVersion = 3
			BEGIN
				EXEC do_3;
			END
			ELSE IF @CurrentVersion = 4
			BEGIN
				EXEC do_4;
			END

			-- UPDATE @CurrentVersion
		
			SELECT @CurrentVersion = Version FROM DatabaseVersion;
		END;
		WHILE @CurrentVersion > @TargetVersion
		BEGIN
			SELECT @CurrentVersion = Version FROM DatabaseVersion;
			IF @CurrentVersion = 2
			BEGIN
				EXEC undo_1;
			END
			ELSE IF @CurrentVersion = 3
			BEGIN
				EXEC undo_2;
			END
			ELSE IF @CurrentVersion = 4
			BEGIN
				EXEC undo_3;
			END
			ELSE IF @CurrentVersion = 5
			BEGIN
				EXEC undo_4;
			END
			
			SELECT @CurrentVersion = Version FROM DatabaseVersion;
		END;
END;

GO


EXEC revertToVersion 2;

SELECT * FROM DatabaseVersion

