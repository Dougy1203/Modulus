using System.Net.Mail;
using System.Net;
using OpenPop.Mime;
using OpenPop.Pop3;
using Newtonsoft;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.Mvc;

public class BLL
{
    // byte[] key = GetSHA1KeyFromPassword("LD_Capstone_Emails");

    /////////////Email//////////////
    

    ////////////////////////Encryption////////////////////
    static byte[] GetSHA1KeyFromPassword(string password)
    {
        using (SHA1 sha1Hash = SHA1.Create())
        {
            byte[] sourceBytes = Encoding.UTF8.GetBytes(password);
            byte[] hashBytes = sha1Hash.ComputeHash(sourceBytes);
            // Console.Write(hashBytes);

            return hashBytes.Take(16).ToArray();
        }
    }

    public string Encrypt(string plainText, string password)
    {
        byte[] key = GetSHA1KeyFromPassword(password);
        using (var aes = Aes.Create())
        {
            byte[] encoded = Encoding.UTF8.GetBytes(plainText);
            aes.Key = key;
            byte[] encrypted = aes.EncryptEcb(encoded, PaddingMode.PKCS7);
            return Convert.ToBase64String(encrypted);
        }
    }

    public string Decrypt(string base64, string password)
    {
        byte[] key = GetSHA1KeyFromPassword(password);
        using (var aes = Aes.Create())
        {
            var decoded = Convert.FromBase64String(base64);
            aes.Key = key;
            byte[] decrypted = aes.DecryptEcb(decoded, PaddingMode.PKCS7);
            return Encoding.ASCII.GetString(decrypted);
        }
    }
}