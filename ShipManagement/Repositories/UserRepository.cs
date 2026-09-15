using Dapper;
using ShipManagement.DTOs;
using System.Data;

namespace ShipManagement.Repositories;

public interface IUserRepository : IBaseCRUDRepository
{
    Task<IReadOnlyList<Ship>> GetShipsAsync(int id, CancellationToken cancellationToken);
}

public class UserRepository : BaseCRUDRepository, IUserRepository
{
    public UserRepository(IDbConnectionFactory connectionFactory) : base(connectionFactory)
    {
    }

    public async Task<IReadOnlyList<Ship>> GetShipsAsync(int id, CancellationToken cancellationToken)
    {
        using var connection = _connectionFactory.CreateConnection();

        var command = new CommandDefinition(
            "User_GetShips",
            new { UserId = id },
            commandType: CommandType.StoredProcedure,
            cancellationToken: cancellationToken);

        var result = await connection.QueryAsync<Ship>(command);

        return result.AsList();
    }
}