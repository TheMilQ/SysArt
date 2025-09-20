using System;

namespace SysArt.Models
{
    public class Reviews
    {
        public int Id { get; set; }
        public int ArticleId { get; set; }
        public Articles Article { get; set; } = null!;
        public string ReviewerId { get; set; } = null!;
        public Users Reviewer { get; set; } = null!;
        public DateTime AssignedAt { get; set; }
        public string Content { get; set; } = null!;
        public int Rating { get; set; }
        public bool IsFinal { get; set; }
        public bool Confidential { get; set; }
    }
}
