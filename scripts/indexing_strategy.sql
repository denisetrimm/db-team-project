USE MovinOn_TeamNo;
GO

-- Indexes on foreign key columns to optimize JOIN performance in views and reports
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_employees_WarehouseID')
    CREATE INDEX IX_employees_WarehouseID ON employees(WarehouseID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_employees_PositionID')
    CREATE INDEX IX_employees_PositionID ON employees(PositionID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_joborders_CustID')
    CREATE INDEX IX_joborders_CustID ON joborders(CustID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_unitrentals_WarehouseID')
    CREATE INDEX IX_unitrentals_WarehouseID ON unitrentals(WarehouseID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_jobdetails_DriverID')
    CREATE INDEX IX_jobdetails_DriverID ON jobdetails(DriverID);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_jobdetails_VehicleID')
    CREATE INDEX IX_jobdetails_VehicleID ON jobdetails(VehicleID);
GO

-- Indexes on columns frequently used in WHERE / ORDER BY for reports and date calculations
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_employees_State')
    CREATE INDEX IX_employees_State ON employees(State);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_employees_StartDate')
    CREATE INDEX IX_employees_StartDate ON employees(StartDate);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_unitrentals_DateIn')
    CREATE INDEX IX_unitrentals_DateIn ON unitrentals(DateIn);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_joborders_MoveDate')
    CREATE INDEX IX_joborders_MoveDate ON joborders(MoveDate);
GO

-- Covering index for the vesting view (StartDate + EndDate together)
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_employees_StartEnd')
    CREATE INDEX IX_employees_StartEnd ON employees(StartDate, EndDate);
GO
