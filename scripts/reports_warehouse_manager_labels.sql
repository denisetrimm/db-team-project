USE MovinOn_TeamNo;
GO

-- WarehouseManagerReportLabels: Mailing labels for warehouse managers.
-- Kristina can indicate which warehouse before printing. Label includes warehouse number, manager name, mailing info.
IF OBJECT_ID('dbo.WarehouseManagerReportLabels', 'P') IS NOT NULL
    DROP PROCEDURE dbo.WarehouseManagerReportLabels;
GO

CREATE PROCEDURE dbo.WarehouseManagerReportLabels
    @WarehouseID VARCHAR(5) = NULL   -- NULL = all warehouses
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        w.WarehouseID AS WarehouseNumber,
        e.EmpFirst + ' ' + e.EmpLast AS ManagerName,
        e.Address,
        e.City,
        e.State,
        e.ZIP,
        w.Phone AS WarehousePhone
    FROM warehouses w
    INNER JOIN employees e ON e.WarehouseID = w.WarehouseID
    INNER JOIN positions p ON p.PositionID = e.PositionID AND p.Title = 'Manager'
    WHERE e.EndDate IS NULL
      AND (@WarehouseID IS NULL OR w.WarehouseID = @WarehouseID)
    ORDER BY w.WarehouseID;
END;
GO
