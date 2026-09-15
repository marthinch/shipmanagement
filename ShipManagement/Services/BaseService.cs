namespace ShipManagement.Repositories;

public class BaseService<T> where T : class
{
    protected readonly ILogger<T> _logger;

    public BaseService(ILogger<T> logger)
    {
        _logger = logger;
    }
}