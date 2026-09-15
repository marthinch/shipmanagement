using System.ComponentModel.DataAnnotations;

namespace ShipManagement.DTOs;

public record Ship : IValidatableObject
{
    [Required(ErrorMessage = "Code is required.")]
    [StringLength(5, ErrorMessage = "Code cannot exceed 5 characters.")]
    public string Code { get; set; }

    [Required(ErrorMessage = "Name is required.")]
    [StringLength(100, ErrorMessage = "Name cannot exceed 100 characters.")]
    public string Name { get; set; }

    [Required(ErrorMessage = "Fiscal Year is required.")]
    [StringLength(4, ErrorMessage = "Fiscal Year cannot exceed 4 characters.")]
    public string FiscalYear { get; set; }

    public bool Status { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (string.IsNullOrWhiteSpace(Code))
        {
            yield return new ValidationResult("Code is required.", [nameof(Code)]);
        }

        if (string.IsNullOrWhiteSpace(Name))
        {
            yield return new ValidationResult("Name is required.", [nameof(Name)]);
        }

        if (string.IsNullOrWhiteSpace(FiscalYear))
        {
            yield return new ValidationResult("Fiscal Year is required.", [nameof(FiscalYear)]);
        }
    }
}