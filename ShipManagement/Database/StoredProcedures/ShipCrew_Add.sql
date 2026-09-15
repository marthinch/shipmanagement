USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE ShipCrew_Add
(
    @ShipId INT,
    @CrewId INT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO ShipCrews
        (
            ShipId,
            Crew
        )
        VALUES
        (
            @ShipId,
            @CrewId
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