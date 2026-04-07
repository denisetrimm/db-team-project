# MovinOn Inc. – Entity-Relationship Diagram & Relationships

## ERD Diagram (Text Representation of Figure 2.1)

```
┌──────────────┐          ┌──────────────┐          ┌──────────────┐
│  positions   │          │  warehouses  │          │   vehicles   │
│──────────────│          │──────────────│          │──────────────│
│ PositionID PK│──┐       │ WarehouseID PK│──┬──┐   │ VehicleID PK │──┐
│ Title        │  │       │ Address      │  │  │   │ LicensePlate │  │
└──────────────┘  │       │ City         │  │  │   │ Axle         │  │
                  │       │ State        │  │  │   │ Color        │  │
                  │       │ ZIP          │  │  │   └──────────────┘  │
                  │       │ Phone        │  │  │                     │
                  │       │ ClimateCtrl  │  │  │   ┌──────────────┐  │
                  │       │ SecurityGate │  │  │   │   drivers    │  │
                  │       └──────────────┘  │  │   │──────────────│  │
                  │                         │  │   │ DriverID PK  │──┼──┐
                  │  ┌──────────────────────┘  │   │ DriverFirst  │  │  │
                  │  │                         │   │ DriverLast   │  │  │
                  │  │  ┌──────────────────────┘   │ SSN          │  │  │
                  │  │  │                          │ MileageRate  │  │  │
                  ▼  ▼  │                          │ ...          │  │  │
          ┌──────────────────┐                     └──────────────┘  │  │
          │    employees     │                                       │  │
          │──────────────────│                                       │  │
          │ EmpID PK         │                                       │  │
          │ EmpFirst         │                                       │  │
          │ EmpLast          │                                       │  │
          │ WarehouseID FK ──┤                                       │  │
          │ PositionID FK ───┤                                       │  │
          │ SSN              │                                       │  │
          │ DOB              │                                       │  │
          │ StartDate        │                                       │  │
          │ EndDate          │                                       │  │
          │ Salary/HourlyRate│                                       │  │
          │ ...              │                                       │  │
          └──────────────────┘                                       │  │
                                                                     │  │
          ┌──────────────────┐    ┌──────────────────┐               │  │
          │   customers      │    │   storageunits   │               │  │
          │──────────────────│    │──────────────────│               │  │
          │ CustID PK ───────┼──┐ │ UnitID PK ───────┤               │  │
          │ CompanyName      │  │ │ WarehouseID PK/FK│               │  │
          │ ContactFirst     │  │ │ UnitSize         │               │  │
          │ ContactLast      │  │ │ Rent             │               │  │
          │ Address          │  │ └──────────────────┘               │  │
          │ City/State/ZIP   │  │          │                         │  │
          │ Phone            │  │          │                         │  │
          │ Balance          │  │          │                         │  │
          └──────────────────┘  │          │                         │  │
                  │             │          │                         │  │
                  │             ▼          ▼                         │  │
                  │    ┌──────────────────────────┐                  │  │
                  │    │      unitrentals         │                  │  │
                  │    │──────────────────────────│                  │  │
                  │    │ CustID PK/FK ────────────┤                  │  │
                  │    │ WarehouseID PK/FK        │                  │  │
                  │    │ UnitID PK                │                  │  │
                  │    │ DateIn                   │                  │  │
                  │    │ DateOut                  │                  │  │
                  │    └──────────────────────────┘                  │  │
                  │                                                  │  │
                  ▼                                                  │  │
          ┌──────────────────┐    ┌──────────────────┐               │  │
          │    joborders     │    │    jobdetails    │               │  │
          │──────────────────│    │──────────────────│               │  │
          │ JobID PK ────────┼───►│ JobID PK/FK      │               │  │
          │ CustID FK        │    │ VehicleID FK ────┼───────────────┘  │
          │ MoveDate         │    │ DriverID FK ─────┼──────────────────┘
          │ FromAddr/City/St │    │ MileageActual    │
          │ ToAddr/City/St   │    │ WeightActual     │
          │ DistanceEst      │    └──────────────────┘
          │ WeightEst        │
          │ Packing/Heavy/Stg│
          └──────────────────┘
```

---

## Relationship Summary

| Relationship | Type | FK Column | Description |
|---|---|---|---|
| positions → employees | One-to-Many | employees.PositionID | One position held by many employees |
| warehouses → employees | One-to-Many | employees.WarehouseID | One warehouse has many employees |
| warehouses → storageunits | One-to-Many | storageunits.WarehouseID | One warehouse contains many units |
| warehouses → unitrentals | One-to-Many | unitrentals.WarehouseID | One warehouse has many rentals |
| customers → unitrentals | One-to-Many | unitrentals.CustID | One customer can rent many units |
| customers → joborders | One-to-Many | joborders.CustID | One customer can request many moves |
| joborders → jobdetails | One-to-One | jobdetails.JobID (PK+FK) | Each order has exactly one detail record |
| drivers → jobdetails | One-to-Many | jobdetails.DriverID | One driver can work many jobs |
| vehicles → jobdetails | One-to-Many | jobdetails.VehicleID | One vehicle can be used for many jobs |

---

## Foreign Key Constraints

```sql
-- employees
FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID)
FOREIGN KEY (PositionID)  REFERENCES positions(PositionID)

-- unitrentals
FOREIGN KEY (CustID)      REFERENCES customers(CustID)
FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID)

-- storageunits
FOREIGN KEY (WarehouseID) REFERENCES warehouses(WarehouseID)

-- joborders
FOREIGN KEY (CustID)      REFERENCES customers(CustID)

-- jobdetails
FOREIGN KEY (JobID)       REFERENCES joborders(JobID)
FOREIGN KEY (VehicleID)   REFERENCES vehicles(VehicleID)
FOREIGN KEY (DriverID)    REFERENCES drivers(DriverID)
```

---

## Composite Primary Keys

| Table | Columns | Rationale |
|---|---|---|
| `storageunits` | (UnitID, WarehouseID) | UnitID 1 exists in WA-1, OR-1, and WY-1 — the combination is unique |
| `unitrentals` | (CustID, WarehouseID, UnitID) | A specific customer rents a specific unit at a specific warehouse |
