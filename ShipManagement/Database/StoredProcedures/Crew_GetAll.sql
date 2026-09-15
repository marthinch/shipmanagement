USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE Crew_GetAll
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @SortColumn VARCHAR(20) = 'FirstName',
    @SortDirection VARCHAR(4) = 'ASC',
    @Search VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT
        Id,
        MemberId,
        Rank,
        FirstName,
        LastName,
        BirthDate,
        Nationality
    FROM Crews
    ORDER BY Id
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY
END;
GO

--EXEC Crew_GetAll
--    @PageNumber = 1,
--    @PageSize = 20,
--    @SortColumn = 'FirstName',
--    @SortDirection = 'ASC';