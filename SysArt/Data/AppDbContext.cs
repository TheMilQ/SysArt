using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SysArt.Models;

namespace SysArt.Data
{
    public class AppDbContext : IdentityDbContext<Users, IdentityRole, string>
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options) { }

        // Twoje własne DbSet'y
        public DbSet<Degrees> Degrees { get; set; }
        public DbSet<Articles> Articles { get; set; }
        public DbSet<Reviews> Reviews { get; set; }
        public DbSet<Statuses> Statuses { get; set; }
        public DbSet<Topics> Topics { get; set; }
        public DbSet<RoleRequest> RoleRequests { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            // Check constraint dla oceny recenzji
            builder.Entity<Reviews>()
                .ToTable(t => t.HasCheckConstraint("CK_Reviews_Rating", "Rating BETWEEN 1 AND 5"));

            // Relacje
            builder.Entity<Reviews>()
                .HasOne(r => r.Article)
                .WithMany(a => a.Reviews)
                .HasForeignKey(r => r.ArticleId);

            builder.Entity<Reviews>()
                .HasOne(r => r.Reviewer)
                .WithMany()
                .HasForeignKey(r => r.ReviewerId);
        }
    }
}
