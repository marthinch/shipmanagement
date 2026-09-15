using Microsoft.Extensions.Logging;
using Moq;
using ShipManagement.DTOs;
using ShipManagement.Repositories;
using ShipManagement.Services;

namespace ShipManagementTests.Services;

public class CrewServiceTests
{
    private readonly Mock<ILogger<CrewService>> _loggerMock;
    private readonly Mock<ICrewRepository> _crewRepositoryMock;

    private readonly CrewService _service;

    public CrewServiceTests()
    {
        _loggerMock = new Mock<ILogger<CrewService>>();
        _crewRepositoryMock = new Mock<ICrewRepository>();

        _service = new CrewService(_loggerMock.Object, _crewRepositoryMock.Object);
    }

    [Fact]
    public async Task GetAllAsync_ShouldReturnCrews()
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
            .Setup(x => x.GetAllAsync<Crew>(It.IsAny<CancellationToken>()))
            .ReturnsAsync(crews);

        // Act
        var result = await _service.GetAllAsync(CancellationToken.None);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(2, result.Count);

        Assert.Equal("CRW0001", result[0].MemberId);
        Assert.Equal("Captain", result[0].Rank);

        _crewRepositoryMock.Verify(
            x => x.GetAllAsync<Crew>(It.IsAny<CancellationToken>()),
            Times.Once);
    }

    [Fact]
    public async Task AddAsync_ShouldAddNewCrew()
    {
        // Arrange
        var crew = new Crew
        {
            MemberId = "CRW0001",
            Rank = "Captain",
            FirstName = "Andreas",
            LastName = "Lindberg",
            BirthDate = Convert.ToDateTime("1978-04-12"),
            Nationality = "Swedish"
        };

        // Act
        var result = await _service.AddAsync(crew, CancellationToken.None);

        // Assert
        Assert.Equal(0, result);

        _crewRepositoryMock.Verify(
            x => x.AddAsync(crew, It.IsAny<CancellationToken>()),
            Times.Once);
    }
}