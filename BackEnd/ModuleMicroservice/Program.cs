using Microsoft.EntityFrameworkCore;
using MongoDB.Bson.Serialization;
using Steeltoe.Discovery.Client;
using Steeltoe.Common.Discovery;
using Steeltoe.Discovery.Eureka;
using Steeltoe.Discovery;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDiscoveryClient(builder.Configuration);
BsonClassMap.RegisterClassMap<Mod>();
builder.Services.AddControllers();
builder.Services.Configure<DB>(builder.Configuration.GetSection("DB"));
builder.Services.Configure<JwtConfig>(builder.Configuration.GetSection("JwtConfig"));
builder.Services.AddSingleton<ModService>();
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(
        policy =>
        {
            policy.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
        });
});

var app = builder.Build();
app.MapControllers();
app.UseCors();

app.MapGet("/", () => "To access the Mod api please enter /mod/help for more information ");

app.Run();