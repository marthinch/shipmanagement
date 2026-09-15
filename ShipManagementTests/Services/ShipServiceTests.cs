using Microsoft.Extensions.Logging;
using Moq;
using ShipManagement.DTOs;
using ShipManagement.Repositories;
using ShipManagement.Services;

namespace ShipManagementTests.Services;

public class ShipServiceTests
{
    private readonly Mock<ILogger<ShipService>> _loggerMock;
    private readonly Mock<IShipRepository> _shipRepositoryMock;
    private readonly Mock<ICrewRepository> _crewRepositoryMock;
    private readonly Mock<IReportRepository> _reportRepositoryMock;

    private readonly ShipService _service;

    public ShipServiceTests()
    {
        _loggerMock = new Mock<ILogger<ShipService>>();
        _shipRepositoryMock = new Mock<IShipRepository>();
        _crewRepositoryMock = new Mock<ICrewRepository>();
        _reportRepositoryMock = new Mock<IReportRepository>();

        _service = new ShipService(
            _loggerMock.Object,
            _shipRepositoryMock.Object,
            _crewRepositoryMock.Object,
            _reportRepositoryMock.Object);
    }

    [Fact]
    public async Task GetAllAsync_ShouldReturnShips()
    {
        // Arrange
        var ships = new List<Ship>
        {
            new()
            {
                Code = "S0001",
                Name = "MV Pacific Star",
                FiscalYear = "2026",
                Status = true
            },
            new()
            {
                Code = "S0002",
                Name = "MV Ocean Pearl",
                FiscalYear = "2026",
                Status = true
            }
        };

        _shipRepositoryMock
            .Setup(x => x.GetAllAsync<Ship>(It.IsAny<CancellationToken>()))
            .ReturnsAsync(ships);

        // Act
        var result = await _service.GetAllAsync(CancellationToken.None);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(2, result.Count);

        Assert.Equal("S0001", result[0].Code);
        Assert.Equal("MV Pacific Star", result[0].Name);

        _shipRepositoryMock.Verify(
            x => x.GetAllAsync<Ship>(It.IsAny<CancellationToken>()),
            Times.Once);
    }

    [Fact]
    public async Task AddAsync_ShouldAddNewShip()
    {
        // Arrange
        var ship = new Ship
        {
            Code = "S0001",
            Name = "MV Pacific Star",
            FiscalYear = "2026",
            Status = true
        };

        // Act
        var result = await _service.AddAsync(ship, CancellationToken.None);

        // Assert
        Assert.Equal(0, result);

        _shipRepositoryMock.Verify(
            x => x.AddAsync(ship, It.IsAny<CancellationToken>()),
            Times.Once);
    }

    [Fact]
    public async Task AssignUserAsync_ShouldAssignUserToShip()
    {
        // Arrange
        var shipUser = new ShipUser
        {
            ShipId = 1,
            UserId = 1
        };

        // Act
        var result = await _service.AssignUserAsync(shipUser, CancellationToken.None);

        // Assert
        Assert.Equal(0, result);

        _shipRepositoryMock.Verify(
            x => x.AddAsync(shipUser, It.IsAny<CancellationToken>()),
            Times.Once);
    }

    [Fact]
    public async Task GetCrewsAsync_ShouldReturnCrewsByShipId()
    {
        // Arrange
        var crews = new List<Crew>
        {
            new()
            {
                MemberId = "CRW0001",
                Rank = "Captain",
                FirstName = "Andreas",
                LastName = "Lindberg",
                BirthDate = Convert.ToDateTime("1978-04-12"),
                Nationality ="Swedish"
            },
            new()
            {
                MemberId = "CRW0002",
                Rank = "Chief Engineer",
                FirstName = "Michael",
                LastName = "Tan",
                BirthDate = Convert.ToDateTime("1982-09-21"),
                Nationality = "Singaporean"
            }
        };

        _crewRepositoryMock
            .Setup(x => x.GetCrewsAsync(It.IsAny<int>(), It.IsAny<CancellationToken>()))
            .ReturnsAsync(crews);

        var shipId = 1;

        // Act
        var result = await _service.GetCrewsAsync(shipId, CancellationToken.None);

        // Assert
        Assert.NotNull(result);

        _crewRepositoryMock.Verify(
            x => x.GetCrewsAsync(shipId, It.IsAny<CancellationToken>()),
            Times.Once);
    }

    [Fact]
    public async Task GetFinanceReportAsync_ShouldReturnFinanceReports()
    {
        // Arrange
        const int shipId = 1;
        const string accountPeriod = "2026-01";

        var expected = new List<ShipFinanceReport>
        {
            new()
            {
                AccountNumber = "7000000",
                COADescription = "OPERATING EXPENSES",
                Actual = 10000,
                Budget = 2000,
                Variance = 8000
            },
            new()
            {
                AccountNumber = "7100000",
                COADescription = "AWARD AND GRANT TO INDIVIDUALS",
                Actual = 3000,
                Budget = 500,
                Variance = 2500
            }
        };

        _reportRepositoryMock
            .Setup(x => x.GetFinanceReportAsync(shipId, accountPeriod, It.IsAny<CancellationToken>()))
            .ReturnsAsync(expected);

        // Act
        var result = await _service.GetFinanceReportAsync(shipId, accountPeriod, CancellationToken.None);

        // Assert
        Assert.Equal("7000000", result[0].AccountNumber);
        Assert.Equal("OPERATING EXPENSES", result[0].COADescription);
        Assert.Equal(8000, result[0].Variance);

        Assert.Equal("7100000", result[1].AccountNumber);
        Assert.Equal(2500, result[1].Variance);

        _reportRepositoryMock.Verify(
            x => x.GetFinanceReportAsync(shipId, accountPeriod, It.IsAny<CancellationToken>()),
            Times.Once);
    }
}