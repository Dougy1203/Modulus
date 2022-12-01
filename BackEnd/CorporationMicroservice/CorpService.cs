using Microsoft.Extensions.Options;
using MongoDB.Driver;
using MongoDB.Bson;

public class CorpService
{
    private readonly IMongoCollection<Corporation> _CorpCollection;

    public CorpService(IOptions<DB> corpDbSettings)
    {
        var client = new MongoClient(corpDbSettings.Value.ConnectionString);
        var database = client.GetDatabase(corpDbSettings.Value.DatabaseName);
        _CorpCollection = database.GetCollection<Corporation>(corpDbSettings.Value.CollectionName);
    }
    
    public async Task<Corporation?> GetAsync(string name) => await _CorpCollection.Find(Corp => Corp._name == name).FirstOrDefaultAsync();
    public async Task CreateAsync(Corporation newCorp) => await _CorpCollection.InsertOneAsync(newCorp);
    public async Task UpdateAsync(string name, Corporation upCorp) =>
        await _CorpCollection.ReplaceOneAsync(corp => corp._name == name, upCorp);
    public async Task RemoveAsync(string name) => await _CorpCollection.DeleteOneAsync(corp => corp._name == name);

}