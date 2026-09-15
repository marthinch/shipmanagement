USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE Ship_Add
(
    @Code CHAR(5),
    @Name NVARCHAR(100),
    @FiscalYear CHAR(4),
    @Status BIT,
    @CreatedBy NVARCHAR(100) = 'Admin'
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Ships
        (
            Code,
            Name,
            FiscalYear,
            Status,
            CreatedDateTime,
            CreatedBy
        )
        VALUES
        (
            @Code,
            @Name,
            @FiscalYear,
            @Status,
            SYSDATETIME(),
            @CreatedBy
        );

        -- Return the newly created id
        DECLARE @Id INT = CAST(SCOPE_IDENTITY() AS INT);

        COMMIT TRANSACTION;

        SELECT @Id;
    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO