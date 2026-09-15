using Dapper;
using ShipManagement.DTOs;
using System.Data;

namespace ShipManagement.Repositories;

public interface ICrewRepository : IBaseCRUDRepository
{
    Task<IReadOnlyList<Crew>> GetCrewsAsync(int shipId, CancellationToken cancellationToken);
}

public class CrewRepository : BaseCRUDRepository, ICrewRepository
{
    public CrewRepository(IDbConnectionFactory connectionFactory) : base(connectionFactory)
    {
    }

    public async Task<IReadOnlyList<Crew>> GetCrewsAsync(int shipId, CancellationToken cancellationToken)
    {
        using var connection = _connectionFactory.CreateConnection();

        var command = new CommandDefinition(
            "Crew_GetCrewsByShipId",
            new { ShipId = shipId },
            commandType: CommandType.StoredProcedure,
            cancellationToken: cancellationToken);

        var result = await connection.QueryAsync<Crew>(command);

        return result.AsList();
    }
}