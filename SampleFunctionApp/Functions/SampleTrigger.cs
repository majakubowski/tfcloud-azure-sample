using System.Web.Http;
using Microsoft.AspNetCore.Mvc;
namespace SampleFunctionApp.Triggers;

public class SampleTrigger
{
    private readonly ILogger logger;
    private readonly SampleService sampleService;

    public SampleTrigger(ILogger<SampleTrigger> logger, SampleService sampleService)
    {
        this.logger = logger;
        this.sampleService = sampleService;
    }

    [Function(nameof(SampleTrigger))]
    [OpenApiOperation(nameof(SampleTrigger))]
    [OpenApiRequestBody(contentType: "application/json", typeof(Payload), Required = true)]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "application/json", bodyType: typeof(string))]
    public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Function, "post")] HttpRequestData req,
        FunctionContext context)
    {
        var payload = await req.ReadFromJsonAsync<Payload>();
        var result = sampleService.SampleMethod(payload);
        var response = await req.CreateStringResult(result, HttpStatusCode.OK);
        return response;
    }
}
