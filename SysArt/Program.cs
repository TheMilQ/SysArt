using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using SysArt.Data;
using SysArt.Models;

var builder = WebApplication.CreateBuilder(args);

// -------------------------------
// Po³¹czenie z baz¹ MySQL
// -------------------------------
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        new MySqlServerVersion(new Version(8, 0, 33))
    )
);

// -------------------------------
// Identity
// -------------------------------
builder.Services.AddIdentity<Users, IdentityRole>(options =>
{
    options.Password.RequireDigit = true;
    options.Password.RequiredLength = 6;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = true;
    options.Password.RequireLowercase = true;
})
    .AddEntityFrameworkStores<AppDbContext>()
    .AddDefaultTokenProviders();

// -------------------------------
// Cookie
// -------------------------------
builder.Services.ConfigureApplicationCookie(options =>
{
    options.LoginPath = "/Account/Login";
    options.AccessDeniedPath = "/Account/AccessDenied";
});

builder.Services.AddControllersWithViews();

var app = builder.Build();

// -------------------------------
// Tworzenie ról i konta admina przy starcie aplikacji
// -------------------------------
using (var scope = app.Services.CreateScope())
{
    var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();
    var userManager = scope.ServiceProvider.GetRequiredService<UserManager<Users>>();

    string[] roles = { "Guest", "Admin", "Author", "Reviewer" };

    foreach (var role in roles)
    {
        if (!await roleManager.RoleExistsAsync(role))
        {
            await roleManager.CreateAsync(new IdentityRole(role));
        }
    }

    // Tworzenie konta admina, jeœli nie istnieje
    string adminEmail = "admin@test.com";
    string adminPassword = "Dbpass111";

    var adminUser = await userManager.FindByEmailAsync(adminEmail);
    if (adminUser == null)
    {
        var admin = new Users
        {
            UserName = adminEmail,
            Email = adminEmail,
            Name = "Admin",
            LastName = "Admin",
            University = "Admin University",
            DegreeId = 1
        };

        var result = await userManager.CreateAsync(admin, adminPassword);
        if (result.Succeeded)
        {
            await userManager.AddToRoleAsync(admin, "Admin");
        }
    }
}

// -------------------------------
// Middleware
// -------------------------------
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

// -------------------------------
// Routing
// -------------------------------
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
