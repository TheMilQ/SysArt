using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using SysArt.Data;
using SysArt.Models;
using SysArt.ViewModels;

namespace SysArt.Controllers
{
    public class AccountController : Controller
    {
        private readonly UserManager<Users> _userManager;
        private readonly SignInManager<Users> _signInManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly AppDbContext _context;

        public AccountController(
            UserManager<Users> userManager,
            SignInManager<Users> signInManager,
            RoleManager<IdentityRole> roleManager,
            AppDbContext context)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _roleManager = roleManager;
            _context = context;
        }

        // GET: /Account/Register
        [HttpGet]
        public IActionResult Register() => View();

        // POST: /Account/Register
        [HttpPost]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid) return View(model);

            var user = new Users
            {
                UserName = model.Email,
                Email = model.Email,
                Name = model.Name,
                LastName = model.LastName,
                University = model.University,
                DegreeId = 1
            };

            var result = await _userManager.CreateAsync(user, model.Password);
            if (!result.Succeeded)
            {
                foreach (var err in result.Errors) ModelState.AddModelError("", err.Description);
                return View(model);
            }

            // Dodaj rolę Guest jeśli nie istnieje
            if (!await _roleManager.RoleExistsAsync("Guest"))
                await _roleManager.CreateAsync(new IdentityRole("Guest"));

            await _userManager.AddToRoleAsync(user, "Guest");
            await _signInManager.SignInAsync(user, isPersistent: false);

            return RedirectToAction("AccountPanel");
        }

        // GET: /Account/Login
        [HttpGet]
        public IActionResult Login() => View();

        // POST: /Account/Login
        [HttpPost]
        public async Task<IActionResult> Login(LoginViewModel model)
        {
            if (!ModelState.IsValid) return View(model);

            var result = await _signInManager.PasswordSignInAsync(
                model.Email, model.Password, model.RememberMe, lockoutOnFailure: false);

            if (result.Succeeded) return RedirectToAction("AccountPanel");

            ModelState.AddModelError("", "Nieprawidłowy login lub hasło.");
            return View(model);
        }

        // POST: /Account/Logout
        [HttpPost]
        public async Task<IActionResult> Logout()
        {
            await _signInManager.SignOutAsync();
            return RedirectToAction("Login");
        }

        // GET: /Account/AccountPanel
        [HttpGet]
        public async Task<IActionResult> AccountPanel()
        {
            var user = await _userManager.GetUserAsync(User);
            if (user == null) return RedirectToAction("Login");

            var roles = await _userManager.GetRolesAsync(user);
            ViewBag.Roles = roles;

            // Lista oczekujących próśb
            ViewBag.RoleRequests = _context.RoleRequests
                .Where(r => r.UserId == user.Id)
                .OrderByDescending(r => r.RequestedAt)
                .ToList();

            // Lista tematów dla Author/Reviewer
            ViewBag.Topics = _context.Topics.ToList();

            // Lista artykułów dla recenzentów
            if (roles.Contains("Reviewer"))
            {
                ViewBag.Articles = _context.Articles.ToList();
            }

            return View(user);
        }

        // POST: /Account/RequestRole
        [HttpPost]
        public async Task<IActionResult> RequestRole(string roleName)
        {
            var user = await _userManager.GetUserAsync(User);
            if (user == null) return RedirectToAction("Login");

            // Sprawdź, czy nie ma już oczekującej prośby
            bool alreadyRequested = _context.RoleRequests
                .Any(r => r.UserId == user.Id && r.RoleName == roleName && !r.IsApproved);
            if (!alreadyRequested)
            {
                _context.RoleRequests.Add(new RoleRequest
                {
                    UserId = user.Id,
                    RoleName = roleName,
                    RequestedAt = DateTime.Now
                });
                await _context.SaveChangesAsync();
            }

            return RedirectToAction("AccountPanel");
        }
    }
}
