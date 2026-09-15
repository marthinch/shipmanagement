using System.ComponentModel.DataAnnotations;

namespace ShipManagement.DTOs;

public record Crew : IValidatableObject
{
    [Required(ErrorMessage = "Member Id is required.")]
    [StringLength(7, ErrorMessage = "Member Id cannot exceed 7 characters.")]
    public string MemberId { get; set; }

    [Required(ErrorMessage = "Rank is required.")]
    [StringLength(100, ErrorMessage = "Rank cannot exceed 100 characters.")]
    public string Rank { get; set; }

    [Required(ErrorMessage = "First name is required.")]
    [StringLength(100, ErrorMessage = "First name cannot exceed 100 characters.")]
    public string FirstName { get; set; }

    [Required(ErrorMessage = "Last name is required.")]
    [StringLength(100, ErrorMessage = "Last name cannot exceed 100 characters.")]
    public string LastName { get; set; }

    [Required(ErrorMessage = "Birth date is required.")]
    public DateTime BirthDate { get; set; }

    [Required(ErrorMessage = "Nationality is required.")]
    [StringLength(100, ErrorMessage = "Nationality cannot exceed 100 characters.")]
    public string Nationality { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (string.IsNullOrWhiteSpace(MemberId))
        {
            yield return new ValidationResult("Member Id is required.", [nameof(MemberId)]);
        }

        if (string.IsNullOrWhiteSpace(Rank))
        {
            yield return new ValidationResult("Rank is required.", [nameof(Rank)]);
        }

        if (string.IsNullOrWhiteSpace(FirstName))
        {
            yield return new ValidationResult("First Name is required.", [nameof(FirstName)]);
        }

        if (string.IsNullOrWhiteSpace(LastName))
        {
            yield return new ValidationResult("Last Name is required.", [nameof(LastName)]);
        }

        if (BirthDate.Date >= DateTime.UtcNow.Date)
        {
            yield return new ValidationResult("Birth Date cannot be in the future.", [nameof(BirthDate)]);
        }

        if (string.IsNullOrWhiteSpace(Nationality))
        {
            yield return new ValidationResult("Nationality is required.", [nameof(Nationality)]);
        }
    }
}