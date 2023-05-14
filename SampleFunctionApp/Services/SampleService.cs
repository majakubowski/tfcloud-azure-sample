namespace SampleFunctionApp.Services;

public class SampleService
{
    private readonly ILogger logger;
    private readonly Options options;

    public SampleService(ILogger<SampleService> logger, Options options)
    {
        this.logger = logger;
        this.options = options;
    }

    public string SampleMethod(Payload payload)
    {
        logger.LogInformation("name = {name}", payload?.Name);
        logger.LogInformation("test1 = {test1}, test2 = {test2", options.Test1, options.Test2);
        logger.LogDebug("Debug");
        logger.LogInformation("Information");
        logger.LogError("Error");

        return $"Hello {payload?.Name}";
    }

}
