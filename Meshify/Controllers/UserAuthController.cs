using Meshify.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Meshify.Controllers
{
    public class UserAuthController : Controller
    {
        // GET: UserAuth
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(UserLogin user)
        {
            if(user.UserEmail == "user" && user.Password == "user")
            {
                Session["user"] = user.UserEmail;
                return RedirectToAction("Contact", "Home");
            }
            return View();
        }
        public ActionResult Signup() 
        { 
            return View(); 
        
        }

        public ActionResult Logout() 
        {
            Session.Abandon();
            return RedirectToAction("Index", "home");
        }
    }
}