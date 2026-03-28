-- Question 5: 
-- What are the company's peak rental months?

USE MovinOn_TeamNo;
GO

CREATE VIEW vw_MonthlyRentalCounts AS
SELECT TOP 100 PERCENT
    DATENAME(month, DateIn) AS MonthName,
    MONTH(DateIn) AS MonthNumber,
    COUNT(*) AS TotalRentals
FROM unitrentals
GROUP BY DATENAME(month, DateIn), MONTH(DateIn)
ORDER BY TotalRentals DESC;
GO

-- To view the view
-- SELECT * FROM vw_MonthlyRentalCounts;