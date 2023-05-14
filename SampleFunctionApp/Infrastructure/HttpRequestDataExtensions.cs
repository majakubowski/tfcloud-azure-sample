public static class HttpRequestDataExtensions
{
    public static async Task<HttpResponseData> CreateResult<T>(this HttpRequestData req, T obj)
    {
        var response = req.CreateResponse();
        await response.WriteAsJsonAsync(obj);
        return response;
    }

    public static async Task<HttpResponseData> CreateStringResult(this HttpRequestData req, string message, HttpStatusCode statusCode)
    {
        var response = req.CreateResponse(statusCode);
        await response.WriteStringAsync(message);
        return response;
    }
}