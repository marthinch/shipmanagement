using Microsoft.AspNetCore.Mvc;
using ShipManagement.DTOs;
using ShipManagement.Services;

namespace ShipManagement.Controllers;

[Route("api/[controller]")]
[ApiController]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;

    public UsersController(IUserService userService)
    {
        _userService = userService;
    }

    [HttpGet]
    public async Task<ActionResult<IReadOnlyList<User>>> GetAll(
        [FromQuery] int pageNumber,
        [FromQuery] int pageSize,
        [FromQuery] string sortColumn,
        [FromQuery] string sortDirection,
        [FromQuery] string search, 
        CancellationToken cancellationToken)
    {
        var result = await _userService.GetAllAsync(new Pagination
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
    public async Task<ActionResult<int>> Add([FromBody] User crew, CancellationToken cancellationToken)
    {
        await _userService.AddAsync(crew, cancellationToken);
        return Created();
    }

    [HttpGet("/api/Users/{id:int}/Ships")]
    public async Task<ActionResult<IReadOnlyList<Ship>>> GetShips([FromRoute] int id, CancellationToken cancellationToken)
    {
        var result = await _userService.GetShipsAsync(id, cancellationToken);
        return Ok(result);
    }
}