using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
[BsonIgnoreExtraElements]
public class User{
    public string? _userName { get; set; }
    public string? _firstName { get; set; }
    public string? _lastName { get; set; } 
    public string? _userPassword { get; set; }
    public string? _userEmail { get; set; }
    public string? _userRole { get; set; }

    public override string ToString()
    {
        return $"{_userName}, {_userPassword}, {_userEmail}, {_userRole}";
    }
}