using System.ComponentModel.DataAnnotations;

namespace SysArt.ViewModels
{
    public class RegisterViewModel
    {
        [Required]
        [Display(Name = "Imię")]
        public string Name { get; set; }

        [Required]
        [Display(Name = "Nazwisko")]
        public string LastName { get; set; }

        [Required]
        [EmailAddress]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [Required]
        [Display(Name = "Uczelnia")]
        public string University { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Hasło")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Potwierdź hasło")]
        [Compare("Password", ErrorMessage = "Hasła muszą się zgadzać.")]
        public string ConfirmPassword { get; set; }
    }
}
