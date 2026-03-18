USE MovinOn_TeamNo;
GO

CREATE VIEW vw_EmployeeVesting AS
SELECT 
    EmpID,
    EmpFirst,
    EmpLast,
    StartDate,
    
    -- Hide End Date for active employees
    CASE 
        WHEN EndDate IS NULL THEN NULL 
        ELSE EndDate 
    END AS EndDate,
    
    -- Hide Review for inactive employees
    CASE 
        WHEN EndDate IS NOT NULL THEN NULL 
        ELSE Review 
    END AS Review,
    
    -- Calculate years of service
    DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE())) AS YearsOfService,
    
    -- Determine if they are vested
    CASE 
        WHEN EndDate IS NULL AND StartDate IS NOT NULL THEN 'Vested'
        ELSE 'Not Vested'
    END AS VestingMessage

FROM employees;
GO