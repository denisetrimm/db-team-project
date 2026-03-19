USE MovinOn_TeamNo;
GO

-- ========== FAQ 1: How many storage units did the company rent last year? (Scalar function)
IF OBJECT_ID('dbo.fn_StorageUnitsRentedLastYear', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_StorageUnitsRentedLastYear;
GO

CREATE FUNCTION dbo.fn_StorageUnitsRentedLastYear()
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    -- "Rented last year" = count of unit rentals active at some time during last calendar year
    SELECT @Count = COUNT(*)
    FROM unitrentals
    WHERE DateIn <= DATEFROMPARTS(YEAR(GETDATE()) - 1, 12, 31)
      AND (DateOut IS NULL OR DateOut >= DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1));
    RETURN @Count;
END;
GO

-- ========== FAQ 2: What percentage of customers have rented at least one unit? (Function)
IF OBJECT_ID('dbo.fn_PercentCustomersWithRental', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_PercentCustomersWithRental;
GO

CREATE FUNCTION dbo.fn_PercentCustomersWithRental()
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @TotalCustomers INT, @CustomersWithRental INT;
    SELECT @TotalCustomers = COUNT(*) FROM customers;
    SELECT @CustomersWithRental = COUNT(DISTINCT CustID) FROM unitrentals;
    IF @TotalCustomers = 0 RETURN 0;
    RETURN CAST(@CustomersWithRental * 100.0 / @TotalCustomers AS DECIMAL(5,2));
END;
GO

-- ========== FAQ 3: What was the greatest number of rents by an individual? (Stored procedure)
IF OBJECT_ID('dbo.sp_GreatestRentsByIndividual', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_GreatestRentsByIndividual;
GO

CREATE PROCEDURE dbo.sp_GreatestRentsByIndividual
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP 1
        c.CustID,
        c.ContactFirst + ' ' + c.ContactLast AS CustomerName,
        COUNT(*) AS NumberOfRentals
    FROM unitrentals ur
    INNER JOIN customers c ON c.CustID = ur.CustID
    GROUP BY c.CustID, c.ContactFirst, c.ContactLast
    ORDER BY COUNT(*) DESC;
END;
GO

-- ========== FAQ 4: What is the average length of a rental period? (View)
IF OBJECT_ID('dbo.vw_AverageRentalPeriod', 'V') IS NOT NULL
    DROP VIEW dbo.vw_AverageRentalPeriod;
GO

CREATE VIEW dbo.vw_AverageRentalPeriod AS
SELECT 
    AVG(
        DATEDIFF(DAY, DateIn, ISNULL(DateOut, GETDATE())) * 1.0 / 365
    ) AS AvgRentalPeriodYears,
    AVG(DATEDIFF(DAY, DateIn, ISNULL(DateOut, GETDATE()))) AS AvgRentalPeriodDays
FROM unitrentals;
GO

-- ========== FAQ 5: What are the company's peak rental months? (View)
IF OBJECT_ID('dbo.vw_PeakRentalMonths', 'V') IS NOT NULL
    DROP VIEW dbo.vw_PeakRentalMonths;
GO

CREATE VIEW dbo.vw_PeakRentalMonths AS
SELECT TOP 12
    YEAR(DateIn) AS RentalYear,
    MONTH(DateIn) AS RentalMonth,
    DATENAME(MONTH, DateIn) AS MonthName,
    COUNT(*) AS RentalsStarted
FROM unitrentals
GROUP BY YEAR(DateIn), MONTH(DateIn), DATENAME(MONTH, DateIn)
ORDER BY COUNT(*) DESC;
GO
