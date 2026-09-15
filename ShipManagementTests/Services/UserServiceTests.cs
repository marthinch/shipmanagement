using Microsoft.Extensions.Logging;
using Moq;
using ShipManagement.DTOs;
using ShipManagement.Repositories;
using ShipManagement.Services;

namespace ShipManagementTests.Services;

public class UserServiceTests
{
    private readonly Mock<ILogger<UserService>> _loggerMock;
    private readonly Mock<IUserRepository> _userRepository;

    private readonly UserService _service;

    public UserServiceTests()
    {
        _loggerMock = new Mock<ILogger<UserService>>();
        _userRepository = new Mock<IUserRepository>();

        _service = new UserService(_loggerMock.Object, _userRepository.Object);
    }

    [Fact]
    public async Task GetAllAsync_ShouldReturnUsers()
    {
        // Arrange
        var users = new List<User>
        {
            new()
            {
                Name = "Marthin",
                Role = "Admin"
            },
            new()
            {
                Name = "Andreas Lindberg",
                Role = "Employee"
            },
            new()
            {
                Name = "Michael Tan",
                Role = "Employee"
            }
        };

        _userRepository
            .Setup(x => x.GetAllAsync<User>(It.IsAny<CancellationToken>()))
            .ReturnsAsync(users);

        // Act
        var result = await _service.GetAllAsync(CancellationToken.None);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(3, result.Count);

        Assert.Equal("Marthin", result[0].Name);
        Assert.Equal("Admin", result[0].Role);

        _userRepository.Verify(
            x => x.GetAllAsync<User>(It.IsAny<CancellationToken>()),
            Times.Once);
    }

    [Fact]
    public async Task AddAsync_ShouldAddNewUser()
    {
        // Arrange
        var user = new User
        {
            Name = "Marthin",
            Role = "Admin"
        };

        // Act
        var result = await _service.AddAsync(user, CancellationToken.None);

        // Assert
        Assert.Equal(0, result);

        _userRepository.Verify(
            x => x.AddAsync(user, It.IsAny<CancellationToken>()),
            Times.Once);
    }

    [Fact]
    public async Task GetShipsAsync_ShouldReturnShipsByUserId()
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

        _userRepository
            .Setup(x => x.GetShipsAsync(It.IsAny<int>(), It.IsAny<CancellationToken>()))
            .ReturnsAsync(ships);

        var userId = 1;

        // Act
        var result = await _service.GetShipsAsync(userId, CancellationToken.None);

        // Assert
        Assert.NotNull(result);

        _userRepository.Verify(
            x => x.GetShipsAsync(userId, It.IsAny<CancellationToken>()),
            Times.Once);
    }
}