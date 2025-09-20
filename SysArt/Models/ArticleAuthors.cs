namespace SysArt.Models
{
    public class ArticleAuthors
    {
        public int Id { get; set; }
        public int ArticleId { get; set; }
        public Articles Article { get; set; } = null!;
        public string UserId { get; set; } = null!;
        public Users User { get; set; } = null!;
    }
}
