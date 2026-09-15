USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE Ship_GetAll
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @SortColumn VARCHAR(20) = 'Name',
    @SortDirection VARCHAR(4) = 'ASC',
    @Search VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Code,
        Name,
        FiscalYear,
        Status
    FROM Ships
END;
GO

--EXEC Ship_GetAll
--    @PageNumber = 1,
--    @PageSize = 20,
--    @SortColumn = 'Name',
--    @SortDirection = 'ASC';