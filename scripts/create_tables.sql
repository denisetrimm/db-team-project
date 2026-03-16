-- Use the MovinOn_TeamNo database
USE MovinOn_TeamNo;

-- Create the database tables per Figure 2.1 in the project description.
-- Create the Customers table
CREATE TABLE customers (
    CustID INT PRIMARY KEY,
    CompanyName VARCHAR(50), -- Can be null for individual customers
    ContactFirst VARCHAR(30) NOT NULL,
    ContactLast VARCHAR(30) NOT NULL,
    Address VARCHAR(40) NOT NULL,
    City VARCHAR(30) NOT NULL,
    State VARCHAR(2) NOT NULL, -- State (2-letter code)
    ZIP VARCHAR(10) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Balance DECIMAL(19,4) DEFAULT 0 CHECK (Balance >= 0) -- Account Balance - must be non-negative, default to 0
);

-- Create the Warehouses table
CREATE TABLE warehouses (
    WarehouseID VARCHAR(5) PRIMARY KEY,
    Address VARCHAR(40) NOT NULL,
    City VARCHAR(30) NOT NULL,
    State VARCHAR(2) NOT NULL, -- State (2-letter code)
    ZIP VARCHAR(10) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    ClimateControl TINYINT NOT NULL CHECK (ClimateControl IN (0,1)), -- Climate Control (0=No, 1=Yes)
    SecurityGate TINYINT NOT NULL CHECK (SecurityGate IN (0,1)) -- Security Gate (0=No, 1=Yes)
);

-- Create the Unit Rentals table
CREATE TABLE unitrentals (
    UnitID INT NOT NULL,
    CustID INT NOT NULL, -- FK Customer ID
    WarehouseID VARCHAR(5) NOT NULL, -- FK Warehouse ID
    DateIn DATETIME NOT NULL,
    DateOut DATETIME, -- Date Out - can be NULL if currently rented
    PRIMARY KEY (CustID, WarehouseID, UnitID), -- Composite primary key
    FOREIGN KEY (CustID) REFERENCES customers(CustID),
    FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID)
);

-- Create the Storage Units table
CREATE TABLE storageunits (
    UnitID INT NOT NULL,
    WarehouseID VARCHAR(5) NOT NULL, -- FK Warehouse ID
    UnitSize VARCHAR(10) NOT NULL,
    Rent DECIMAL(19,4) NOT NULL CHECK (Rent >= 0), -- Rent Amount - must be non-negative, default to 0
    PRIMARY KEY (UnitID, WarehouseID), -- Composite primary key
    FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID)
);

-- Create the Job Orders table
CREATE TABLE joborders (
    JobID INT PRIMARY KEY,
    CustID INT NOT NULL, -- FK Customer ID
    MoveDate DATETIME NOT NULL,
    FromAddress VARCHAR(50) NOT NULL,
    FromCity VARCHAR(30) NOT NULL,
    FromState VARCHAR(2) NOT NULL,
    ToAddress VARCHAR(50) NOT NULL,
    ToCity VARCHAR(30) NOT NULL,
    ToState VARCHAR(2) NOT NULL,
    DistanceEst INT NOT NULL CHECK (DistanceEst >= 0), -- Distance - must be non-negative
    WeightEst INT NOT NULL CHECK (WeightEst >= 0), -- Weight - must be non-negative
    Packing TINYINT NOT NULL CHECK (Packing IN (0,1)), -- Packing (0=No, 1=Yes)
    Heavy TINYINT NOT NULL CHECK (Heavy IN (0,1)), -- Heavy (0=No, 1=Yes)
    Storage TINYINT NOT NULL CHECK (Storage IN (0,1)), -- Storage (0=No, 1=Yes)
    FOREIGN KEY (CustID) REFERENCES customers(CustID)
);
-- Create the Vehicles table
CREATE TABLE vehicles (
    VehicleID VARCHAR(10) PRIMARY KEY,
    LicensePlateNum VARCHAR(7) NOT NULL UNIQUE, -- License Plate Number - must be unique TODO: Validate License Plate Format
    Axle INT NOT NULL CHECK (Axle > 0),
    Color VARCHAR(10) NOT NULL
);

-- Create the Drivers table
CREATE TABLE drivers (
    DriverID INT PRIMARY KEY,
    DriverFirst VARCHAR(30) NOT NULL, -- Driver First Name
    DriverLast VARCHAR(30) NOT NULL, -- Driver Last Name
    SSN VARCHAR(9) NOT NULL UNIQUE, -- Social Security Number - must be unique
    DOB DATETIME NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME, -- can be NULL if currently employed
    Address VARCHAR(40) NOT NULL,
    City VARCHAR(30) NOT NULL,
    State VARCHAR(2) NOT NULL, -- State (2-letter code)
    ZIP VARCHAR(10) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Cell VARCHAR(15) NOT NULL, -- Cell Phone Number
    MileageRate DECIMAL(19,4) NOT NULL CHECK (MileageRate >= 0), -- Mileage Rate - must be non-negative
    Review DATETIME,
    DrivingRecord VARCHAR(1) NOT NULL CHECK (DrivingRecord IN ('A', 'B', 'C', 'D', 'E', 'F')) -- TODO: Validate Driving Record
);
-- Create the Job Details table
CREATE TABLE jobdetails (
    JobID INT PRIMARY KEY, -- Primary key Job Order ID
    VehicleID VARCHAR(10) NOT NULL, -- FKVehicle ID
    DriverID INT NOT NULL, -- FK Driver ID
    MileageActual INT NOT NULL CHECK (MileageActual >= 0), -- Actual Mileage - must be non-negative
    WeightActual INT NOT NULL CHECK (WeightActual >= 0), -- Actual Weight - must be non-negative
    FOREIGN KEY (JobID) REFERENCES joborders(JobID),
    FOREIGN KEY (VehicleID) REFERENCES vehicles(VehicleID),
    FOREIGN KEY (DriverID) REFERENCES drivers(DriverID)
);
-- Create the Positions table
CREATE TABLE positions (
    PositionID INT PRIMARY KEY,
    Title VARCHAR(30) NOT NULL
);
-- Create the Employees table
CREATE TABLE employees (
    EmpID INT PRIMARY KEY,
    EmpFirst VARCHAR(30) NOT NULL, -- Employee First Name
    EmpLast VARCHAR(30) NOT NULL, -- Employee Last Name
    WarehouseID VARCHAR(5) NOT NULL, -- FK Warehouse ID
    SSN VARCHAR(9) NOT NULL UNIQUE, -- Social Security Number - must be unique
    DOB DATETIME NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME, -- End Date - can be NULL if currently employed
    Address VARCHAR(40) NOT NULL,
    City VARCHAR(30) NOT NULL,
    State VARCHAR(2) NOT NULL,
    ZIP VARCHAR(10) NOT NULL,
    PositionID INT NOT NULL, -- FK Position ID
    Memo LONGTEXT,
    Phone VARCHAR(15) NOT NULL,
    Cell VARCHAR(15) NOT NULL, -- Cell Phone Number
    Salary DECIMAL(19,4) NOT NULL CHECK (Salary >= 0), -- Salary - must be non-negative
    HourlyRate DECIMAL(19,4) NOT NULL CHECK (HourlyRate >= 0), -- Hourly Rate - must be non-negative
    Review DATETIME,
    FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID),
    FOREIGN KEY (PositionID) REFERENCES positions(PositionID)
);

