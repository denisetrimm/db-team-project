-- Question 4: 
-- What is the average length of a rental period?

USE MovinOn_TeamNo;
GO

CREATE PROCEDURE sp_AverageRentalPeriod
AS
BEGIN
    SELECT AVG(DATEDIFF(DAY, DateIn, DateOut)) AS AverageRentalDays
    FROM unitrentals
    WHERE DateOut IS NOT NULL;
END;
GO

-- To execute the procedure
EXEC sp_AverageRentalPeriod;