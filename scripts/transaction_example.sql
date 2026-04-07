USE MovinOn_TeamNo;
GO

-- Transaction: Record a complete moving job (order + detail + customer balance update) atomically.
-- If any step fails, the entire operation is rolled back to preserve data consistency.
DECLARE @NewJobID INT = 30;
DECLARE @CustID INT = 1;
DECLARE @DriverID INT = 2;
DECLARE @VehicleID VARCHAR(10) = 'TRK-002';
DECLARE @MileageActual INT = 95;
DECLARE @WeightActual INT = 3200;
DECLARE @JobCost DECIMAL(19,2);

SET @JobCost = @MileageActual * 0.70 + @WeightActual * 0.20;

BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO joborders (JobID, CustID, MoveDate, FromAddress, FromCity, FromState,
                           ToAddress, ToCity, ToState, DistanceEst, WeightEst, Packing, Heavy, Storage)
    VALUES (@NewJobID, @CustID, GETDATE(), '500 Main St', 'Seattle', 'WA',
            '1200 Oak Ave', 'Tacoma', 'WA', 90, 3000, 1, 1, 0);

    INSERT INTO jobdetails (JobID, VehicleID, DriverID, MileageActual, WeightActual)
    VALUES (@NewJobID, @VehicleID, @DriverID, @MileageActual, @WeightActual);

    UPDATE customers
    SET Balance = Balance + @JobCost
    WHERE CustID = @CustID;

    COMMIT TRANSACTION;
    PRINT 'Transaction committed. Job ' + CAST(@NewJobID AS VARCHAR) + ' recorded. Customer balance updated by $' + CAST(@JobCost AS VARCHAR);
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back due to error:';
    PRINT ERROR_MESSAGE();
END CATCH
GO

-- Clean up: remove the test data so the script can be re-run or the demo data stays clean
-- DELETE FROM jobdetails WHERE JobID = 30;
-- DELETE FROM joborders WHERE JobID = 30;
-- UPDATE customers SET Balance = 0 WHERE CustID = 1;
