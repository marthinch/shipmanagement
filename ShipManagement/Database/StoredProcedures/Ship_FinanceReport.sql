USE ShipManagement;
GO

CREATE OR ALTER PROCEDURE Ship_FinanceReport
	@ShipId INT, 
	@AccountPeriod CHAR(7)
AS
BEGIN 
	SET NOCOUNT ON; 
	
	DECLARE 
	@FiscalCode CHAR(4), 
	@FiscalStartMonth INT,
	@SelectedDate DATE, 
	@FiscalYear INT,
	@FiscalYearStart DATE; 
	
	SELECT 
		@FiscalCode = FiscalYear 
	FROM Ships
	WHERE Id = @ShipId;
	
	SET @FiscalStartMonth = TRY_CONVERT(INT, LEFT(@FiscalCode, 2));
	SET @SelectedDate = TRY_CONVERT(DATE, @AccountPeriod + '-01');
	SET @FiscalYear = YEAR(@SelectedDate);
	SET @FiscalYearStart = DATEFROMPARTS (@FiscalYear, @FiscalStartMonth, 1); 

	IF MONTH(@SelectedDate) < @FiscalStartMonth 
		BEGIN SET @FiscalYear = @FiscalYear - 1; 
	END;
	
	;WITH AccountTree AS 
	(
		SELECT 
			a.Id AS AncestorId, 
			a.Id AS DescendantId 
		FROM Accounts a
		UNION ALL 
		
		SELECT 
			at.AncestorId, 
			child.Id AS DescendantId 
		FROM AccountTree at 
		INNER JOIN Accounts child ON child.ParentId = at.DescendantId 
	), 	
	
	MonthlyActual AS 
	( 
		SELECT 
			at.AncestorId AS AccountId, 
			SUM(t.Amount) AS Actual
		FROM AccountTree at 
		INNER JOIN Transactions t ON t.AccountId = at.DescendantId 
		WHERE t.ShipId = @ShipId 
			AND t.AccountPeriod = @AccountPeriod 
		GROUP BY at.AncestorId 
	),
	
	MonthlyBudget AS 
	( 
		SELECT 
			at.AncestorId AS AccountId, 
			SUM(b.Amount) AS Budget
		FROM AccountTree at 
		INNER JOIN Budgets b ON b.AccountId = at.DescendantId
		WHERE b.ShipId = @ShipId 
			AND b.AccountPeriod = @AccountPeriod 
		GROUP BY at.AncestorId 
	),
	
	YTDActual AS 
	(
		SELECT 
			at.AncestorId AS AccountId,
			SUM(t.Amount) AS Actual
		FROM AccountTree at 
		INNER JOIN Transactions t ON t.AccountId = at.DescendantId
		WHERE t.ShipId = @ShipId 
			AND t.AccountPeriod >= CONVERT(CHAR(7), @FiscalYearStart, 23) 
			AND t.AccountPeriod <= @AccountPeriod
		GROUP BY at.AncestorId 
	), 
	
	YTDBudget AS
	( 
		SELECT 
			at.AncestorId AS AccountId,
			SUM(b.Amount) AS Budget
		FROM AccountTree at 
		INNER JOIN Budgets b ON b.AccountId = at.DescendantId 
		WHERE b.ShipId = @ShipId 
			AND b.AccountPeriod >= CONVERT(CHAR(7), @FiscalYearStart, 23) 
			AND b.AccountPeriod <= @AccountPeriod 
		GROUP BY at.AncestorId 
	)
	
	SELECT 
		a.Description AS COADescription,
		a.Number AS AccountNumber, 
		ma.Actual AS Actual, 
		mb.Budget AS Budget,
		ma.Actual - mb.Budget AS Variance,
		ya.Actual AS ActualYTD, 
		yb.Budget AS BudgetYTD, 
		ya.Actual - yb.Budget VarianceYTD
	FROM Accounts a 
	LEFT JOIN MonthlyActual ma ON ma.AccountId = a.Id 
	LEFT JOIN MonthlyBudget mb ON mb.AccountId = a.Id 
	LEFT JOIN YTDActual ya ON ya.AccountId = a.Id 
	LEFT JOIN YTDBudget yb ON yb.AccountId = a.Id 
	WHERE ISNULL(ma.Actual, 0) <> 0 
		OR ISNULL(mb.Budget, 0) <> 0 
		OR ISNULL(ya.Actual, 0) <> 0 
		OR ISNULL(yb.Budget, 0) <> 0
	ORDER BY a.Number 
END;
GO

--EXEC Ship_FinanceReport
--	@ShipId = 1,
--	@AccountPeriod = '2026-01';