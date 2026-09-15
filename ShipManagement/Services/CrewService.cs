using ShipManagement.DTOs;
using ShipManagement.Repositories;

namespace ShipManagement.Services;

public interface ICrewService
{
    Task<IReadOnlyList<Crew>> GetAllAsync(Pagination pagination, CancellationToken cancellationToken);
    Task<int> AddAsync(Crew crew, CancellationToken cancellationToken);
}

public class CrewService : BaseService<CrewService>, ICrewService
{
    private readonly ICrewRepository _crewRepository;

    public CrewService(ILogger<CrewService> logger, ICrewRepository crewRepository) : base(logger)
    {
        _crewRepository = crewRepository;
    }

    public Task<IReadOnlyList<Crew>> GetAllAsync(Pagination pagination, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Get all crew");

        return _crewRepository.GetAllAsync<Crew>(pagination, cancellationToken);
    }

    public Task<int> AddAsync(Crew crew, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Add crew: {@crew}", crew);

        return _crewRepository.AddAsync(crew, cancellationToken);
    }
}