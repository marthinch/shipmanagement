namespace ShipManagement.Repositories;

public interface IShipRepository : IBaseCRUDRepository
{
}

public class ShipRepository : BaseCRUDRepository, IShipRepository
{
    public ShipRepository(IDbConnectionFactory connectionFactory) : base(connectionFactory)
    {
    }
}