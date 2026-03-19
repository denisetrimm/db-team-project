USE MovinOn_TeamNo;
GO

-- Trigger: Validate employee Phone and Cell area codes for Oregon, Washington, and Wyoming.
-- OR: 541, 503, 971; WA: 425, 360, 206, 509, 253; WY: 307. Other states are allowed.
IF OBJECT_ID('dbo.tr_Employee_ValidateAreaCode', 'TR') IS NOT NULL
    DROP TRIGGER dbo.tr_Employee_ValidateAreaCode;
GO

CREATE TRIGGER dbo.tr_Employee_ValidateAreaCode
ON dbo.employees
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @State VARCHAR(2), @Phone VARCHAR(15), @Cell VARCHAR(15), @AreaPhone VARCHAR(3), @AreaCell VARCHAR(3);

    DECLARE ac2 CURSOR LOCAL FAST_FORWARD FOR
    SELECT State, Phone, Cell FROM inserted;

    OPEN ac2;
    FETCH NEXT FROM ac2 INTO @State, @Phone, @Cell;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @AreaPhone = NULL;
        SET @AreaCell = NULL;
        -- Extract first 3 digits (strip spaces, dashes, parentheses)
        IF LEN(REPLACE(REPLACE(REPLACE(REPLACE(@Phone, ' ', ''), '-', ''), '(', ''), ')', '')) >= 3
            SET @AreaPhone = LEFT(REPLACE(REPLACE(REPLACE(REPLACE(@Phone, ' ', ''), '-', ''), '(', ''), ')', ''), 3);
        IF LEN(REPLACE(REPLACE(REPLACE(REPLACE(@Cell, ' ', ''), '-', ''), '(', ''), ')', '')) >= 3
            SET @AreaCell = LEFT(REPLACE(REPLACE(REPLACE(REPLACE(@Cell, ' ', ''), '-', ''), '(', ''), ')', ''), 3);

        IF @State = 'OR'
        BEGIN
            IF @AreaPhone IS NOT NULL AND @AreaPhone NOT IN ('541','503','971')
                RAISERROR('OR phone area codes should be 541, 503, or 971', 16, 1);
            IF @AreaCell IS NOT NULL AND @AreaCell NOT IN ('541','503','971')
                RAISERROR('OR phone area codes should be 541, 503, or 971', 16, 1);
        END
        ELSE IF @State = 'WA'
        BEGIN
            IF @AreaPhone IS NOT NULL AND @AreaPhone NOT IN ('425','360','206','509','253')
                RAISERROR('WA phone area codes should be 425, 360, 206, 509, or 253', 16, 1);
            IF @AreaCell IS NOT NULL AND @AreaCell NOT IN ('425','360','206','509','253')
                RAISERROR('WA phone area codes should be 425, 360, 206, 509, or 253', 16, 1);
        END
        ELSE IF @State = 'WY'
        BEGIN
            IF @AreaPhone IS NOT NULL AND @AreaPhone <> '307'
                RAISERROR('WY phone area codes should be 307', 16, 1);
            IF @AreaCell IS NOT NULL AND @AreaCell <> '307'
                RAISERROR('WY phone area codes should be 307', 16, 1);
        END

        FETCH NEXT FROM ac2 INTO @State, @Phone, @Cell;
    END;
    CLOSE ac2;
    DEALLOCATE ac2;
END;
GO
