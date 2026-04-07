# MovinOn Inc. – Database Development Project Presentation

**CCCS 330 – Database Design & Business Applications Development**
**McGill University – Department of Career and Management Studies**

**Team Members:**
- Anton Tang (261156269)
- Denise Trimm (260619643)
- Alonso Vasconcelos Gallegos (261133267)

---

## SLIDE 1 – Title Slide

**MovinOn Inc. – Database Development Project**

- Course: CCCS 330 – Database Design & Business Applications Development
- DBMS: Microsoft SQL Server (T-SQL)
- Database: MovinOn_TeamNo
- Team: Anton Tang, Denise Trimm, Alonso Vasconcelos Gallegos

---

## SLIDE 2 – Introduction / Business Overview (Section 1)

**MovinOn Inc. – About the Business**

- MovinOn Inc. is a **moving and storage company** operating across three U.S. states: Washington, Oregon, and Wyoming.
- The company owns and operates **three warehouses** (Seattle WA, Portland OR, Jackson Hole WY).
- Core services:
  - **Moving services** – local and interstate moves with a fleet of trucks and vans
  - **Storage unit rentals** – climate-controlled and secured units in each warehouse
- The company employs **drivers**, **warehouse workers**, **clerks**, **managers**, and **sales representatives**.
- MovinOn is exploring a potential **merger and expansion**, making a robust data system essential.

---

## SLIDE 3 – Project Justification & DBMS Selection (Section 1 cont.)

**Why This Project? Why SQL Server?**

- **Project justification:**
  - MovinOn's data was previously scattered across spreadsheets, making employee tracking, job costing, and revenue analysis difficult.
  - A centralized relational database addresses all operational needs: HR, logistics, and finance.
- **Why Microsoft SQL Server?**
  - Enterprise-grade with built-in support for views, stored procedures, triggers, and transactions.
  - T-SQL provides powerful procedural extensions (CASE, CURSOR, RAISERROR).
  - Industry-standard security, backup, and scalability features.
  - Widely used in corporate environments — relevant career skill.

---

## SLIDE 4 – Purpose of the Database (Section 2, Step 1)

**Business Needs & Key Functionalities**

The database fulfills the following business needs:

| Business Need | Database Support |
|---|---|
| Human resources management | Employees table with vesting, earnings, area code validation |
| Driver/fleet management | Drivers, Vehicles, Job Details tables |
| Customer relationship management | Customers table with company and individual contacts |
| Moving job tracking & costing | Job Orders + Job Details with revenue calculations |
| Storage unit inventory & rental | Storage Units + Unit Rentals with revenue reports |
| Financial reporting | Views and stored procedures for revenue, payroll, and occupancy |
| Data integrity & validation | CHECK constraints, FOREIGN KEYs, triggers |

---

## SLIDE 5 – Entities and Tables (Section 2, Step 2)

**Major Entities (10 Tables)**

| Entity | Table Name | Purpose |
|---|---|---|
| Customers | `customers` | Companies and individuals using MovinOn services |
| Warehouses | `warehouses` | Three physical warehouse locations |
| Employees | `employees` | Staff working at each warehouse |
| Positions | `positions` | Job titles (Manager, Clerk, Mover, etc.) |
| Drivers | `drivers` | Truck/van drivers with mileage rates |
| Vehicles | `vehicles` | Fleet trucks and vans |
| Job Orders | `joborders` | Customer move requests with estimates |
| Job Details | `jobdetails` | Actual mileage/weight for completed jobs |
| Storage Units | `storageunits` | Individual units in each warehouse |
| Unit Rentals | `unitrentals` | Customer-to-unit rental records |

**Entity identification method:** Analyzed MovinOn's business operations (HR, logistics, storage, finance) and identified distinct real-world objects that require persistent storage.

---

## SLIDE 6 – Data Dictionary (Section 2, Step 3)

**Data Dictionary – Key Tables (see full document in Presentation/data_dictionary.md)**

**Example: employees table**

| Field | Data Type | Constraints | Description |
|---|---|---|---|
| EmpID | INT | PRIMARY KEY | Unique employee identifier |
| EmpFirst | VARCHAR(30) | NOT NULL | First name |
| EmpLast | VARCHAR(30) | NOT NULL | Last name |
| WarehouseID | VARCHAR(5) | FK → warehouses | Assigned warehouse |
| SSN | VARCHAR(9) | UNIQUE, NOT NULL | Social Security Number |
| DOB | DATETIME | NOT NULL | Date of birth |
| StartDate | DATETIME | NOT NULL | Hire date |
| EndDate | DATETIME | NULL allowed | Termination date (NULL = active) |
| Salary | DECIMAL(19,4) | CHECK >= 0 | Annual salary (salaried employees) |
| HourlyRate | DECIMAL(19,4) | CHECK >= 0 | Hourly rate (hourly employees) |
| PositionID | INT | FK → positions | Job title reference |

*(Full data dictionary with all 10 tables provided in `Presentation/data_dictionary.md`)*

---

## SLIDE 7 – Entity-Relationship Diagram (Section 2, Step 4)

**ERD – MovinOn Inc. (Figure 2.1)**

*(See full ERD description in Presentation/erd_relationships.md)*

```
  positions ──1:M──► employees ◄──M:1── warehouses
                          │
                     (WarehouseID)
                          │
  customers ──1:M──► unitrentals ◄──M:1── storageunits ◄──M:1── warehouses
      │
      └──1:M──► joborders ──1:1──► jobdetails
                                      │        │
                                  (DriverID) (VehicleID)
                                      │        │
                                   drivers   vehicles
```

**Key Relationships:**
- **1:M** – One customer can have many job orders and many unit rentals
- **1:M** – One warehouse has many employees and many storage units
- **1:1** – Each job order has exactly one job detail record
- **Composite PKs** – `storageunits (UnitID, WarehouseID)` and `unitrentals (CustID, WarehouseID, UnitID)`

---

## SLIDE 8 – Normalization (Section 2, Step 5)

**Normalization – 1NF, 2NF, 3NF**

*(See full analysis in Presentation/normalization.md)*

| Normal Form | Requirement | How We Achieved It |
|---|---|---|
| **1NF** | Atomic values, no repeating groups | Each field stores a single value. No multi-valued columns. Composite keys used where needed. |
| **2NF** | No partial dependencies | All non-key attributes depend on the entire primary key. `storageunits` uses (UnitID, WarehouseID) — Rent depends on both, not just one. |
| **3NF** | No transitive dependencies | No non-key field depends on another non-key field. Warehouse details are in `warehouses`, not repeated in `employees`. Position titles are in `positions`, not stored directly in `employees`. |

**Redundancy reduction:**
- `positions` table separates job titles from `employees` (avoids storing "Manager" as text in every row).
- `warehouses` table centralizes address/phone — referenced by FK in `employees`, `storageunits`, `unitrentals`.
- `customers` is referenced by FK in both `joborders` and `unitrentals` — no customer data duplication.

---

## SLIDE 9 – Creating the Database & Schema (Section 3, Step 1)

**Script: `create_database.sql`**

```sql
CREATE DATABASE MovinOn_TeamNo;
```

- Single-line script that initializes the database.
- All subsequent scripts begin with `USE MovinOn_TeamNo;` to ensure correct context.
- No custom schemas beyond `dbo` — the default schema provides simple, flat organization suitable for this project's scope.

---

## SLIDE 10 – Creating Tables & Data Integrity (Section 3, Step 2)

**Script: `create_tables.sql` — Constraint Highlights**

```sql
-- PRIMARY KEY
EmpID INT PRIMARY KEY,

-- FOREIGN KEY with referential integrity
FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID),
FOREIGN KEY (PositionID) REFERENCES positions(PositionID),

-- UNIQUE constraint
SSN VARCHAR(9) NOT NULL UNIQUE,

-- CHECK constraint
CHECK (Salary >= 0),
CHECK (DrivingRecord IN ('A','B','C','D','E','F')),
CHECK (ClimateControl IN (0,1)),

-- DEFAULT constraint
Balance DECIMAL(19,4) DEFAULT 0 CHECK (Balance >= 0),

-- NULL handling
EndDate DATETIME,  -- NULL = currently employed
CompanyName VARCHAR(50),  -- NULL = individual customer
```

**Summary:** 10 tables, 15+ foreign key relationships, CHECK constraints on numeric fields and enumerated values, UNIQUE on SSN and license plates, DEFAULT on customer balance.

---

## SLIDE 11 – Indexing Strategy (Section 3, Step 3)

**Script: `indexing_strategy.sql`**

```sql
-- Frequently filtered/joined columns
CREATE INDEX IX_employees_WarehouseID ON employees(WarehouseID);
CREATE INDEX IX_employees_PositionID ON employees(PositionID);
CREATE INDEX IX_joborders_CustID ON joborders(CustID);
CREATE INDEX IX_unitrentals_WarehouseID ON unitrentals(WarehouseID);
CREATE INDEX IX_jobdetails_DriverID ON jobdetails(DriverID);
CREATE INDEX IX_jobdetails_VehicleID ON jobdetails(VehicleID);

-- Reporting queries filter by state and dates
CREATE INDEX IX_employees_State ON employees(State);
CREATE INDEX IX_employees_StartDate ON employees(StartDate);
CREATE INDEX IX_unitrentals_DateIn ON unitrentals(DateIn);
CREATE INDEX IX_joborders_MoveDate ON joborders(MoveDate);
```

**Optimization benefits:**
- FK columns indexed for faster JOIN operations in views and reports.
- Date columns indexed to accelerate date-range filters (vesting, rental periods, job revenue).
- State column indexed for area code validation and state-based queries.

---

## SLIDE 12 – Inserting Sample Data (Section 3, Step 4)

**Script: `import_sample_data.sql`**

| Table | Records | Source |
|---|---|---|
| positions | 7 | Manager, Asst Manager, Clerk, Sales Rep, Warehouse Worker, Mover, Dispatcher |
| warehouses | 3 | WA-1 (Seattle), OR-1 (Portland), WY-1 (Jackson Hole) |
| customers | 38 | Mix of companies and individuals across WA, OR, WY |
| vehicles | 17 | 11 trucks + 6 vans |
| drivers | 20 | Across all three states, 2 terminated |
| employees | 35 | 3 terminated, rest active; mix of salaried and hourly |
| joborders | 28 | Sept–Nov 2016 moves |
| jobdetails | 10 | Completed jobs with actual mileage/weight |
| storageunits | 31 | 10–11 units per warehouse, various sizes |
| unitrentals | 26 | All currently active rentals |

Data was adapted from provided Excel files to fit our table schema and constraints.

---

## SLIDE 13 – Views & User-Defined Functions (Section 3, Step 5)

**Views Created:**

| View Name | Purpose |
|---|---|
| `vw_EmployeeVesting` | Years of service, vesting status (>5 yrs), hides EndDate for active / Review for inactive |
| `vw_EmployeeEarnings` | Annual salary (Salary or HourlyRate×2080), age, years of service |
| `vw_JobRevenueDetail` | Income, driver payment, net income per job |
| `vw_StorageRevenueDetail` | Rent per unit, years rented, by warehouse and renter |
| `vw_AverageRentalPeriod` | Average rental length in days and years |
| `vw_PeakRentalMonths` | Months ranked by number of rentals started |
| `vw_MonthlyRentalCounts` | Monthly rental counts (alternate view) |

**Scalar Functions:**

| Function | Returns |
|---|---|
| `fn_StorageUnitsRentedLastYear()` | INT — count of units rented during last calendar year |
| `fn_PercentCustomersWithRental()` | DECIMAL — % of customers with at least one rental |

```sql
-- Example: vesting calculation
CASE 
  WHEN StartDate IS NOT NULL 
    AND DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE())) > 5 
  THEN 'Vested' 
  ELSE 'Not Vested' 
END AS VestingMessage
```

---

## SLIDE 14 – Stored Procedures & Triggers (Section 3, Step 6)

**Stored Procedures:**

| Procedure | Purpose |
|---|---|
| `WarehouseManagerReportLabels` | Mailing labels for managers (optional @WarehouseID filter) |
| `JobRevenueReport` | Job income detail + totals with $ formatting |
| `StorageRevenueReport` | Storage revenue by warehouse with subtotals and grand total |
| `sp_GreatestRentsByIndividual` | Customer with the most rental units |
| `sp_AverageRentalPeriod` | Average rental period in days (completed rentals) |

**Trigger:**

| Trigger | Event | Logic |
|---|---|---|
| `tr_Employee_ValidateAreaCode` | AFTER INSERT, UPDATE on `employees` | Validates phone/cell area codes: OR (541, 503, 971), WA (425, 360, 206, 509, 253), WY (307). Other states pass through. Raises error with descriptive message. |

```sql
-- Trigger extracts first 3 digits after stripping formatting
SET @AreaPhone = LEFT(REPLACE(REPLACE(REPLACE(REPLACE(@Phone,' ',''),'-',''),'(',''),')',''), 3);

IF @State = 'OR' AND @AreaPhone NOT IN ('541','503','971')
    RAISERROR('OR phone area codes should be 541, 503, or 971', 16, 1);
```

---

## SLIDE 15 – Transactions (Section 3, Step 7)

**Script: `transaction_example.sql`**

```sql
BEGIN TRANSACTION;
BEGIN TRY
    -- Insert a new job order
    INSERT INTO joborders (...) VALUES (...);
    -- Insert the corresponding job detail
    INSERT INTO jobdetails (...) VALUES (...);
    -- Update customer balance
    UPDATE customers SET Balance = Balance + @JobCost WHERE CustID = @CustID;
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH
```

**How transactions ensure integrity:**
- **Atomicity** — Either ALL three operations succeed (job order + job detail + balance update) or NONE do.
- **Consistency** — CHECK constraints and FK relationships are validated within the transaction.
- **Isolation** — Concurrent users cannot see partial job records.
- **Durability** — Once committed, the data survives system failures.

---

## SLIDE 16 – Challenges & Solutions (Section 4)

| Challenge | Solution |
|---|---|
| **Excel data mismatch** — Sample data from Employee.xlsx had columns/formats that didn't match our schema | Modified INSERT statements to align data with table constraints; adapted phone number formats |
| **Composite primary keys** — `storageunits` and `unitrentals` needed multi-column PKs | Used composite PKs (UnitID + WarehouseID) ensuring a unit is unique per warehouse |
| **Missing FK target** — Unit rental referenced UnitID 11 in WY-1 but storage unit didn't exist | Added (11, 'WY-1') to `storageunits` insert data |
| **Phone format inconsistency** — Phone numbers stored in various formats (with/without dashes, parentheses) | Trigger strips all formatting before extracting the 3-digit area code |
| **Salaried vs. hourly employees** — Annual salary calculation differs per employee type | Used COALESCE(Salary, HourlyRate * 2080) to unify into one AnnualSalary column |
| **Vesting logic ambiguity** — Requirements said "if employee end date is null" AND "years > 5" | Combined both conditions: must be active (EndDate IS NULL) AND have 5+ years |

---

## SLIDE 17 – Future Enhancements (Section 5)

**Potential Improvements:**

1. **User authentication & role-based access** — Restrict HR views to authorized personnel; drivers see only their own records.
2. **Audit trail triggers** — Log all INSERT/UPDATE/DELETE operations to a history table for compliance.
3. **Customer billing system** — Automated monthly invoicing for storage rentals, updating customer Balance.
4. **Dashboard reporting** — Connect Power BI or SSRS for real-time visual dashboards (revenue trends, occupancy rates).
5. **Vehicle maintenance tracking** — New table to schedule and log maintenance per vehicle, linked to Vehicles.

**Scalability considerations:**
- **Partitioning** — As job orders grow, partition `joborders` and `jobdetails` by year.
- **Additional warehouses** — Schema already supports any number of warehouses via WarehouseID FK.
- **Multi-state expansion** — Area code trigger can be extended with new state rules.
- **Merger readiness** — Schema can absorb acquired company data via bulk import.

---

## SLIDE 18 – Conclusion (Section 6)

**Key Takeaways:**

- Successfully designed and implemented a **10-table relational database** for MovinOn Inc. in Microsoft SQL Server.
- Covered the full database lifecycle: **analysis → design → normalization → implementation → reporting**.
- Implemented advanced T-SQL objects: **6+ views, 2 scalar functions, 5 stored procedures, 1 trigger, transactions**.
- Applied comprehensive data integrity: **PKs, FKs, CHECK, UNIQUE, DEFAULT, trigger-based validation**.
- Produced actionable business reports: **job revenue, storage revenue, warehouse mailing labels, employee vesting/earnings**.

**What We Learned:**
- Translating real-world business rules into database constraints and procedural logic.
- The importance of normalization in eliminating redundancy and maintaining data consistency.
- How views, stored procedures, and triggers separate business logic from application code.
- Team collaboration on a shared SQL codebase using version control (Git/GitHub).

**Thank you — Questions?**
