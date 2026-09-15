using System.ComponentModel.DataAnnotations;

namespace ShipManagement.DTOs;

public record ShipUser : IValidatableObject
{
    public int ShipId { get; set; }
    public int UserId { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (ShipId <= 0)
        {
            yield return new ValidationResult("Ship Id is invalid.", [nameof(ShipId)]);
        }

        if (UserId <= 0)
        {
            yield return new ValidationResult("User Id is invalid.", [nameof(UserId)]);
        }
    }
}