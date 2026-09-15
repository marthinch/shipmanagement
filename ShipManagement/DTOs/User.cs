using System.ComponentModel.DataAnnotations;

namespace ShipManagement.DTOs;

public record User : IValidatableObject
{
    [Required(ErrorMessage = "Name is required.")]
    [StringLength(100, ErrorMessage = "Name cannot exceed 100 characters.")]
    public string Name { get; set; }

    [Required(ErrorMessage = "Role is required.")]
    [StringLength(10, ErrorMessage = "Role cannot exceed 10 characters.")]
    public string Role { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (string.IsNullOrWhiteSpace(Name))
        {
            yield return new ValidationResult("Name is required.", [nameof(Name)]);
        }

        if (string.IsNullOrWhiteSpace(Role))
        {
            yield return new ValidationResult("Role is required.", [nameof(Role)]);
        }
    }
}