USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE Crew_Add
(
    @MemberId CHAR(7),
    @Rank NVARCHAR(100),
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @BirthDate DATETIME2,
    @Nationality NVARCHAR(100),
    @CreatedBy NVARCHAR(100) = 'Admin'
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Crews
        (
            MemberId,
            Rank,
            FirstName,
            LastName,
            BirthDate,
            Nationality,
            CreatedDateTime,
            CreatedBy
        )
        VALUES
        (
            @MemberId,
            @Rank,
            @FirstName,
            @LastName,
            @BirthDate,
            @Nationality,
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