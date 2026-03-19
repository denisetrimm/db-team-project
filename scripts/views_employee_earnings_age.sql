USE MovinOn_TeamNo;
GO

-- View: Employee annual earnings (salaried = Salary; hourly = HourlyRate * 2080), years of service, and age
IF OBJECT_ID('dbo.vw_EmployeeEarnings', 'V') IS NOT NULL
    DROP VIEW dbo.vw_EmployeeEarnings;
GO

CREATE VIEW dbo.vw_EmployeeEarnings AS
SELECT 
    EmpID,
    EmpFirst,
    EmpLast,
    WarehouseID,
    StartDate,
    EndDate,
    -- Annual salary: salaried employees use Salary; hourly use HourlyRate * 2080 (40 hrs * 52 weeks)
    CAST(
        COALESCE(Salary, HourlyRate * 2080) 
        AS DECIMAL(19,2)
    ) AS AnnualSalary,
    -- Years of service: from StartDate to EndDate or today
    DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE())) AS YearsOfService,
    -- Age: years between DOB and today
    DATEDIFF(YEAR, DOB, GETDATE()) AS Age
FROM employees;
GO
