using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore; // <- potrzebne do Include
using SysArt.Data;
using SysArt.Models;

[Authorize(Roles = "Admin")]
public class AdminController : Controller
{
    private readonly AppDbContext _context;
    private readonly UserManager<Users> _userManager;
    private readonly RoleManager<IdentityRole> _roleManager;

    public AdminController(AppDbContext context, UserManager<Users> userManager, RoleManager<IdentityRole> roleManager)
    {
        _context = context;
        _userManager = userManager;
        _roleManager = roleManager;
    }

    // GET: lista wszystkich oczekujących próśb
    public async Task<IActionResult> RoleRequests()
    {
        var requests = await _context.RoleRequests
            .Include(r => r.User) // <- dociągamy dane użytkownika
            .Where(r => !r.IsApproved)
            .OrderByDescending(r => r.RequestedAt)
            .ToListAsync();

        return View(requests);
    }

    // POST: zatwierdzenie prośby o rolę
    [HttpPost]
    public async Task<IActionResult> ApproveRole(int requestId)
    {
        var request = await _context.RoleRequests
            .Include(r => r.User)
            .FirstOrDefaultAsync(r => r.Id == requestId);

        if (request == null) return NotFound();

        var user = await _userManager.FindByIdAsync(request.UserId);
        if (user == null) return NotFound();

        if (!await _userManager.IsInRoleAsync(user, request.RoleName))
        {
            await _userManager.AddToRoleAsync(user, request.RoleName);
        }

        request.IsApproved = true;
        await _context.SaveChangesAsync();

        return RedirectToAction("RoleRequests");
    }
}
