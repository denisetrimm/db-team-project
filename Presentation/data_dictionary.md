# MovinOn Inc. – Data Dictionary

Complete data dictionary for the MovinOn_TeamNo database (10 tables).

---

## 1. customers

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| CustID | INT | — | PRIMARY KEY | Unique customer identifier |
| CompanyName | VARCHAR | 50 | NULL allowed | Company name (NULL for individuals) |
| ContactFirst | VARCHAR | 30 | NOT NULL | Contact first name |
| ContactLast | VARCHAR | 30 | NOT NULL | Contact last name |
| Address | VARCHAR | 40 | NOT NULL | Street address |
| City | VARCHAR | 30 | NOT NULL | City |
| State | VARCHAR | 2 | NOT NULL | Two-letter state code |
| ZIP | VARCHAR | 10 | NOT NULL | ZIP/postal code |
| Phone | VARCHAR | 15 | NOT NULL | Phone number |
| Balance | DECIMAL(19,4) | — | DEFAULT 0, CHECK >= 0 | Account balance |

**Records:** 38

---

## 2. warehouses

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| WarehouseID | VARCHAR | 5 | PRIMARY KEY | Warehouse code (WA-1, OR-1, WY-1) |
| Address | VARCHAR | 40 | NOT NULL | Street address |
| City | VARCHAR | 30 | NOT NULL | City |
| State | VARCHAR | 2 | NOT NULL | Two-letter state code |
| ZIP | VARCHAR | 10 | NOT NULL | ZIP code |
| Phone | VARCHAR | 15 | NOT NULL | Phone number |
| ClimateControl | TINYINT | — | NOT NULL, CHECK IN (0,1) | 1=Yes, 0=No |
| SecurityGate | TINYINT | — | NOT NULL, CHECK IN (0,1) | 1=Yes, 0=No |

**Records:** 3

---

## 3. positions

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| PositionID | INT | — | PRIMARY KEY | Unique position identifier |
| Title | VARCHAR | 30 | NOT NULL | Job title |

**Records:** 7 (Manager, Assistant Manager, Clerk, Sales Representative, Warehouse Worker, Mover, Dispatcher)

---

## 4. employees

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| EmpID | INT | — | PRIMARY KEY | Unique employee identifier |
| EmpFirst | VARCHAR | 30 | NOT NULL | First name |
| EmpLast | VARCHAR | 30 | NOT NULL | Last name |
| WarehouseID | VARCHAR | 5 | FK → warehouses, NOT NULL | Assigned warehouse |
| SSN | VARCHAR | 9 | UNIQUE, NOT NULL | Social Security Number |
| DOB | DATETIME | — | NOT NULL | Date of birth |
| StartDate | DATETIME | — | NOT NULL | Hire date |
| EndDate | DATETIME | — | NULL allowed | Termination date (NULL = active) |
| Address | VARCHAR | 40 | NOT NULL | Street address |
| City | VARCHAR | 30 | NOT NULL | City |
| State | VARCHAR | 2 | NOT NULL | Two-letter state code |
| ZIP | VARCHAR | 10 | NOT NULL | ZIP code |
| PositionID | INT | — | FK → positions, NOT NULL | Job title |
| Memo | VARCHAR(MAX) | — | NULL allowed | Notes |
| Phone | VARCHAR | 15 | NOT NULL | Phone number |
| Cell | VARCHAR | 15 | NOT NULL | Cell phone |
| Salary | DECIMAL(19,4) | — | CHECK >= 0 | Annual salary (salaried employees) |
| HourlyRate | DECIMAL(19,4) | — | CHECK >= 0 | Hourly rate (hourly employees) |
| Review | DATETIME | — | NULL allowed | Last performance review date |

**Records:** 35 (3 terminated)

---

## 5. drivers

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| DriverID | INT | — | PRIMARY KEY | Unique driver identifier |
| DriverFirst | VARCHAR | 30 | NOT NULL | First name |
| DriverLast | VARCHAR | 30 | NOT NULL | Last name |
| SSN | VARCHAR | 9 | UNIQUE, NOT NULL | Social Security Number |
| DOB | DATETIME | — | NOT NULL | Date of birth |
| StartDate | DATETIME | — | NOT NULL | Hire date |
| EndDate | DATETIME | — | NULL allowed | Termination date |
| Address | VARCHAR | 40 | NOT NULL | Street address |
| City | VARCHAR | 30 | NOT NULL | City |
| State | VARCHAR | 2 | NOT NULL | State code |
| ZIP | VARCHAR | 10 | NOT NULL | ZIP code |
| Phone | VARCHAR | 15 | NOT NULL | Phone number |
| Cell | VARCHAR | 15 | NOT NULL | Cell phone |
| MileageRate | DECIMAL(19,4) | — | NOT NULL, CHECK >= 0 | Per-mile compensation rate |
| Review | DATETIME | — | NULL allowed | Last review date |
| DrivingRecord | VARCHAR | 1 | NOT NULL, CHECK IN (A-F) | Driving record grade |

**Records:** 20 (2 terminated)

---

## 6. vehicles

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| VehicleID | VARCHAR | 10 | PRIMARY KEY | Vehicle code (TRK-001, VAN-001, etc.) |
| LicensePlateNum | VARCHAR | 7 | UNIQUE, NOT NULL | License plate number |
| Axle | INT | — | NOT NULL, CHECK > 0 | Number of axles |
| Color | VARCHAR | 10 | NOT NULL | Vehicle color |

**Records:** 17

---

## 7. joborders

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| JobID | INT | — | PRIMARY KEY | Unique job identifier |
| CustID | INT | — | FK → customers, NOT NULL | Customer requesting the move |
| MoveDate | DATETIME | — | NOT NULL | Scheduled move date |
| FromAddress | VARCHAR | 50 | NOT NULL | Origin street address |
| FromCity | VARCHAR | 30 | NOT NULL | Origin city |
| FromState | VARCHAR | 2 | NOT NULL | Origin state |
| ToAddress | VARCHAR | 50 | NOT NULL | Destination street address |
| ToCity | VARCHAR | 30 | NOT NULL | Destination city |
| ToState | VARCHAR | 2 | NOT NULL | Destination state |
| DistanceEst | INT | — | NOT NULL, CHECK >= 0 | Estimated distance (miles) |
| WeightEst | INT | — | NOT NULL, CHECK >= 0 | Estimated weight (lbs) |
| Packing | TINYINT | — | NOT NULL, CHECK IN (0,1) | Packing service requested |
| Heavy | TINYINT | — | NOT NULL, CHECK IN (0,1) | Heavy items flag |
| Storage | TINYINT | — | NOT NULL, CHECK IN (0,1) | Storage needed flag |

**Records:** 28

---

## 8. jobdetails

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| JobID | INT | — | PK, FK → joborders | Links to job order |
| VehicleID | VARCHAR | 10 | FK → vehicles, NOT NULL | Vehicle used |
| DriverID | INT | — | FK → drivers, NOT NULL | Driver assigned |
| MileageActual | INT | — | NOT NULL, CHECK >= 0 | Actual miles driven |
| WeightActual | INT | — | NOT NULL, CHECK >= 0 | Actual weight moved (lbs) |

**Records:** 10

---

## 9. storageunits

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| UnitID | INT | — | PK (composite) | Unit number within warehouse |
| WarehouseID | VARCHAR | 5 | PK (composite), FK → warehouses | Warehouse location |
| UnitSize | VARCHAR | 10 | NOT NULL | Dimensions (e.g., "12 x 12") |
| Rent | DECIMAL(19,4) | — | NOT NULL, CHECK >= 0 | Monthly rent amount |

**Records:** 31

---

## 10. unitrentals

| Field | Data Type | Size | Constraints | Description |
|---|---|---|---|---|
| CustID | INT | — | PK (composite), FK → customers | Renting customer |
| WarehouseID | VARCHAR | 5 | PK (composite), FK → warehouses | Warehouse |
| UnitID | INT | — | PK (composite) | Storage unit |
| DateIn | DATETIME | — | NOT NULL | Rental start date |
| DateOut | DATETIME | — | NULL allowed | Rental end date (NULL = active) |

**Records:** 26
