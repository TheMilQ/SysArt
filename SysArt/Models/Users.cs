using Microsoft.AspNetCore.Identity;

namespace SysArt.Models
{
    public class Users : IdentityUser
    {
        public string Name { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string? University { get; set; }

        public int DegreeId { get; set; }
        public Degrees Degree { get; set; } = null!;
    }
}
