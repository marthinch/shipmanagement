using ShipManagement.DTOs;
using ShipManagement.Repositories;

namespace ShipManagement.Services;

public interface IUserService
{
    Task<IReadOnlyList<User>> GetAllAsync(CancellationToken cancellationToken);
    Task<int> AddAsync(User user, CancellationToken cancellationToken);

    Task<IReadOnlyList<Ship>> GetShipsAsync(int id, CancellationToken cancellationToken);
}

public class UserService : BaseService<UserService>, IUserService
{
    private readonly IUserRepository _userRepository;

    public UserService(ILogger<UserService> logger, IUserRepository userRepository) : base(logger)
    {
        _userRepository = userRepository;
    }

    public Task<IReadOnlyList<User>> GetAllAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("Get all user");

        return _userRepository.GetAllAsync<User>(cancellationToken);
    }

    public Task<int> AddAsync(User user, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Add user: {@user}", user);

        return _userRepository.AddAsync(user, cancellationToken);
    }

    public Task<IReadOnlyList<Ship>> GetShipsAsync(int id, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Get ships by user id: {id}", id);

        return _userRepository.GetShipsAsync(id, cancellationToken);
    }
}