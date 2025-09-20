namespace SysArt.Models
{
    public class RoleRequest
    {
        public int Id { get; set; }
        public string UserId { get; set; } = null!;
        public Users User { get; set; } = null!;
        public string RoleName { get; set; } = null!;
        public bool IsApproved { get; set; } = false;
        public DateTime RequestedAt { get; set; } = DateTime.Now;
    }
}
