namespace SysArt.Models
{
    public class Articles
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public string Content { get; set; } = null!;
        public string Status { get; set; } = "Pending"; // Pending / Approved / Rejected
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }

        public int? TopicId { get; set; }
        public Topics? Topic { get; set; } = null!;

        public string? CoAuthors { get; set; } = ""; // <-- współautorzy jako string

        public ICollection<Reviews> Reviews { get; set; } = new List<Reviews>();
    }
}
