using Microsoft.AspNetCore.Mvc;
using ShipManagement.DTOs;
using ShipManagement.Services;

namespace ShipManagement.Controllers;

[Route("api/[controller]")]
[ApiController]
public class CrewsController : ControllerBase
{
    private readonly ICrewService _crewService;

    public CrewsController(ICrewService crewService)
    {
        _crewService = crewService;
    }

    [HttpGet]
    public async Task<ActionResult<IReadOnlyList<Crew>>> GetAll(
        [FromQuery] int pageNumber,
        [FromQuery] int pageSize,
        [FromQuery] string sortColumn,
        [FromQuery] string sortDirection,
        [FromQuery] string search,
        CancellationToken cancellationToken)
    {
        var result = await _crewService.GetAllAsync(new Pagination
        {
            PageNumber = pageNumber,
            PageSize = pageSize,
            SortColumn = sortColumn,
            SortDirection = sortDirection,
            Search = search
        }, cancellationToken);
        return Ok(result);
    }

    [HttpPost]
    public async Task<ActionResult<int>> Add([FromBody] Crew crew, CancellationToken cancellationToken)
    {
        await _crewService.AddAsync(crew, cancellationToken);
        return Created();
    }
}