using PretApi.Models;
using PretApi.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.ReferenceHandler = System.Text.Json.Serialization.ReferenceHandler.IgnoreCycles;
        options.JsonSerializerOptions.DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingNull;
    });

// Configure Entity Framework avec PostgreSQL
builder.Services.AddDbContext<PretContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

// Register services
builder.Services.AddScoped<PretService>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { 
        Title = "Prêt API", 
        Version = "v1",
        Description = "API pour la gestion des prêts - Système Bancaire"
    });
});

// Configure CORS pour permettre les appels depuis le module central
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowCentralModule", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

// Configure logging
builder.Logging.ClearProviders();
builder.Logging.AddConsole();
builder.Logging.AddDebug();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Prêt API v1");
        c.RoutePrefix = string.Empty; // Pour avoir Swagger à la racine
    });
}

app.UseHttpsRedirection();

app.UseCors("AllowCentralModule");

app.UseAuthorization();

app.MapControllers();

// Endpoint de santé global
app.MapGet("/", () => new { 
    service = "pret-api", 
    status = "running", 
    timestamp = DateTime.Now,
    version = "1.0.0"
});

app.Run();
