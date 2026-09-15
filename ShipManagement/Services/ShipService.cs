using ShipManagement.DTOs;
using ShipManagement.Repositories;

namespace ShipManagement.Services;

public interface IShipService
{
    Task<IReadOnlyList<Ship>> GetAllAsync(Pagination pagination, CancellationToken cancellationToken);
    Task<int> AddAsync(Ship ship, CancellationToken cancellationToken);
    Task<int> AssignUserAsync(ShipUser shipUser, CancellationToken cancellationToken);
    Task<IReadOnlyList<Crew>> GetCrewsAsync(int id, CancellationToken cancellationToken);
    Task<IReadOnlyList<ShipFinanceReport>> GetFinanceReportAsync(int id, string accountPeriod, CancellationToken cancellationToken);
}

public class ShipService : BaseService<ShipService>, IShipService
{
    private readonly IShipRepository _shipRepository;
    private readonly ICrewRepository _crewRepository;
    private readonly IReportRepository _reportRepository;

    public ShipService(
        ILogger<ShipService> logger,
        IShipRepository shipRepository,
        ICrewRepository crewRepository,
        IReportRepository reportRepository) : base(logger)
    {
        _shipRepository = shipRepository;
        _crewRepository = crewRepository;
        _reportRepository = reportRepository;
    }

    public Task<IReadOnlyList<Ship>> GetAllAsync(Pagination pagination, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Get all ship");

        return _shipRepository.GetAllAsync<Ship>(pagination, cancellationToken);
    }

    public Task<int> AddAsync(Ship ship, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Add ship: {@ship}", ship);

        return _shipRepository.AddAsync(ship, cancellationToken);
    }

    public Task<int> AssignUserAsync(ShipUser shipUser, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Assign user: {@shipUser}", shipUser);

        return _shipRepository.AddAsync(shipUser, cancellationToken);
    }

    public Task<IReadOnlyList<Crew>> GetCrewsAsync(int id, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Get crews by ship id: {id}", id);

        return _crewRepository.GetCrewsAsync(id, cancellationToken);
    }

    public Task<IReadOnlyList<ShipFinanceReport>> GetFinanceReportAsync(int id, string accountPeriod, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Get finance report by ship id: {id} for period: {accountPeriod}", id, accountPeriod);

        return _reportRepository.GetFinanceReportAsync(id, accountPeriod, cancellationToken);
    }
}