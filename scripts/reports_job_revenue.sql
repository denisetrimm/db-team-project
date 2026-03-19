USE MovinOn_TeamNo;
GO

-- JobRevenueReport: Income from moving jobs.
-- Income = MileageActual*0.70 + WeightActual*0.20; Driver Payment = $50 + (MileageRate * MileageActual); Net = Income - Driver Payment.
IF OBJECT_ID('dbo.vw_JobRevenueDetail', 'V') IS NOT NULL
    DROP VIEW dbo.vw_JobRevenueDetail;
GO

CREATE VIEW dbo.vw_JobRevenueDetail AS
SELECT 
    jd.JobID,
    jo.MoveDate AS DateOfMove,
    d.DriverFirst + ' ' + d.DriverLast AS DriverName,
    d.MileageRate AS DriverRate,
    jd.MileageActual,
    jd.WeightActual,
    CAST((jd.MileageActual * 0.70 + jd.WeightActual * 0.20) AS DECIMAL(19,2)) AS Income,
    CAST(50 + (d.MileageRate * jd.MileageActual) AS DECIMAL(19,2)) AS DriverPayment,
    CAST((jd.MileageActual * 0.70 + jd.WeightActual * 0.20) - (50 + d.MileageRate * jd.MileageActual) AS DECIMAL(19,2)) AS NetIncome
FROM jobdetails jd
INNER JOIN joborders jo ON jo.JobID = jd.JobID
INNER JOIN drivers d ON d.DriverID = jd.DriverID;
GO

-- Stored procedure: JobRevenueReport with totals (total income, total driver payments, total net income)
IF OBJECT_ID('dbo.JobRevenueReport', 'P') IS NOT NULL
    DROP PROCEDURE dbo.JobRevenueReport;
GO

CREATE PROCEDURE dbo.JobRevenueReport
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        JobID,
        DateOfMove,
        DriverName,
        DriverRate,
        MileageActual,
        WeightActual,
        '$' + FORMAT(Income, 'N2') AS Income,
        '$' + FORMAT(DriverPayment, 'N2') AS DriverPayment,
        '$' + FORMAT(NetIncome, 'N2') AS NetIncome
    FROM dbo.vw_JobRevenueDetail;
    -- Summary row
    SELECT 
        '$' + FORMAT(SUM(Income), 'N2') AS TotalIncome,
        '$' + FORMAT(SUM(DriverPayment), 'N2') AS TotalDriverPayments,
        '$' + FORMAT(SUM(NetIncome), 'N2') AS TotalNetIncome
    FROM dbo.vw_JobRevenueDetail;
END;
GO
