using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Net;
using MongoDB.Bson;
using System.Security.Cryptography;


//"docker_db1": "Server=localhost,1433;database=apidb;User ID= SA;password=abc123!!@;"

namespace Controllers
{
    [ApiController]
    [Route("user")]
    public class Controller : ControllerBase
    {
        
        // string failed = "Request Failed, Verify Information And Try Again";
        private readonly UserService _userService;
        public Controller(ILogger<Controller> logger, UserService userService)
        {
            this._userService = userService;
        }

        [HttpGet]
        public ActionResult<String> AccountHelp(){
            return @"End Point URI's
1. newUser
    ***FORM DATA REQUIRED***
    _userName
    _userPassword
    _userEmail
    _userRole

2. removeUser
    ***FORM DATA REQUIRED***
    _userName
    _userPassword

3. updateUserName
    ***FORM DATA REQUIRED***
    _userName
    _userPassword
    _newName

4. updateUserPassword
    ***FORM DATA REQUIRED***
    _userName
    _userPassword
    _newPass

5. updateUserEmail
    ***FORM DATA REQUIRED***
    _userName
    _userPassword
    _newEmail

6. updateUserRole
    ***FORM DATA REQUIRED***
    _userName
    _userPassword
    _newRole

7. validateUser
    ***FORM DATA REQUIRED***
    _userName
    _userPassword
    
";
        }
        [HttpPost("addUser")]
        public async Task<ActionResult<HttpResponseMessage>> NewUser([FromForm] User user)
        {
            if(user is null)
                return NoContent();
            if(user._userName is null)
                return NoContent();
            User? _user = await _userService.GetAsync(user._userName);
            if(_user is not null)
                return NoContent();
            await _userService.CreateAsync(user);
            return Ok();
        }
        
        [HttpDelete("removeUser")]
        public async Task<ActionResult<HttpResponseMessage>> RemoveUser([FromForm] string userName, [FromForm] string userPassword)
        {

            User? user = await _userService.GetAsync(userName);
            if(user is not null && user._userPassword is not null)
            {
                if(user._userPassword.Equals(userPassword))
                {
                    await _userService.RemoveAsync(userName);
                    return Ok();
                }
                return NoContent();
            }
            return NoContent();
        }
        
        [HttpPost("updateUserName")]
        public async Task<ActionResult<HttpResponseMessage>> UpdateUserName([FromForm] string userName, [FromForm] string userPassword, [FromForm] string newName)
        {
            User? user = await _userService.GetAsync(userName);
            if(user is null)
                return NoContent();
            if(user._userName is null || user._userPassword is null)
                return NoContent();
            if(user._userPassword.Equals(userPassword))
            {
                user._userName = newName;
                await _userService.UpdateAsync(userName, user);
                return Ok();
            }
            return NoContent();
        }
        
        [HttpPost("updateUserPassword")]
        public async Task<ActionResult<HttpResponseMessage>> UpdateUserPassword([FromForm] string userName, [FromForm] string userPassword, [FromForm] string newPass)
        {
            User? user = await _userService.GetAsync(userName);
            if(user is null)
                return NoContent();
            if(user._userName is null || user._userPassword is null)
                return NoContent();
            if(user._userPassword.Equals(userPassword))
            {
                user._userPassword = newPass;
                await _userService.UpdateAsync(userName, user);
                return Ok();
            }
            return NoContent();
        }
        
        [HttpPost("updateUserEmail")]
        public async Task<ActionResult<HttpResponseMessage>> UpdateUserEmail([FromForm] string userName, [FromForm] string userPassword, [FromForm] string newEmail)
        {
            User? user = await _userService.GetAsync(userName);
            if(user is null)
                return NoContent();
            if(user._userName is null || user._userPassword is null)
                return NoContent();
            if(user._userPassword.Equals(userPassword))
            {
                user._userEmail = newEmail;
                await _userService.UpdateAsync(userName, user);
                return Ok();
            }
            return NoContent();
        }
        
        [HttpPost("updateUserRole")]
        public async Task<ActionResult<HttpResponseMessage>> UpdateUserRole([FromForm] string userName, [FromForm] string userPassword, [FromForm] string newRole)
        {
            User? user = await _userService.GetAsync(userName);
            if(user is null)
                return NoContent();
            if(user._userName is null || user._userPassword is null)
                return NoContent();
            if(user._userPassword.Equals(userPassword))
            {
                user._userRole = newRole;
                await _userService.UpdateAsync(userName, user);
                return Ok();
            }
            return NoContent();
        }

        [HttpPost("validate")]
        public async Task<ActionResult<HttpResponseMessage>> SignIn([FromForm] string userName, [FromForm] string userPassword)
        {
            User? user = await _userService.GetAsync(userName);
            if(user is not null)
            {
                if(userName.Equals(user._userName) && userPassword.Equals(user._userPassword))
                {
                    return Ok();
                }
                return NoContent();
            }
            return NoContent();
        }
    }
}