# MovinOn Inc. – Normalization Analysis

## Overview

The MovinOn database was designed in **Third Normal Form (3NF)** to minimize redundancy and preserve data integrity. Below is a step-by-step analysis of how each normal form was achieved.

---

## First Normal Form (1NF)

**Rule:** All columns contain atomic (indivisible) values. No repeating groups or arrays.

| Verification | Example |
|---|---|
| No multi-valued fields | Customer address is split into Address, City, State, ZIP — not a single concatenated string |
| No repeating groups | A customer's multiple rentals are rows in `unitrentals`, not columns (Rental1, Rental2, ...) |
| Every table has a primary key | All 10 tables have explicitly defined PKs (single or composite) |
| Each row is unique | PKs enforce uniqueness; SSN and LicensePlateNum also have UNIQUE constraints |

**Example of 1NF compliance in `employees`:**
```
EmpID | EmpFirst | EmpLast | Address              | City     | State | ZIP
------+----------+---------+----------------------+----------+-------+------
  1   | David    | Bowers  | 10124 Metropolitan Dr| Seattle  | WA    | 98117
```
Each field contains exactly one value. Name is split into First/Last. Address components are separated.

---

## Second Normal Form (2NF)

**Rule:** Must be in 1NF AND every non-key attribute must depend on the **entire** primary key (no partial dependencies).

This is particularly important for tables with **composite primary keys:**

### storageunits (PK: UnitID + WarehouseID)

| Attribute | Depends On | Full Key? |
|---|---|---|
| UnitSize | UnitID + WarehouseID | Yes — Unit 1 at WA-1 is "12 x 12", Unit 1 at OR-1 is "8 x 8" |
| Rent | UnitID + WarehouseID | Yes — same unit number can have different rent at different warehouses |

No partial dependency exists — UnitSize and Rent both require knowing WHICH unit at WHICH warehouse.

### unitrentals (PK: CustID + WarehouseID + UnitID)

| Attribute | Depends On | Full Key? |
|---|---|---|
| DateIn | CustID + WarehouseID + UnitID | Yes — the rental start is specific to this customer renting this unit |
| DateOut | CustID + WarehouseID + UnitID | Yes — same reasoning |

No partial dependencies. Customer details (name, address) are stored in the `customers` table, not here.

### Tables with single-column PKs
Tables like `customers`, `employees`, `drivers`, `vehicles`, `joborders`, and `positions` have single-column PKs, so 2NF is automatically satisfied (partial dependency is impossible with a single-column key).

---

## Third Normal Form (3NF)

**Rule:** Must be in 2NF AND no non-key attribute depends on another non-key attribute (no transitive dependencies).

| Potential Transitive Dependency | How We Resolved It |
|---|---|
| Employee → Position Title | `PositionID` FK references `positions` table. Title is NOT stored in `employees`. |
| Employee → Warehouse Address/Phone | `WarehouseID` FK references `warehouses` table. Warehouse details are NOT duplicated in employee rows. |
| Job Details → Driver Name/Rate | `DriverID` FK references `drivers` table. Driver info is NOT repeated in `jobdetails`. |
| Job Details → Vehicle License/Color | `VehicleID` FK references `vehicles` table. Vehicle info is NOT stored in `jobdetails`. |
| Unit Rentals → Customer Name | `CustID` FK references `customers` table. Customer name is NOT in `unitrentals`. |
| Unit Rentals → Unit Size/Rent | Rent info is in `storageunits`, NOT duplicated in `unitrentals`. |

**Example of transitive dependency avoidance:**

Instead of:
```
employees: EmpID | EmpFirst | PositionTitle  | WarehouseAddress     ← BAD (transitive)
```

We have:
```
employees:  EmpID | EmpFirst | PositionID (FK) | WarehouseID (FK)   ← GOOD (3NF)
positions:  PositionID | Title
warehouses: WarehouseID | Address | City | State | ZIP
```

If a position title changes (e.g., "Clerk" → "Office Clerk"), we update ONE row in `positions` rather than every employee row with that title.

---

## Summary

| Normal Form | Key Principle | Achieved? |
|---|---|---|
| **1NF** | Atomic values, unique rows, primary keys | Yes |
| **2NF** | No partial dependencies on composite keys | Yes |
| **3NF** | No transitive dependencies between non-key attributes | Yes |

**Benefits of normalization in this database:**
- Changing a warehouse address requires updating ONE row in `warehouses`, not 10+ employee rows.
- Adding a new position requires ONE insert into `positions`, not modifying the employees table structure.
- Storage unit rent changes affect ONE row in `storageunits` and are automatically reflected in all views and reports.
- No data anomalies on INSERT, UPDATE, or DELETE operations.
