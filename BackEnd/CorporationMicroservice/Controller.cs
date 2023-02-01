using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Net;
using MongoDB.Bson;using System.Net.Http.Headers;
using System.Security.Cryptography;


//"docker_db1": "Server=localhost,1433;database=apidb;User ID= SA;password=abc123!!@;"

namespace Controllers
{
    [ApiController]
    [Route("corp")]
    public class Controller : ControllerBase
    {
        HttpClient client = new();
        string failed = "Request Failed, Verify Information And Try Again";
        private readonly CorpService _corpService;
        public Controller(ILogger<Controller> logger, CorpService corpService)
        {
            this._corpService = corpService;
        }

        [HttpGet]
        public ActionResult<String> AccountHelp(){
            return @"End Point URI's
1. newCorp 
    FORM DATA REQUIRED
        _name
        _email
        _password
        _userName
        _userPassword
        _userEmail
        _userRole
2. updateCorpName 
    FORM DATA REQUIRED
        corpName
        corpPassword
        newName
3. updateCorpEmail 
    FORM DATA REQUIRED
        corpName
        corpPassword
        newEmail
4. updateCorpPassword
    FORM DATA REQUIRED
        corpName
        corpPassword
        newPassword
5. deleteCorp 
    FORM DATA REQUIRED
        corpName
        corpPassword
";
        }

        [HttpPost("getCorp")]
        public async Task<ActionResult<Corporation>> GetCorp([FromForm] string corpName)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            return corp;
        }

        [HttpPost("newCorp")]
        public async Task<ActionResult<string>> NewCorp([FromForm] Corporation corp)
        {
            if(corp is null)
                return BadRequest();
            Corporation? _corp = await _corpService.GetAsync(corp._name);
            if(_corp is not null)
                return BadRequest();
            await _corpService.CreateAsync(corp);
            return Ok();
        }

        [HttpPost("updateCorpName")]
        public async Task<ActionResult<string>> UpdateCorpName([FromForm] string corpName, [FromForm] string corpPassword, [FromForm] string newName)
        {
            var corp = await _corpService.GetAsync(corpName);
            if (corp is null)
            {
                return BadRequest();
            }
            if(corpPassword.Equals(corp._password))
            {
                corp._name = newName;
                await _corpService.UpdateAsync(corpName, corp);
                return Ok();
            }
            return BadRequest();
        }

        [HttpPost("updateCorpEmail")]
        public async Task<ActionResult<string>> UpdateCorpEmail([FromForm] string corpName, [FromForm] string corpPassword, [FromForm] string newEmail)
        {
            var corp = await _corpService.GetAsync(corpName);
            if (corp is null)
                return BadRequest();
            if(corpPassword.Equals(corp._password))
            {
                corp._email = newEmail;
                await _corpService.UpdateAsync(corpName, corp);
                return Ok();
            }
            return BadRequest();
        }

        [HttpPost("updateCorpPassword")]
        public async Task<ActionResult<string>> UpdateCorpPassword([FromForm] string corpName, [FromForm] string corpPassword, [FromForm] string newPassword)
        {
            Console.WriteLine(corpName + " :: " + corpPassword + " :: " + newPassword);
            var corp = await _corpService.GetAsync(corpName);
            if (corp is null)
                return BadRequest();
            if(corpPassword.Equals(corp._password))
            {
                corp._password = newPassword;
                await _corpService.UpdateAsync(corpName, corp);
                return Ok();
            }
            return BadRequest();
        }

        [HttpDelete("deleteCorp")]
        public async Task<ActionResult<string>> DeleteCorp([FromForm] string corpName, [FromForm] string corpPassword)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            if(corpPassword.Equals(corp._password))
            {
                await _corpService.RemoveAsync(corpName);
                return Ok();
            }
            return BadRequest();
        }

        [HttpPost("validate")]
        public async Task<ActionResult<string>> Validate([FromForm] string corpName, [FromForm] string corpPassword)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            if(corp._password.Equals(corpPassword))
                return Ok();
            return BadRequest();
        }

        [HttpPost("newMod")]
        public async Task<ActionResult<string>> AddMod([FromForm] string modName, [FromForm] string corpName, [FromForm] string corpPassword)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            if(!corpPassword.Equals(corp._password))
                return BadRequest();
            corp._modules.Add(modName);
            await _corpService.UpdateAsync(corpName, corp);
            return Ok();
        }

        [HttpPost("removeMod")]
        public async Task<ActionResult<string>> RemoveMod([FromForm] string corpName, [FromForm] string modName)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            corp._modules.Remove(modName);
            await _corpService.UpdateAsync(corpName, corp);
            return Ok();
        }
    
        [HttpPost("newRequest")]
        public async Task<ActionResult<string>> AddRequest([FromForm] string corpName, [FromForm] string request)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            if(corp._requests.Contains(request))
                return Ok();
            corp._requests.Add(request);
            await _corpService.UpdateAsync(corpName, corp);
            return Ok();
        }
        [HttpPost("acceptRequest")]
        public async Task<ActionResult<string>> AcceptRequest([FromForm] string corpName, [FromForm] string request)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            if(corp._requests.Contains(request))
            {
                corp._users.Add(request);
                corp._requests.Remove(request);
                await _corpService.UpdateAsync(corpName, corp);
                return Ok();
            }
            return BadRequest();
        }
        [HttpPost("denyRequest")]
        public async Task<ActionResult<string>> DenyRequest([FromForm] string corpName, [FromForm] string request)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            corp._requests.Remove(request);
            await _corpService.UpdateAsync(corpName, corp);
            return Ok();
        }

        [HttpGet("getMods/{corpName}")]
        public async Task<ActionResult<List<string>>> GetMods(string corpName)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            return corp._modules;
        }
        [HttpGet("getUsers/{corpName}")]
        public async Task<ActionResult<List<string>>> GetUsers(string corpName)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            return corp._users;
        }
        [HttpPost("containsUser")]
        public async Task<ActionResult<string>> ContainsUser([FromForm] string corpName, [FromForm] string userName)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            if(corp._users.Contains(userName))
                return Ok();
            return BadRequest();
        }
        [HttpGet("getRequests/{corpName}")]
        public async Task<ActionResult<List<string>>> GetRequests(string corpName)
        {
            Corporation? corp = await _corpService.GetAsync(corpName);
            if(corp is null)
                return BadRequest();
            return corp._requests;
        }
    }
}