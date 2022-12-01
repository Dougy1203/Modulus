using Microsoft.Extensions.Options;
using MongoDB.Driver;

public class ModService
{
    private readonly IMongoCollection<Mod> _ModCollection;

    public ModService(IOptions<DB> modDbSettings)
    {
        var client = new MongoClient(modDbSettings.Value.ConnectionString);
        var database = client.GetDatabase(modDbSettings.Value.DatabaseName);
        _ModCollection = database.GetCollection<Mod>(modDbSettings.Value.CollectionName);
    }

    public async Task<Mod?> GetAsync(string name) => await _ModCollection.Find(Mod => Mod._name == name).FirstOrDefaultAsync();
    public async Task CreateAsync(Mod newMod) => await _ModCollection.InsertOneAsync(newMod);

    public async Task UpdateAsync(string name, Mod upMod) =>
        await _ModCollection.ReplaceOneAsync(mod => mod._name == name, upMod);
    public async Task RemoveAsync(string name) => await _ModCollection.DeleteOneAsync(mod => mod._name == name);

}