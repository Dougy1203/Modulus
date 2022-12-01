using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

[BsonIgnoreExtraElements]
public class Mod{
    public Mod(string modName)
    {
        this._name = modName;
    }
    public string? _name {get; set;}
    public List<string> _roles = new List<string>{"ADMIN"};
    public Dictionary<string,string> _files = new Dictionary<string, string>();
    public List<string> _modules = new List<string>();

    public override string ToString()
    {
        string roles = "ROLES: ";
        string files = "FILES: ";
        string modules = "MODULES: ";
        foreach(String a in _roles)
        {
            roles += a + ", ";
        }
        foreach (KeyValuePair<string,string> a in _files)
        {
            files += a.Key + ", ";
        }
        foreach (String a in _modules)
        {
            modules += a + ", ";
        }

        return $"NAME: {_name} {roles}{files}{modules}";
    }

}