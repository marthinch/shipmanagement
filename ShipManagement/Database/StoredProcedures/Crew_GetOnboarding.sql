USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE Crew_GetOnboarding
    @PageNumber INT = 1,
    @PageSize INT = 20,
    @SortColumn VARCHAR(20) = 'FirstName',
    @SortDirection VARCHAR(4) = 'ASC',
    @Search VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    WITH CrewData AS
    (
        SELECT
            c.Id,
            c.Rank,
            c.FirstName,
            c.LastName,
            c.BirthDate,
            c.Nationality,
            s.SignOnDate,
            (
                CASE
                    WHEN s.SignOffDate IS NOT NULL THEN 'Signed Off'
                
                    WHEN s.SignOnDate <= CAST(GETDATE() AS DATE) 
                        AND s.SignOffDate IS NULL 
                        AND s.EndOfContractDate < DATEADD(DAY, -30, CAST(GETDATE() AS DATE)) THEN 'Relief Due'
            
                    WHEN s.SignOnDate > CAST(GETDATE() AS DATE) THEN 'Planned'

                    WHEN s.SignOnDate <= CAST(GETDATE() AS DATE)
                         AND s.SignOffDate IS NULL
                         AND s.EndOfContractDate >= CAST(GETDATE() AS DATE) THEN 'Onboard'

                    ELSE 'Unknown'
                END
            ) AS CrewStatus
        FROM Crews c
        INNER JOIN Services s ON s.CrewId = c.Id
    )

    SELECT
        Id,
        Rank,
        FirstName,
        LastName,
        BirthDate,
        Nationality,
        SignOnDate,
        CrewStatus AS Status
    FROM CrewData
    WHERE
        @Search IS NULL
        OR Rank LIKE '%' + @Search + '%'
        OR FirstName LIKE '%' + @Search + '%'
        OR LastName LIKE '%' + @Search + '%'
        OR FORMAT(BirthDate, 'dd MMM yyyy') LIKE '%' + @Search + '%'
        OR Nationality LIKE '%' + @Search + '%'
        OR FORMAT(SignOnDate, 'dd MMM yyyy') LIKE '%' + @Search + '%'
    ORDER BY
        CASE
            WHEN @SortDirection = 'ASC' AND @SortColumn = 'Rank' THEN Rank END ASC,
         CASE
            WHEN @SortDirection = 'ASC' AND @SortColumn = 'FirstName' THEN FirstName END ASC,
        CASE
            WHEN @SortDirection = 'ASC' AND @SortColumn = 'LastName' THEN LastName END ASC,
        CASE
            WHEN @SortDirection = 'ASC' AND @SortColumn = 'Nationality' THEN Nationality END ASC,
        CASE
            WHEN @SortDirection = 'ASC' AND @SortColumn = 'SignOnDate' THEN SignOnDate END ASC,
        CASE
            WHEN @SortDirection = 'ASC' AND @SortColumn = 'Status' THEN CrewStatus END ASC,

        CASE
            WHEN @SortDirection = 'DESC' AND @SortColumn = 'Rank' THEN Rank END DESC,
         CASE
            WHEN @SortDirection = 'DESC' AND @SortColumn = 'FirstName' THEN FirstName END DESC,
        CASE
            WHEN @SortDirection = 'DESC' AND @SortColumn = 'LastName' THEN LastName END DESC,
        CASE
            WHEN @SortDirection = 'DESC' AND @SortColumn = 'Nationality' THEN Nationality END DESC,
        CASE
            WHEN @SortDirection = 'DESC' AND @SortColumn = 'SignOnDate' THEN SignOnDate END DESC,
        CASE
            WHEN @SortDirection = 'DESC' AND @SortColumn = 'Status' THEN CrewStatus END DESC,
        Id ASC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY
END;
GO

--EXEC Crew_GetOnboarding
--    @PageNumber = 1,
--    @PageSize = 20,
--    @SortColumn = 'FirstName',
--    @SortDirection = 'ASC';