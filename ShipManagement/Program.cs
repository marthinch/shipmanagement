using Serilog;
using ShipManagement.Middlewares;
using ShipManagement.Repositories;
using ShipManagement.Services;

var builder = WebApplication.CreateBuilder(args);

try
{
    builder.Logging.ClearProviders();

    builder.Host.UseSerilog((hostingContext, loggerConfiguration) =>
    {
        loggerConfiguration
            .ReadFrom.Configuration(hostingContext.Configuration);
    });

    // Add services to the container.
    builder.Services.AddScoped<IDbConnectionFactory, DbConnectionFactory>();

    // Repositories
    builder.Services.AddScoped<IBaseCRUDRepository, BaseCRUDRepository>();
    builder.Services.AddScoped<IShipRepository, ShipRepository>();
    builder.Services.AddScoped<ICrewRepository, CrewRepository>();
    builder.Services.AddScoped<IUserRepository, UserRepository>();
    builder.Services.AddScoped<IReportRepository, ReportRepository>();

    // Services
    builder.Services.AddScoped<IShipService, ShipService>();
    builder.Services.AddScoped<ICrewService, CrewService>();
    builder.Services.AddScoped<IUserService, UserService>();

    builder.Services.AddControllers();

    // Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
    builder.Services.AddOpenApi();

    builder.Services.AddEndpointsApiExplorer();

    var app = builder.Build();

    app.UseMiddleware<ExceptionMiddleware>();

    // Configure the HTTP request pipeline.
    if (app.Environment.IsDevelopment())
    {
        app.MapOpenApi();

        app.UseSwaggerUI(options =>
        {
            options.SwaggerEndpoint("/openapi/v1.json", "Ship Management API v1");
        });
    }

    app.UseHttpsRedirection();

    app.UseAuthorization();

    app.MapControllers();

    app.Run();
}
catch (Exception exception)
{
    Log.Fatal(exception, "Host terminated unexpectedly.");

    Environment.Exit(0);
}