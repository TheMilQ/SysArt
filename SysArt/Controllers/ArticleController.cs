using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SysArt.Data;
using SysArt.Models;

[Authorize(Roles = "Author,Reviewer")]
public class ArticleController : Controller
{
    private readonly AppDbContext _context;
    private readonly UserManager<Users> _userManager;

    public ArticleController(AppDbContext context, UserManager<Users> userManager)
    {
        _context = context;
        _userManager = userManager;
    }

    // Panel autora
    [Authorize(Roles = "Author")]
    public async Task<IActionResult> AuthorPanel()
    {
        var user = await _userManager.GetUserAsync(User);
        var articles = await _context.Articles
            .Where(a => a.CoAuthors.Contains(user.Email))
            .Include(a => a.Topic)
            .ToListAsync();

        ViewBag.Topics = await _context.Topics.ToListAsync();
        return View(articles);
    }

    // Dodawanie artykułu
    [Authorize(Roles = "Author")]
    [HttpPost]
    public async Task<IActionResult> SubmitArticle(string title, string content, int topicId, string coAuthors)
    {
        var user = await _userManager.GetUserAsync(User);
        var topic = await _context.Topics.FirstOrDefaultAsync(t => t.Id == topicId);
        if (topic == null) return BadRequest("Niepoprawny temat");

        // Dodaj autora głównego do stringa jeśli nie ma w liście
        var allAuthors = string.IsNullOrWhiteSpace(coAuthors) ? user.Email : coAuthors + ", " + user.Email;

        var article = new Articles
        {
            Title = title,
            Content = content,
            TopicId = topic.Id,
            Status = "Pending",
            CreatedAt = DateTime.Now,
            UpdatedAt = DateTime.Now,
            CoAuthors = allAuthors
        };

        _context.Articles.Add(article);
        await _context.SaveChangesAsync();

        return RedirectToAction("Details", new { id = article.Id });
    }

    // Szczegóły artykułu
    [AllowAnonymous]
    public async Task<IActionResult> Details(int id)
    {
        var article = await _context.Articles
            .Include(a => a.Reviews)
            .Include(a => a.Topic)
            .FirstOrDefaultAsync(a => a.Id == id);

        if (article == null) return NotFound();
        return View(article);
    }

    // Edycja artykułu (GET)
    [Authorize(Roles = "Author")]
    [HttpGet]
    public async Task<IActionResult> Edit(int id)
    {
        var article = await _context.Articles.FirstOrDefaultAsync(a => a.Id == id);
        if (article == null) return NotFound();

        ViewBag.Topics = new SelectList(await _context.Topics.ToListAsync(), "Id", "Name", article.TopicId);
        return View(article);
    }

    // Edycja artykułu (POST)
    [Authorize(Roles = "Author")]
    [HttpPost]
    public async Task<IActionResult> Edit(int id, string title, string content, int topicId, string coAuthors)
    {
        var article = await _context.Articles.FirstOrDefaultAsync(a => a.Id == id);
        if (article == null) return NotFound();

        var topic = await _context.Topics.FirstOrDefaultAsync(t => t.Id == topicId);
        if (topic == null)
        {
            ModelState.AddModelError("topicId", "Wybrany temat nie istnieje.");
            ViewBag.Topics = new SelectList(await _context.Topics.ToListAsync(), "Id", "Name", article.TopicId);
            return View(article);
        }

        // Aktualizacja danych
        article.Title = title;
        article.Content = content;
        article.TopicId = topic.Id;
        article.CoAuthors = coAuthors; // teraz jako string
        article.UpdatedAt = DateTime.Now;

        await _context.SaveChangesAsync();

        TempData["Message"] = "Artykuł został zaktualizowany!";
        return RedirectToAction("Details", new { id = article.Id });
    }

    // Panel recenzenta
    [Authorize(Roles = "Reviewer")]
    public IActionResult ReviewerPanel(int? topicId)
    {
        var articles = _context.Articles.Include(a => a.Topic).AsQueryable();

        if (topicId.HasValue)
            articles = articles.Where(a => a.TopicId == topicId.Value);

        ViewBag.Topics = _context.Topics.ToList();
        return View(articles.ToList());
    }

    // Dodawanie recenzji
    [Authorize(Roles = "Reviewer")]
    [HttpPost]
    public async Task<IActionResult> AddReview(int articleId, string content, int rating)
    {
        var user = await _userManager.GetUserAsync(User);
        var article = await _context.Articles.FirstOrDefaultAsync(a => a.Id == articleId);
        if (article == null) return NotFound();

        var review = new Reviews
        {
            ArticleId = article.Id,
            ReviewerId = user.Id,
            Content = content,
            Rating = rating,
            AssignedAt = DateTime.Now,
            IsFinal = false,
            Confidential = false
        };

        _context.Reviews.Add(review);
        await _context.SaveChangesAsync();

        TempData["Message"] = "Recenzja została dodana!";
        return RedirectToAction("Details", new { id = article.Id });
    }

    // Edycja recenzji (GET)
    [Authorize(Roles = "Reviewer")]
    [HttpGet]
    public async Task<IActionResult> EditReview(int id)
    {
        var review = await _context.Reviews.Include(r => r.Article).FirstOrDefaultAsync(r => r.Id == id);
        if (review == null) return NotFound();

        return View(review);
    }

    // Edycja recenzji (POST)
    [Authorize(Roles = "Reviewer")]
    [HttpPost]
    public async Task<IActionResult> EditReview(int reviewId, string content, int rating)
    {
        var review = await _context.Reviews.FirstOrDefaultAsync(r => r.Id == reviewId);
        if (review == null) return NotFound();

        review.Content = content;
        review.Rating = rating;
        await _context.SaveChangesAsync();

        TempData["Message"] = "Recenzja została zaktualizowana!";
        return RedirectToAction("Details", new { id = review.ArticleId });
    }

    // Zmiana statusu artykułu
    [Authorize(Roles = "Reviewer")]
    [HttpPost]
    public async Task<IActionResult> ChangeStatus(int articleId, string newStatus)
    {
        var article = await _context.Articles.FirstOrDefaultAsync(a => a.Id == articleId);
        if (article == null) return NotFound();

        var allowedStatuses = new[] { "Pending", "Approved", "Rejected" };
        if (!allowedStatuses.Contains(newStatus)) return BadRequest("Nieprawidłowy status.");

        article.Status = newStatus;
        article.UpdatedAt = DateTime.Now;
        await _context.SaveChangesAsync();

        TempData["Message"] = $"Status artykułu został zmieniony na {newStatus}.";
        return RedirectToAction("ReviewerPanel");
    }
}
