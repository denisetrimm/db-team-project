# MovinOn Inc. – Speaker Notes

Suggested time allocation: ~30 minutes total for 3 team members (~10 minutes each).

---

## Section 1: Introduction (2-3 minutes)

**Suggested speaker: Any team member**

> "Good [morning/afternoon]. Our team — Anton, Denise, and Alonso — presents the MovinOn Inc. Database Development Project for CCCS 330.
>
> MovinOn is a moving and storage company operating in three states: Washington, Oregon, and Wyoming, with warehouses in Seattle, Portland, and Jackson Hole. They provide two core services: professional moving services with a fleet of trucks and vans, and storage unit rentals at each warehouse.
>
> The company is considering a merger and expansion, and they needed a centralized database to replace scattered spreadsheets for managing employees, drivers, jobs, customers, and storage.
>
> We chose Microsoft SQL Server as our DBMS because of its enterprise-grade support for views, stored procedures, triggers, and transactions — all of which this project requires. T-SQL's procedural extensions like CASE, CURSOR, and RAISERROR were essential for implementing business logic like area code validation."

---

## Section 2: Database Design Process (5-10 minutes)

### Step 1 – Purpose of the Database

**Suggested speaker: Team Member 1**

> "The database serves six key business areas: HR management for 35+ employees across three warehouses, driver and fleet tracking for 20 drivers and 17 vehicles, customer management for 38 corporate and individual clients, moving job costing with actual versus estimated mileage and weight, storage unit inventory and rental tracking, and financial reporting for revenue analysis.
>
> Every one of these needs maps directly to one or more tables and advanced objects in our database."

### Step 2 – Entities and Tables

> "We identified 10 entities by analyzing MovinOn's operations. Each real-world concept — customers, warehouses, employees, positions, drivers, vehicles, job orders, job details, storage units, and unit rentals — became a table. We identified entities by asking: 'What distinct objects does MovinOn need to track persistently?'"

### Step 3 – Data Dictionary

> "Our data dictionary documents every field across all 10 tables — the full document is in `Presentation/data_dictionary.md`. As an example, the employees table has 18 columns including two foreign keys to warehouses and positions, a UNIQUE constraint on SSN, and separate nullable columns for Salary and HourlyRate to support both compensation types."

### Step 4 – Relationships and ERD

**Suggested speaker: Team Member 2**

> "The ERD follows Figure 2.1 from the project requirements. Key relationships include:
> - One-to-Many from customers to both job orders and unit rentals
> - One-to-Many from warehouses to employees, storage units, and unit rentals
> - One-to-One from job orders to job details, enforced by making JobID both the PK and FK in jobdetails
> - Composite primary keys in storageunits (UnitID + WarehouseID) and unitrentals (CustID + WarehouseID + UnitID)"

### Step 5 – Normalization

> "Our database is in Third Normal Form. For 1NF, all fields are atomic — addresses are split into components, names into First/Last. For 2NF, composite key tables like storageunits have no partial dependencies — rent depends on BOTH UnitID and WarehouseID since the same unit number can have different rents at different warehouses. For 3NF, we eliminated transitive dependencies by extracting position titles into a separate table and referencing warehouses by FK instead of duplicating addresses."

---

## Section 3: Database Implementation (10-15 minutes)

### Step 1 – Creating the Database

**Suggested speaker: Team Member 2**

> "The database is created with a single `CREATE DATABASE MovinOn_TeamNo;` statement. All subsequent scripts use `USE MovinOn_TeamNo;` for context. We kept the default dbo schema as it's appropriate for this project's scope."

### Step 2 – Tables and Data Integrity

> "Our create_tables.sql defines all 10 tables with comprehensive constraints: PRIMARY KEYs on every table, FOREIGN KEYs for all relationships, CHECK constraints ensuring non-negative values for Balance, Salary, Rent, Mileage, and Weight, UNIQUE constraints on SSN and license plates, and DEFAULT values for customer Balance. For example, DrivingRecord is constrained to letters A through F using CHECK."

### Step 3 – Indexing Strategy

**Suggested speaker: Team Member 3**

> "We created indexes on all foreign key columns to optimize JOIN performance in our views and reports. Additionally, we indexed date columns like StartDate, DateIn, and MoveDate since many of our calculations — vesting, rental duration, revenue — filter or compute on dates. The State column on employees is indexed because the area code trigger queries by state."

### Step 4 – Sample Data

> "Our import_sample_data.sql populates all tables with realistic data: 38 customers, 35 employees across three warehouses, 20 drivers, 17 vehicles, 28 job orders with 10 completed job details, 31 storage units, and 26 active rentals. The data was adapted from provided Excel files to match our schema constraints."

### Step 5 – Views and Functions

> "We created seven views and two scalar functions. The vesting view calculates years of service and determines if an employee is vested after five years. The earnings view uses COALESCE to compute annual salary — using the Salary field for salaried employees and HourlyRate times 2,080 for hourly employees. Our two scalar functions answer FAQ questions: how many units were rented last year, and what percentage of customers have rented at least one unit."

### Step 6 – Stored Procedures and Triggers

> "We have five stored procedures covering warehouse mailing labels, job revenue with totals, storage revenue by warehouse, the customer with the most rentals, and average rental period. Our trigger validates phone area codes on every INSERT and UPDATE to the employees table — it strips formatting characters, extracts the first three digits, and raises an error with a descriptive message if the area code doesn't match the employee's state."

### Step 7 – Transactions

> "Our transaction script demonstrates a realistic multi-step operation: inserting a new job order, its corresponding job detail, and updating the customer balance — all within a single transaction. Using BEGIN TRY / BEGIN CATCH with COMMIT and ROLLBACK ensures atomicity: either all three operations succeed or none do. This prevents orphaned job records or incorrect balances."

---

## Section 4: Challenges and Solutions (5 minutes)

**Suggested speaker: Any team member**

> "We faced several challenges:
>
> First, the sample Excel data didn't match our schema exactly — phone number formats varied, and some column names differed. We resolved this by adapting our INSERT statements.
>
> Second, we discovered a missing storage unit — unit rental data referenced UnitID 11 in WY-1, but that unit didn't exist in the storageunits table. We added it to maintain referential integrity.
>
> Third, the vesting logic had an ambiguity — the requirements mentioned checking both that the EndDate is NULL and that years of service exceed five. We combined both conditions to correctly identify vested employees.
>
> Fourth, phone numbers were stored inconsistently with and without parentheses, dashes, and spaces. Our trigger handles this by stripping all formatting before extracting the area code.
>
> Finally, handling two compensation types (salary vs. hourly) in a single table required careful use of COALESCE to unify the annual earnings calculation."

---

## Section 5: Future Enhancements (3 minutes)

**Suggested speaker: Any team member**

> "For future improvements, we suggest:
> - Role-based access control so HR staff see employee data but drivers only see their own records
> - Audit trail triggers to log every change for compliance
> - An automated billing system for monthly storage invoices
> - Power BI dashboards for real-time revenue and occupancy visualization
> - A vehicle maintenance tracking table
>
> For scalability, the schema already supports any number of warehouses via FK relationships, and the area code trigger can be extended for new states as MovinOn expands."

---

## Section 6: Conclusion (2-3 minutes)

**Suggested speaker: Any team member**

> "In summary, we designed and implemented a 10-table relational database in Microsoft SQL Server that covers MovinOn's full operational needs. We created 7 views, 2 functions, 5 stored procedures, 1 trigger, and a transaction script. We applied comprehensive data integrity through primary keys, foreign keys, CHECK, UNIQUE, and DEFAULT constraints.
>
> The key takeaway for our team was learning how to translate real-world business rules — like vesting policies and revenue formulas — into database objects that automate those rules. We also gained experience collaborating on a shared SQL codebase using Git.
>
> Thank you. We're happy to take any questions."
