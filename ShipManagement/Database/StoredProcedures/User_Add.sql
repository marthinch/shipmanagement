USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE User_Add
(
    @Name NVARCHAR(100),
    @Role NVARCHAR(100),
    @CreatedBy NVARCHAR(100) = 'Admin'
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Users
        (
            Name,
            Role,
            CreatedDateTime,
            CreatedBy
        )
        VALUES
        (
            @Name,
            @Role,
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