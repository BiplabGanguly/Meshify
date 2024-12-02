using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security;
using System.Web;

namespace Meshify.Models
{
    public class UserLogin
    {
        [Required(ErrorMessage ="User Name is required.")]
        public string UserEmail { get; set; }
        [Required(ErrorMessage = "Password is required.")]
        public string Password { get; set; }

    }
}