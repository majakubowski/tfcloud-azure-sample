var host = new HostBuilder()

    .ConfigureFunctionsWorkerDefaults(builder =>
    {
        builder
            .AddApplicationInsights()
            .AddApplicationInsightsLogger()
            .UseNewtonsoftJson();
    })

    .ConfigureLogging(logging => logging
       .AddFilter<ApplicationInsightsLoggerProvider>(null, LogLevel.Information))

    .ConfigureServices(s =>
    {
        s.AddSingleton(sp => sp.GetRequiredService<IConfiguration>().Get<Options>());
        s.AddTransient<SampleService>();
    })
    .Build();

await host.RunAsync();
