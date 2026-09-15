using Dapper;
using ShipManagement.DTOs;
using System.Data;

namespace ShipManagement.Repositories;

public interface IReportRepository
{
    Task<IReadOnlyList<ShipFinanceReport>> GetFinanceReportAsync(int shipId, string accountPeriod, CancellationToken cancellationToken);
}

public class ReportRepository : BaseRepository, IReportRepository
{
    public ReportRepository(IDbConnectionFactory connectionFactory) : base(connectionFactory)
    {
    }

    public async Task<IReadOnlyList<ShipFinanceReport>> GetFinanceReportAsync(int shipId, string accountPeriod, CancellationToken cancellationToken)
    {
        using var connection = _connectionFactory.CreateConnection();

        var command = new CommandDefinition(
            "Ship_FinanceReport",
            new
            {
                ShipId = shipId,
                AccountPeriod = accountPeriod
            },
            commandType: CommandType.StoredProcedure,
            cancellationToken: cancellationToken);

        var result = await connection.QueryAsync<ShipFinanceReport>(command);

        return result.AsList();
    }
}