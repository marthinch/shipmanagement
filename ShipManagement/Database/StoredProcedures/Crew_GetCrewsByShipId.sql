USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE Crew_GetCrewsByShipId
    @ShipId INT,
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
        c.Id,
        c.MemberId,
        c.Rank,
        c.FirstName,
        c.LastName,
        c.BirthDate,
        c.Nationality
    FROM Crews c
    INNER JOIN ShipCrews sc ON sc.CrewId = c.Id
    WHERE sc.ShipId = @ShipId
    ORDER BY Id
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY
END;
GO

--EXEC Crew_GetCrewsByShipId
--    @ShipId = 1,
--    @PageNumber = 1,
--    @PageSize = 20,
--    @SortColumn = 'FirstName',
--    @SortDirection = 'ASC';