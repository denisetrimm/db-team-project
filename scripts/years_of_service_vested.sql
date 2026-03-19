USE MovinOn_TeamNo;
GO

-- Drop if exists so script is re-runnable
IF OBJECT_ID('dbo.vw_EmployeeVesting', 'V') IS NOT NULL
    DROP VIEW dbo.vw_EmployeeVesting;
GO

-- View: Years of service, vesting (5+ years), and hide End Date for active / Review for inactive per requirements
CREATE VIEW vw_EmployeeVesting AS
SELECT 
    EmpID,
    EmpFirst,
    EmpLast,
    StartDate,
    -- For active employees hide End Date; for inactive display End Date
    CASE WHEN EndDate IS NULL THEN NULL ELSE EndDate END AS EndDate,
    -- For inactive employees hide Review; for active display Review
    CASE WHEN EndDate IS NOT NULL THEN NULL ELSE Review END AS Review,
    -- Years of service: from StartDate to EndDate (or today if active)
    DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE())) AS YearsOfService,
    -- Vested = years of service > 5 (and had a start date)
    CASE 
        WHEN StartDate IS NOT NULL AND DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE())) > 5 
        THEN 'Vested' 
        ELSE 'Not Vested' 
    END AS VestingMessage
FROM employees;
GO