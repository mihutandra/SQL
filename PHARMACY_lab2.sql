
use Pharmacy
go

CREATE TABLE Pharmacy
(	PharmacyID INT PRIMARY KEY IDENTITY,
	NameS varchar(50),
	City varchar(50) NOT NULL,
	NoOfShops int,
	NoOfClients int
)


CREATE TABLE Clients
(	ClientID INT PRIMARY KEY IDENTITY,
	NameC varchar(20) NOT NULL,
	SurnameC varchar(20) NOT NULL,
	YearOfBirth int,
	PharmacyID INT, -- Foreign key referencing Pharmacies ; 1 Pharma - M Clients
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID)

)


CREATE TABLE Suppliers
(	SupplierID INT PRIMARY KEY,
	NameSuppliers varchar(30) NOT NULL,
	PhoneNr varchar(15)
)


CREATE TABLE TypeOfMeds (
    TypeID INT PRIMARY KEY,
    TypeName VARCHAR(50)
)


CREATE TABLE Meds
(	MedID INT PRIMARY KEY IDENTITY,
	TypeID INT,
	MedDescription varchar(30),
	Quantity int,
	FOREIGN KEY (TypeID) REFERENCES TypeOfMeds(TypeID)
)

CREATE TABLE Brand (
    BrandID INT PRIMARY KEY,
    BrandName VARCHAR(50)
)


CREATE TABLE MedsBrand (
    MedID INT AUTO_INCREMENT,
    BrandID INT,
    PRIMARY KEY (MedID, BrandID), -- a medication belongs to multiple brands
    FOREIGN KEY (MedID) REFERENCES Meds(MedID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
)

CREATE TABLE Inventory (
    MedID INT,
    PharmacyID INT,
    Quantity INT,
    ExpiryDate DATE,
    PRIMARY KEY (MedID, PharmacyID), -- Define the composite primary key here
    FOREIGN KEY (MedID) REFERENCES Meds(MedID),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID)
)

CREATE TABLE PharmacySupplier ( -- M-N relationship, a pharma has more suppliers and a supplier has more pharmas to supply
    PharmacyID INT,
    SupplierID INT,
    PRIMARY KEY (PharmacyID, SupplierID),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
)

-- PHARMACY INSERTION
INSERT INTO Pharmacy(PharmacyID, City, NoOfShops, NoOfClients) VALUES(1,'Pharmacy1', 'City1', 5, 100);
INSERT INTO Pharmacy(PharmacyID,NameS, City, NoOfShops, NoOfClients) VALUES(2,'Pharmacy2', 'City2', 3, 50);
INSERT INTO Pharmacy(PharmacyID,NameS, City, NoOfShops, NoOfClients) VALUES(3,'Pharmacy3', 'City3', 5, 100);
INSERT INTO Pharmacy(PharmacyID,NameS, City, NoOfShops, NoOfClients) VALUES(4,'Pharmacy4', 'City1', 3, 50);
INSERT INTO Pharmacy (PharmacyID,NameS, City, NoOfShops, NoOfClients) VALUES (5,'Pharmacy5', 'City2', 3, 100);
INSERT INTO Pharmacy (PharmacyID,NameS, City, NoOfShops, NoOfClients) VALUES (6,'Pharmacy6', 'City3', 2, 50);
INSERT INTO Pharmacy (PharmacyID,NameS, City, NoOfShops, NoOfClients) VALUES (7,'Pharmacy7', 'City3', 4, 80);
INSERT INTO Pharmacy (PharmacyID,NameS, City, NoOfShops, NoOfClients) VALUES (8,'Pharmacy8', 'City4', 2, 120);
INSERT INTO Pharmacy (PharmacyID,NameS, City, NoOfShops, NoOfClients) VALUES (9,'Pharmacy9', 'City3', 4, 80);

-- CLIENTS INSERTION
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('John', 'Doe', 1995, 1);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Alice', 'Johnson', 1990, 2);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Alice', 'Robinson', 1990, 2);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Bob', 'Smith', 1988, 1);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Angela', 'Smith', 1995, 1);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Emma', 'Williams', 1998, 3);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Emma', 'Doe', 1998, 3);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Michael', 'Brown', 2000, 4);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Michael', 'Bayern', 2000, 4);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Mike', 'Brown', 2000, 4);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Sarah', 'Adams', 1992, 2);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('David', 'Wilson', 1985, 1);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Linda', 'Miller', 1991, 3);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('David', 'Wilson', 1985, 5);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('David', 'Mayer', 1985, 5);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Linda', 'Miller', 1991, 6);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Zoe', 'Brown', 1991, 6);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Dwayne', 'Wilson', 1985, 7);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Rori', 'Dove', 1985, 7);
INSERT INTO Clients (NameC, SurnameC, YearOfBirth, PharmacyID) VALUES ('Lili', 'Miller', 1991, 8);

-- SUPPLIERS INSERTION
INSERT INTO Suppliers (SupplierID, NameSuppliers, PhoneNr) VALUES (1, 'Supplier1', '123-456-7890');
INSERT INTO Suppliers (SupplierID, NameSuppliers, PhoneNr) VALUES (2, 'Supplier2', '987-654-3210');
INSERT INTO Suppliers (SupplierID, NameSuppliers, PhoneNr) VALUES (3, 'Supplier3', '555-123-4567');
INSERT INTO Suppliers (SupplierID, NameSuppliers, PhoneNr) VALUES (4, 'Supplier4', '221-456-7890');
INSERT INTO Suppliers (SupplierID, NameSuppliers, PhoneNr) VALUES (5, 'Supplier5', '987-654-3210');
INSERT INTO Suppliers (SupplierID, NameSuppliers, PhoneNr) VALUES (6, 'Supplier6', '555-111-4447');
INSERT INTO Suppliers (SupplierID, NameSuppliers, PhoneNr) VALUES (7, 'Supplier7', '312-456-7890');

-- TYPEOFMEDS INSERTION
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (1, 'Liquid');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (2, 'Tablet');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (3, 'Capsule');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (4, 'Topical');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (5, 'Drops');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (6, 'Injections');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (7, 'Implants');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (8, 'Patches');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (9, 'Sublingual');
INSERT INTO TypeOfMeds (TypeID, TypeName) VALUES (10, 'Inhalers');

-- MEDS INSERTION
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (1, 'Med1', 100);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (2, 'Med2', 50);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (3, 'Med3', 200);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (1, 'Med4', 100);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (2, 'Med5', 50);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (3, 'Med6', 220);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (4, 'Med7', 100);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (6, 'Med8', 50);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (6, 'Med9', 200);
INSERT INTO Meds (TypeID, MedDescription, Quantity) VALUES (4, 'Med710', 55);

-- BRAND INSERTIONS
INSERT INTO Brand (BrandID, BrandName) VALUES (1, 'Brand1');
INSERT INTO Brand (BrandID, BrandName) VALUES (2, 'Brand2');
INSERT INTO Brand (BrandID, BrandName) VALUES (3, 'Brand3');
INSERT INTO Brand (BrandID, BrandName) VALUES (4, 'Brand4');
INSERT INTO Brand (BrandID, BrandName) VALUES (5, 'Brand5');
INSERT INTO Brand (BrandID, BrandName) VALUES (6, 'Brand6');

-- MEDSBRAND INSERTION
INSERT INTO MedsBrand (MedID, BrandID) VALUES (1, 1);
INSERT INTO MedsBrand (MedID, BrandID) VALUES (2, 4);
INSERT INTO MedsBrand (MedID, BrandID) VALUES (3, 1);
INSERT INTO MedsBrand (MedID, BrandID) VALUES (4, 5);
INSERT INTO MedsBrand (MedID, BrandID) VALUES (5, 4);
INSERT INTO MedsBrand (MedID, BrandID) VALUES (6, 2);
INSERT INTO MedsBrand (MedID, BrandID) VALUES (7, 2);
INSERT INTO MedsBrand (MedID, BrandID) VALUES (8, 3);

-- INVENTORY INSERTION
INSERT INTO Inventory (MedID, PharmacyID, Quantity, ExpiryDate) VALUES (1, 1, 50, '2024-12-31');
INSERT INTO Inventory (MedID, PharmacyID, Quantity, ExpiryDate) VALUES (2, 2, 30, '2025-05-15');
INSERT INTO Inventory (MedID, PharmacyID, Quantity, ExpiryDate) VALUES (3, 1, 75, '2023-10-20');
INSERT INTO Inventory (MedID, PharmacyID, Quantity, ExpiryDate) VALUES (1, 4, 50, '2024-12-31');
INSERT INTO Inventory (MedID, PharmacyID, Quantity, ExpiryDate) VALUES (2, 5, 30, '2025-05-15');
INSERT INTO Inventory (MedID, PharmacyID, Quantity, ExpiryDate) VALUES (3, 6, 75, '2023-10-20');

-- PHARMACY SUPPLIER INSERTION
INSERT INTO PharmacySupplier (PharmacyID, SupplierID) VALUES (1, 1);
INSERT INTO PharmacySupplier (PharmacyID, SupplierID) VALUES (2, 1);
INSERT INTO PharmacySupplier (PharmacyID, SupplierID) VALUES (3, 2);
INSERT INTO PharmacySupplier (PharmacyID, SupplierID) VALUES (4, 2);
INSERT INTO PharmacySupplier (PharmacyID, SupplierID) VALUES (5, 3);
INSERT INTO PharmacySupplier (PharmacyID, SupplierID) VALUES (6, 6);
INSERT INTO PharmacySupplier (PharmacyID, SupplierID) VALUES (7, 3);

-- DELETE
DELETE FROM Clients
WHERE NameC = 'John';

DELETE FROM Clients
WHERE YearOfBirth=2000 AND SurnameC = 'Bayern';

--UPDATE
UPDATE Clients
SET SurnameC = 'David'
WHERE ClientID = 1;

UPDATE Pharmacy
SET NoOfClients = 150
WHERE PharmacyID = 2;

-----------------------------------------
-- a)
-- Retrieve the names of clients and pharmacies and combine them   - UNION
SELECT NameC FROM Clients
UNION
SELECT NameS FROM Pharmacy;

-- Find common PharmacyID and NoOfShops							  - INTERSECTION
SELECT PharmacyID FROM Clients
INTERSECT
SELECT NoOfShops FROM Pharmacy;

-- Find clients who are not in a specific city					  - EXCEPT
SELECT NameC FROM Clients
EXCEPT
SELECT NameS FROM Pharmacy WHERE City = 'City1';

-----------------------------------------
-- b)
-- Retrieve clients and their associated pharmacies				  - INNER JOIN
SELECT C.NameC AS ClientName, P.NameS AS PharmacyName
FROM Clients C
INNER JOIN Pharmacy P ON C.PharmacyID = P.PharmacyID;

-- Retrieve clients and their associated pharmacies				  - LEFT JOIN
SELECT C.NameC AS ClientName, P.NameS AS PharmacyName
FROM Clients C
LEFT JOIN Pharmacy P ON C.PharmacyID = P.PharmacyID;

-- Retrieve pharmacies and their associated suppliers			  - RIGHT JOIN
SELECT P.NameS AS PharmacyName, S.NameSuppliers AS SupplierName
FROM Pharmacy P
RIGHT JOIN Suppliers S ON P.PharmacyID = S.SupplierID;

-- Retrieve medications and their associated types of medications - FULL JOIN
SELECT M.MedDescription, T.TypeName
FROM Meds M
FULL JOIN TypeOfMeds T ON M.TypeID = T.TypeID;

-----------------------------------------
-- c)
-- Retrieve client names(beginning with M) who have associations with pharmacies        - IN
SELECT NameC
FROM Clients
WHERE ClientID IN (SELECT ClientID FROM Pharmacy) AND NameC LIKE 'M%';


-- Retrieve medication names that have associated med type                              - EXISTS
SELECT M.MedDescription
FROM Meds M
WHERE Quantity>=100 AND EXISTS (SELECT 1 FROM TypeOfMeds T WHERE T.TypeID = M.TypeID);

------------------------------------------
-- D)
SELECT DISTINCT M.MedDescription, SUM(I.Quantity) AS TotalQuantity
FROM Meds M
JOIN MedsBrand MB ON M.MedID = MB.MedID
JOIN Inventory I ON MB.MedID = I.MedID
WHERE M.MedDescription LIKE 'Med1'
GROUP BY M.MedDescription
ORDER BY TotalQuantity ASC;						-- ASC



SELECT M.TypeID, AVG(M.Quantity) AS AvgQuantity
FROM Meds M
GROUP BY M.TypeID 
HAVING AVG(M.Quantity) > 50
ORDER BY AvgQuantity DESC;						-- DESC

SELECT P.PharmacyID, COUNT(C.ClientID) AS ClientCount
FROM Pharmacy P
LEFT JOIN Clients C ON P.PharmacyID = C.PharmacyID
GROUP BY P.PharmacyID
HAVING COUNT(C.ClientID) > (SELECT AVG(ClientCount) FROM (SELECT P2.PharmacyID, COUNT(C2.ClientID) AS ClientCount
                                                               FROM Pharmacy P2
                                                               LEFT JOIN Clients C2 ON P2.PharmacyID = C2.PharmacyID
                                                               GROUP BY P2.PharmacyID) AS Subquery);

SELECT TOP 3 NameS as Name, NoOfClients as NumberClients from  Pharmacy;															  