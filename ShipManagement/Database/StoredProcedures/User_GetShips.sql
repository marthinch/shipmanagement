USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE User_GetShips
    @UserId INT,
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
        s.Id,
        s.Code,
        s.Name,
        s.FiscalYear,
        s.Status
    FROM Ships s
    INNER JOIN ShipUsers su ON su.ShipId = s.Id
    WHERE su.UserId = @UserId
    ORDER BY s.Id
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY
END;
GO

--EXEC User_GetShips
--    @UserId = 1,
--    @PageNumber = 1,
--    @PageSize = 20,
--    @SortColumn = 'FirstName',
--    @SortDirection = 'ASC';