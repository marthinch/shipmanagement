using System.ComponentModel.DataAnnotations;

namespace ShipManagement.Middlewares;

public sealed class ExceptionMiddleware
{
    private readonly ILogger<ExceptionMiddleware> _logger;
    private readonly RequestDelegate _next;

    public ExceptionMiddleware(ILogger<ExceptionMiddleware> logger, RequestDelegate next)
    {
        _logger = logger;

        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (ValidationException ex)
        {
            _logger.LogWarning(ex, "ValidationException");

            context.Response.StatusCode = StatusCodes.Status400BadRequest;

            await context.Response.WriteAsJsonAsync(new
            {
                message = ex.Message
            });
        }
        catch (KeyNotFoundException ex)
        {
            _logger.LogWarning(ex, "KeyNotFoundException");

            context.Response.StatusCode = StatusCodes.Status404NotFound;

            await context.Response.WriteAsJsonAsync(new
            {
                message = ex.Message
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Exception");

            context.Response.StatusCode = StatusCodes.Status500InternalServerError;

            await context.Response.WriteAsJsonAsync(new
            {
                message = "An unexpected error occurred."
            });
        }
    }
}