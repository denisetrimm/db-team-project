USE MovinOn_TeamNo;
GO

-- StorageRevenueReport: Income from storage units by warehouse, renter (last name), rent per unit,
-- total rent per warehouse, grand total. Includes years rented (one decimal).
IF OBJECT_ID('dbo.vw_StorageRevenueDetail', 'V') IS NOT NULL
    DROP VIEW dbo.vw_StorageRevenueDetail;
GO

CREATE VIEW dbo.vw_StorageRevenueDetail AS
SELECT 
    ur.WarehouseID,
    w.City AS WarehouseCity,
    c.ContactLast AS RenterLastName,
    c.ContactFirst AS RenterFirstName,
    su.UnitSize,
    su.Rent AS RentPerUnit,
    -- Years rented: DateIn to DateOut (or GETDATE() if still active), one decimal
    CAST(
        DATEDIFF(DAY, ur.DateIn, ISNULL(ur.DateOut, GETDATE())) / 365.0 
        AS DECIMAL(5,1)
    ) AS YearsRented
FROM unitrentals ur
INNER JOIN storageunits su ON su.UnitID = ur.UnitID AND su.WarehouseID = ur.WarehouseID
INNER JOIN customers c ON c.CustID = ur.CustID
INNER JOIN warehouses w ON w.WarehouseID = ur.WarehouseID
WHERE ur.DateOut IS NULL;  -- current rentals only for revenue (or include all for report - requirement says "rent per unit, total rent" so we show current rent revenue
GO

-- Stored procedure: StorageRevenueReport with $ formatting, warehouse subtotals, grand total
IF OBJECT_ID('dbo.StorageRevenueReport', 'P') IS NOT NULL
    DROP PROCEDURE dbo.StorageRevenueReport;
GO

CREATE PROCEDURE dbo.StorageRevenueReport
AS
BEGIN
    SET NOCOUNT ON;
    -- Detail with dollar formatting
    SELECT 
        WarehouseID,
        WarehouseCity,
        RenterLastName,
        RenterFirstName,
        UnitSize,
        '$' + FORMAT(RentPerUnit, 'N2') AS RentPerUnit,
        CAST(YearsRented AS VARCHAR(10)) AS YearsRented
    FROM dbo.vw_StorageRevenueDetail
    ORDER BY WarehouseID, RenterLastName;
    -- Subtotals by warehouse
    SELECT 
        WarehouseID,
        '$' + FORMAT(SUM(RentPerUnit), 'N2') AS TotalRentForWarehouse
    FROM dbo.vw_StorageRevenueDetail
    GROUP BY WarehouseID
    ORDER BY WarehouseID;
    -- Grand total
    SELECT '$' + FORMAT(SUM(RentPerUnit), 'N2') AS GrandTotalRent
    FROM dbo.vw_StorageRevenueDetail;
END;
GO
