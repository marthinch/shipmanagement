namespace ShipManagement.Repositories;

public class BaseRepository
{
    protected readonly IDbConnectionFactory _connectionFactory;

    public BaseRepository(IDbConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }
}