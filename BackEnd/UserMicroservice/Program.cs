using Microsoft.EntityFrameworkCore;
using MongoDB.Bson.Serialization;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Steeltoe.Discovery.Client;
using Steeltoe.Common.Discovery;
using Steeltoe.Discovery.Eureka;
using Steeltoe.Discovery;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDiscoveryClient(builder.Configuration);
BsonClassMap.RegisterClassMap<User>();
builder.Services.AddControllers();
builder.Services.Configure<DB>(builder.Configuration.GetSection("DB"));
builder.Services.AddSingleton<UserService>();
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

app.MapGet("/", () => "To access the User api please enter /user/help for more information");

app.Run();