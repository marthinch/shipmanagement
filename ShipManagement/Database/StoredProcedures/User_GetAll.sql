USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE User_GetAll
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @SortColumn VARCHAR(20) = 'Name',
    @SortDirection VARCHAR(4) = 'ASC',
    @Search VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    SELECT
        Id,
        Name,
        Role
    FROM Users
    ORDER BY Id
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY
END;
GO

--EXEC User_GetAll
--    @PageNumber = 1,
--    @PageSize = 20,
--    @SortColumn = 'Name',
--    @SortDirection = 'ASC';