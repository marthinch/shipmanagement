USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE ShipUser_Add
(
    @ShipId INT,
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO ShipUsers
        (
            ShipId,
            UserId
        )
        VALUES
        (
            @ShipId,
            @UserId
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO