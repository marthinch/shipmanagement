using Microsoft.AspNetCore.Mvc;
using ShipManagement.DTOs;
using ShipManagement.Services;

namespace ShipManagement.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ShipsController : ControllerBase
{
    private readonly IShipService _shipService;

    public ShipsController(IShipService shipService)
    {
        _shipService = shipService;
    }

    [HttpGet]
    public async Task<ActionResult<IReadOnlyList<Ship>>> GetAll(CancellationToken cancellationToken)
    {
        var result = await _shipService.GetAllAsync(cancellationToken);
        return Ok(result);
    }

    [HttpPost]
    public async Task<ActionResult<int>> AddShip([FromBody] Ship ship, CancellationToken cancellationToken)
    {
        await _shipService.AddAsync(ship, cancellationToken);
        return Created();
    }

    [HttpPost("/api/Ships/User")]
    public async Task<ActionResult<int>> AssignUser([FromBody] ShipUser shipUser, CancellationToken cancellationToken)
    {
        await _shipService.AssignUserAsync(shipUser, cancellationToken);
        return Created();
    }

    [HttpGet("/api/Ships/{id:int}/Crews")]
    public async Task<ActionResult<IReadOnlyList<ShipFinanceReport>>> GetCrews([FromRoute] int id, CancellationToken cancellationToken)
    {
        var result = await _shipService.GetCrewsAsync(id, cancellationToken);
        return Ok(result);
    }

    [HttpGet("/api/Ships/{id:int}/FinanceReports/{accountPeriod}")]
    public async Task<ActionResult<IReadOnlyList<ShipFinanceReport>>> GetFinanceReport([FromRoute] int id, [FromRoute] string accountPeriod, CancellationToken cancellationToken)
    {
        var result = await _shipService.GetFinanceReportAsync(id, accountPeriod, cancellationToken);
        return Ok(result);
    }
}