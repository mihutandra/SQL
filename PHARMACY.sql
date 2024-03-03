CREATE database Pharmacy
go
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
	MedDescription TEXT,
	Quantity int,
	FOREIGN KEY (TypeID) REFERENCES TypeOfMeds(TypeID)
)

CREATE TABLE Brand (
    BrandID INT PRIMARY KEY,
    BrandName VARCHAR(50)
)


CREATE TABLE MedsBrand (
    MedID INT,
    BrandID INT,
    PRIMARY KEY (MedID, BrandID), -- a medication belongs to multiple brands
    FOREIGN KEY (MedID) REFERENCES Meds(MedID),
    FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
)

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY,
    MedID INT,
	PharmacyID INT,
    Quantity INT,
    ExpiryDate DATE,
    FOREIGN KEY (MedID) REFERENCES Meds(MedID),
	FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID)
)

CREATE TABLE PharmacySupplier ( -- M-N relationship, a pharma has more suppliers and a supplier has more pharmas to supply
    PharmacyID INT,
    SupplierID INT,
    PRIMARY KEY (PharmacyID, SupplierID),
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacy(PharmacyID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
)
