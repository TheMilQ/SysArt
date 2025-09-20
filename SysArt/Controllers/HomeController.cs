using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SysArt.Data;
using SysArt.Models;
using System.Diagnostics;

namespace SysArt.Controllers
{
    public class HomeController : Controller
    {
        private readonly AppDbContext _context;

        public HomeController(AppDbContext context)
        {
            _context = context;
        }

        // Strona g³ówna z list¹ artyku³ów
        public async Task<IActionResult> Index(int? topicId)
        {
            ViewBag.Topics = await _context.Topics.ToListAsync();

            var articlesQuery = _context.Articles
                .Include(a => a.Topic)
                .Include(a => a.Reviews)
                    .ThenInclude(r => r.Reviewer)
                .OrderByDescending(a => a.CreatedAt)
                .AsQueryable();

            if (topicId.HasValue)
            {
                articlesQuery = articlesQuery.Where(a => a.TopicId == topicId.Value);
            }

            var articles = await articlesQuery.ToListAsync();
            return View(articles);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel
            {
                RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier
            });
        }
    }
}
