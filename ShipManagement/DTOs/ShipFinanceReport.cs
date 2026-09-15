namespace ShipManagement.DTOs;

public class ShipFinanceReport
{
    public string COADescription { get; set; }
    public string AccountNumber { get; set; }
    public decimal Actual { get; set; }
    public decimal Budget { get; set; }
    public decimal Variance { get; set; }
    public decimal ActualYTD { get; set; }
    public decimal BudgetYTD { get; set; }
    public decimal VarianceYTD { get; set; }
}