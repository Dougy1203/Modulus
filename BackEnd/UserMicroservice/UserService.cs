using Microsoft.Extensions.Options;
using MongoDB.Driver;
using MongoDB.Bson;

public class UserService
{
    private readonly IMongoCollection<User> _UserCollection;

    public UserService(IOptions<DB> userDbSettings)
    {
        var client = new MongoClient(userDbSettings.Value.ConnectionString);
        var database = client.GetDatabase(userDbSettings.Value.DatabaseName);
        _UserCollection = database.GetCollection<User>(userDbSettings.Value.CollectionName);
    }
    
    public async Task<User?> GetAsync(string name) => await _UserCollection.Find(User => User._userName == name).FirstOrDefaultAsync();
    public async Task CreateAsync(User user) => await _UserCollection.InsertOneAsync(user);
    public async Task UpdateAsync(string name, User newUser) =>
        await _UserCollection.ReplaceOneAsync(user => user._userName == name, newUser);
    public async Task RemoveAsync(string name) => await _UserCollection.DeleteOneAsync(user => user._userName == name);

}