using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

[BsonIgnoreExtraElements]
public class Corporation
{
    // [BsonId]
    // [BsonRepresentation(BsonType.ObjectId)]
    public string _name {get; set;} = "";
    public string _email {get; set;} = "";
    public string _password {get; set;} = "";
    public List<string> _users = new List<string>();
    public List<string> _modules = new List<string>();
    public List<string> _requests = new List<string>();

    // [BsonExtraElements]
    // public object[]? _extras {get; set;}

    public override string ToString()
    {
        return $"{_name},{_password}, {_email}, {_users}";
    }
}