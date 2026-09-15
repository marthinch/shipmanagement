using Dapper;
using ShipManagement.DTOs;
using System.Data;

namespace ShipManagement.Repositories;

public interface IBaseCRUDRepository
{
    Task<int> AddAsync<T>(T request, CancellationToken cancellationToken) where T : class;
    Task<IReadOnlyList<T>> GetAllAsync<T>(Pagination pagination, CancellationToken cancellationToken) where T : class;
}

public class BaseCRUDRepository : BaseRepository, IBaseCRUDRepository
{
    public BaseCRUDRepository(IDbConnectionFactory connectionFactory) : base(connectionFactory)
    {
    }

    public async Task<int> AddAsync<T>(T request, CancellationToken cancellationToken) where T : class
    {
        using var connection = _connectionFactory.CreateConnection();

        var storedProcedure = $"{typeof(T).Name}_Add";

        var command = new CommandDefinition(
            storedProcedure,
            request,
            commandType: CommandType.StoredProcedure,
            cancellationToken: cancellationToken);

        return await connection.ExecuteScalarAsync<int>(command);
    }

    public async Task<IReadOnlyList<T>> GetAllAsync<T>(Pagination pagination, CancellationToken cancellationToken) where T : class
    {
        using var connection = _connectionFactory.CreateConnection();

        var storedProcedure = $"{typeof(T).Name}_GetAll";

        var command = new CommandDefinition(
            storedProcedure,
            pagination,
            commandType: CommandType.StoredProcedure,
            cancellationToken: cancellationToken);

        var result = await connection.QueryAsync<T>(command);

        return result.AsList();
    }
}