using Microsoft.AspNetCore.Mvc;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;


//"docker_db1": "Server=localhost,1433;database=apidb;User ID= SA;password=abc123!!@;"

namespace Controllers
{
    [ApiController]
    [Route("email")]
    public class Controller : ControllerBase
    {
        [HttpPost("sendEmail")]
        public void SendEmail([FromForm] string? from, [FromForm] string toEmail, [FromForm] string? to, [FromForm] string? subject, [FromForm] string? content)
        {
        string fromAddress = "ldcoding1203@gmail.com";
        string fromPassword = "sihahknhqcgfeuvh";
        MailAddress _from = new MailAddress(fromAddress, from);
        MailAddress _to = new MailAddress(toEmail, to);
        MailMessage mailMessage = new MailMessage(_from, _to);
        mailMessage.Subject = subject;
        mailMessage.Body = @"" + content;
        using (SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587))
        {
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential(fromAddress, fromPassword);
            smtp.Send(mailMessage);
        }
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