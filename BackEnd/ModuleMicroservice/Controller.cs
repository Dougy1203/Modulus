using Microsoft.AspNetCore.Mvc;
using System;
using System.Net;
using System.Security.Cryptography;


namespace Controllers
{
    [ApiController]
    [Route("mod")]
    public class Controller : ControllerBase
    {
        private readonly ModService _modService;
        public Controller(ModService service)
        {
            _modService = service;
        }
 

        [HttpPost("addMod")]
        public async Task<ActionResult<Mod>> NewCorp([FromForm] Mod mod)
        {
            await _modService.CreateAsync(mod);
            return mod;
        }
        [HttpPost("createMod")]
        public async Task<ActionResult<string>> CreateMod([FromForm] string modName)
        {
            Mod mod = new Mod(modName);
            if(mod is null)
                return BadRequest();
            await _modService.CreateAsync(mod);
            return Ok();
        }
        [HttpPost("removeMod")]
        public async Task<ActionResult<Mod>> RemoveMod([FromForm] string modName, [FromForm] string entryName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            mod._modules.Remove(entryName);
            await _modService.UpdateAsync(modName, mod);
            return mod;
        }

        [HttpGet("getMod")]
        public async Task<ActionResult<Mod>> GetCorp([FromForm] string modName)
        {
            var mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            Console.WriteLine(mod.ToString());
            return mod;
        }

        [HttpPost("updateModName")]
        public async Task<ActionResult<Mod>> UpdateModName([FromForm] string modName, [FromForm] string newName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            mod._name = newName;
            await _modService.UpdateAsync(modName, mod);
            return mod;
        }

        [HttpPost("addFile")]
        public async Task<ActionResult<Mod>> AddFile([FromForm] string modName, [FromForm] string entryKey, [FromForm] string entryValue)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            mod._files[entryKey] = entryValue;
            await _modService.UpdateAsync(modName, mod);
            return mod;
        }
        [HttpPost("removeFile")]
        public async Task<ActionResult<Mod>> RemoveFile([FromForm] string modName, [FromForm] string entryName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            mod._files.Remove(entryName);
            await _modService.UpdateAsync(modName, mod);
            return mod;
        }
        [HttpPost("addRole")]
        public async Task<ActionResult<Mod>> AddRole([FromForm] string modName, [FromForm] string entryName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            mod._roles.Add(entryName);
            await _modService.UpdateAsync(modName, mod);
            return mod;
        }
        [HttpPost("removeRole")]
        public async Task<ActionResult<Mod>> RemoveRole([FromForm] string modName, [FromForm] string entryName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            mod._roles.Remove(entryName);
            await _modService.UpdateAsync(modName, mod);
            return mod;
        }
        [HttpPost("addM2M")]
        public async Task<ActionResult<Mod>> AddMod([FromForm] string modName, [FromForm] string entryName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            Mod? mod2 = await _modService.GetAsync(entryName);
            if(mod is null)
                return BadRequest();
            if(mod2 is null)
                return BadRequest();
            mod._modules.Add(entryName);
            await _modService.UpdateAsync(modName, mod);
            return mod;
        }
        [HttpGet("getRoles/{modName}")]
        public async Task<ActionResult<List<string>>> GetRoles(string modName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            return mod._roles;
        }
        [HttpGet("getFiles/{modName}")]
        public async Task<ActionResult<Dictionary<string,string>>> GetFiles(string modName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            return mod._files;
        }
        [HttpGet("getModules/{modName}")]
        public async Task<ActionResult<List<string>>> GetModules(string modName)
        {
            Mod? mod = await _modService.GetAsync(modName);
            if(mod is null)
                return BadRequest();
            return mod._modules;
        }

        static string RSAEncrypt(string body, User user)
        {
            string publicKeyFile = user.publicKey;
        
            byte[] bytesToEncrypt = Encoding.Unicode.GetBytes(body);
            byte[] bytesEncrypted;
            string base64;
        
            using (var rsa = RSA.Create())
            {
                rsa.ImportFromPem(File.ReadAllText(publicKeyFile).Trim());
                bytesEncrypted = rsa.Encrypt(bytesToEncrypt, RSAEncryptionPadding.Pkcs1);
                base64 = Convert.ToBase64String(bytesEncrypted);
            }
            return base64;
        }
        
        static string RSADecrypt(User user, string body)
        {
            string privateKeyFile = user.privateKey;
            string base64 = body;
            byte[] bytesEncrypted = Convert.FromBase64String(base64);
            byte[] bytesDecrypted;
            string msg;
        
            using (var rsa = RSA.Create())
            {
                rsa.ImportFromPem(File.ReadAllText(privateKeyFile).Trim());
                bytesDecrypted = rsa.Decrypt(bytesEncrypted, RSAEncryptionPadding.Pkcs1);
                msg = Encoding.Unicode.GetString(bytesDecrypted);
            }
            return msg;
        }
    }
}